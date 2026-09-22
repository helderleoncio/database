-- =====================================================================
-- SCRIPT DE TRIGGERS - dbSistema
-- Disciplina: Banco de Dados II
-- =====================================================================

USE dbSistema;

-- =====================================================================
-- MODELO / SINTAXE
-- =====================================================================
-- DELIMITER $$
--
-- CREATE TRIGGER nome_da_trigger
-- {BEFORE | AFTER} {INSERT | UPDATE | DELETE}
-- ON nome_da_tabela
-- FOR EACH ROW
-- BEGIN
--   -- comandos SQL executados automaticamente
-- END $$
--
-- DELIMITER ;
--
-- Parâmetros:
-- BEFORE: executa antes da mudança.
-- AFTER: executa depois da mudança.
-- FOR EACH ROW: roda uma vez para cada linha afetada.
-- DELIMITER: permite escrever blocos com BEGIN e END.
--
-- NEW: valores novos da linha (disponível em INSERT e UPDATE).
-- OLD: valores antigos da linha (disponível em UPDATE e DELETE).
--
-- Convenção de nomes usada neste arquivo: trg_<tabela>_<evento>_<ação>
-- onde <evento> é bi/bu/bd (before insert/update/delete)
-- ou ai/au/ad (after insert/update/delete).
-- =====================================================================

-- =====================================================================
-- Exemplo 01 - Validar produto antes de cadastrar
-- Objetivo: impedir preço inválido e estoque negativo em tbProduto.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_produto_bi_valida
BEFORE INSERT ON tbProduto
FOR EACH ROW
BEGIN
  IF NEW.PRO_QTDE < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Estoque não pode ser negativo.';
  END IF;

  IF NEW.PRO_PRECO_UNIT <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Preço deve ser maior que zero.';
  END IF;
END $$

DELIMITER ;

-- =====================================================================
-- Teste 01 - trg_produto_bi_valida (BEFORE INSERT tbProduto)
-- =====================================================================
SET @for = (SELECT FOR_CODIGO FROM tbFornecedor LIMIT 1);

-- 1a) Válido - deve inserir normalmente
INSERT INTO tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO)
VALUES ('TESTE_TRIGGER_produto_ok', 10, 'UN', 25.50, @for);
SELECT * FROM tbProduto WHERE PRO_NOME = 'TESTE_TRIGGER_produto_ok';
-- Esperado: 1 linha inserida.

-- 1b) Estoque negativo - deve FALHAR
INSERT INTO tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO)
VALUES ('TESTE_TRIGGER_estoque_neg', -5, 'UN', 25.50, @for);
-- Esperado: erro 1644 "Estoque não pode ser negativo."

-- 1c) Preço zero - deve FALHAR
INSERT INTO tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO)
VALUES ('TESTE_TRIGGER_preco_zero', 10, 'UN', 0, @for);
-- Esperado: erro 1644 "Preço deve ser maior que zero."


-- =====================================================================
-- Exemplo 02 - Validar produto antes de atualizar
-- Objetivo: a mesma regra do Exemplo 01, mas para UPDATE. No MySQL,
-- uma trigger só pode ficar associada a um único evento (INSERT, UPDATE
-- ou DELETE)
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_produto_bu_valida
BEFORE UPDATE ON tbProduto
FOR EACH ROW
BEGIN
  IF NEW.PRO_QTDE < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Estoque não pode ser negativo.';
  END IF;

  IF NEW.PRO_PRECO_UNIT <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Preço deve ser maior que zero.';
  END IF;
END $$

DELIMITER ;

-- =====================================================================
-- Teste 02 - trg_produto_bu_valida (BEFORE UPDATE tbProduto)
-- =====================================================================
SET @prod_teste = (SELECT PRO_CODIGO FROM tbProduto WHERE PRO_NOME = 'TESTE_TRIGGER_produto_ok');

-- 2a) Válido - subir o preço - deve funcionar
UPDATE tbProduto SET PRO_PRECO_UNIT = 30.00 WHERE PRO_CODIGO = @prod_teste;
SELECT PRO_CODIGO, PRO_PRECO_UNIT FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: preço atualizado para 30.00.

-- 2b) Inválido - zerar o preço - deve FALHAR
UPDATE tbProduto SET PRO_PRECO_UNIT = 0 WHERE PRO_CODIGO = @prod_teste;
-- Esperado: erro 1644 "Preço deve ser maior que zero."

-- 2c) Inválido - estoque negativo - deve FALHAR
UPDATE tbProduto SET PRO_QTDE = -1 WHERE PRO_CODIGO = @prod_teste;
-- Esperado: erro 1644 "Estoque não pode ser negativo."

-- =================================================================
-- Exemplo 03 - Validar estoque no item do pedido
-- Objetivo: antes de inserir em tbPedidoProduto, verificar produto,
-- quantidade e estoque.
-- =================================================================
DELIMITER $$

CREATE TRIGGER trg_pedidoproduto_bi_valida
BEFORE INSERT ON tbPedidoProduto
FOR EACH ROW
BEGIN
  DECLARE v_estoque INT;

  SET v_estoque = (
    SELECT COALESCE(MAX(PRO_QTDE), -1)
    FROM tbProduto
    WHERE PRO_CODIGO = NEW.PRO_CODIGO
  );

  IF v_estoque < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto inexistente.';
  END IF;

  IF NEW.PEP_QTDE <= 0 OR NEW.PEP_QTDE > v_estoque THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantidade inválida.';
  END IF;
END $$

DELIMITER ;

-- =====================================================================
-- Teste 03 - trg_pedidoproduto_bi_valida (BEFORE INSERT tbPedidoProduto)
-- =====================================================================
-- Cria um pedido de teste para usar nos próximos testes
SET @cli_teste = (SELECT CLI_CODIGO FROM tbCliente LIMIT 1);
SET @ven_teste = (SELECT VEN_CODIGO FROM tbVendedor LIMIT 1);

INSERT INTO tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO)
VALUES (CURDATE(), @cli_teste, @ven_teste);
SET @ped_teste = LAST_INSERT_ID();

-- Garante estoque conhecido para o produto de teste (10 unidades)
UPDATE tbProduto SET PRO_QTDE = 10 WHERE PRO_CODIGO = @prod_teste;

-- 3a) Produto inexistente - deve FALHAR
INSERT INTO tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
VALUES (@ped_teste, 999999, 1);
-- Esperado: erro 1644 "Produto inexistente."

-- 3b) Quantidade maior que o estoque - deve FALHAR
INSERT INTO tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
VALUES (@ped_teste, @prod_teste, 999);
-- Esperado: erro 1644 "Quantidade inválida."

-- 3c) Quantidade zero - deve FALHAR
INSERT INTO tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
VALUES (@ped_teste, @prod_teste, 0);
-- Esperado: erro 1644 "Quantidade inválida."

-- 3d) Válido - deve inserir (e isso também vai disparar o Teste 05)
INSERT INTO tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
VALUES (@ped_teste, @prod_teste, 3);
SET @pep_teste = LAST_INSERT_ID();
-- Esperado: 1 linha inserida em tbPedidoProduto.

-- =====================================================================
-- Exemplo 04 - Validar estoque ao atualizar o item do pedido
-- Objetivo: se alguém alterar a quantidade de um item já existente,
-- garantir que a nova quantidade ainda cabe no estoque disponível.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_pedidoproduto_bu_valida
BEFORE UPDATE ON tbPedidoProduto
FOR EACH ROW
BEGIN
  DECLARE v_estoque_disponivel INT;

  SET v_estoque_disponivel = (
    SELECT PRO_QTDE
    FROM tbProduto
    WHERE PRO_CODIGO = OLD.PRO_CODIGO
  ) + OLD.PEP_QTDE;

  IF NEW.PEP_QTDE <= 0 OR NEW.PEP_QTDE > v_estoque_disponivel THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantidade inválida para atualização.';
  END IF;
END $$

DELIMITER ;

-- =====================================================================
-- Teste 04 - trg_pedidoproduto_ai_baixa_estoque (AFTER INSERT)
-- =====================================================================
-- O insert válido do Teste 3d já disparou esta trigger.
SELECT PRO_CODIGO, PRO_QTDE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: estoque caiu de 10 para 7 (10 - 3).

-- =====================================================================
-- Exemplo 05 - Baixar estoque após a venda
-- Objetivo: depois de inserir o item do pedido, diminuir
-- automaticamente o estoque em tbProduto.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_pedidoproduto_ai_baixa_estoque
AFTER INSERT ON tbPedidoProduto
FOR EACH ROW
BEGIN
  UPDATE tbProduto
  SET PRO_QTDE = PRO_QTDE - NEW.PEP_QTDE
  WHERE PRO_CODIGO = NEW.PRO_CODIGO;
END $$

DELIMITER ;

-- Teste: se PRO_QTDE = 20 e NEW.PEP_QTDE = 3, o produto passa a ter 17 unidades.

-- =====================================================================
-- Teste 05 - trg_pedidoproduto_bu_valida (BEFORE UPDATE tbPedidoProduto)
-- =====================================================================
-- Estoque disponível agora = 7 (atual) + 3 (já reservado por este item) = 10

-- 5a) Válido - subir a quantidade para 8 (dentro do disponível) - deve funcionar
UPDATE tbPedidoProduto SET PEP_QTDE = 8 WHERE PEP_CODIGO = @pep_teste;
SELECT PEP_CODIGO, PEP_QTDE FROM tbPedidoProduto WHERE PEP_CODIGO = @pep_teste;
-- Esperado: quantidade atualizada para 8.

-- 5b) Inválido - pedir mais do que o disponível - deve FALHAR
UPDATE tbPedidoProduto SET PEP_QTDE = 999 WHERE PEP_CODIGO = @pep_teste;
-- Esperado: erro 1644 "Quantidade inválida para atualização."

-- =====================================================================
-- Exemplo 06 - Ajustar estoque ao alterar quantidade
-- Objetivo: se a quantidade de um item for alterada, ajustar o
-- estoque pela diferença.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_pedidoproduto_au_ajusta_estoque
AFTER UPDATE ON tbPedidoProduto
FOR EACH ROW
BEGIN
  UPDATE tbProduto
  SET PRO_QTDE = PRO_QTDE + OLD.PEP_QTDE - NEW.PEP_QTDE
  WHERE PRO_CODIGO = NEW.PRO_CODIGO;
END $$

DELIMITER ;

-- Teste: se o item muda de 2 para 5 unidades, o estoque reduz mais 3.
-- Teste: se mudar de 5 para 2, o estoque recebe 3 unidades de volta.

-- =====================================================================
-- Teste 06 - trg_pedidoproduto_au_ajusta_estoque (AFTER UPDATE)
-- =====================================================================
-- O update válido do Teste 5a (3 -> 8) já disparou esta trigger.
SELECT PRO_CODIGO, PRO_QTDE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: estoque caiu de 7 para 2 (7 + 3 - 8).

-- Testando o caminho inverso: baixar de 8 para 2 deve devolver 6 ao estoque
UPDATE tbPedidoProduto SET PEP_QTDE = 2 WHERE PEP_CODIGO = @pep_teste;
SELECT PRO_CODIGO, PRO_QTDE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: estoque volta de 2 para 8 (2 + 8 - 2).

-- =====================================================================
-- Exemplo 07 - Devolver estoque ao excluir item
-- Objetivo: ao remover um item de tbPedidoProduto, devolver a
-- quantidade ao estoque do produto.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_pedidoproduto_ad_devolve_estoque
AFTER DELETE ON tbPedidoProduto
FOR EACH ROW
BEGIN
  UPDATE tbProduto
  SET PRO_QTDE = PRO_QTDE + OLD.PEP_QTDE
  WHERE PRO_CODIGO = OLD.PRO_CODIGO;
END $$

DELIMITER ;

-- Observação: usamos OLD porque a linha excluída não possui mais valores NEW.

-- =====================================================================
-- Teste 07 - trg_pedidoproduto_ad_devolve_estoque (AFTER DELETE)
-- =====================================================================
SELECT PRO_QTDE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;  -- valor antes (8)

DELETE FROM tbPedidoProduto WHERE PEP_CODIGO = @pep_teste;

SELECT PRO_QTDE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: estoque volta de 8 para 10 (devolveu as 2 unidades reservadas).

-- =====================================================================
-- Exemplo 08 - Tabela auxiliar de auditoria
-- Objetivo: guardar histórico de alterações no preço unitário de
-- tbProduto.
-- =====================================================================
CREATE TABLE tbProdutoPrecoLog (
  LOG_CODIGO INT AUTO_INCREMENT PRIMARY KEY,
  PRO_CODIGO INT NOT NULL,
  PRECO_ANTIGO DOUBLE(10,2) NOT NULL,
  PRECO_NOVO DOUBLE(10,2) NOT NULL,
  LOG_DATA DATETIME NOT NULL
);

DELIMITER $$

CREATE TRIGGER trg_produto_au_log_preco
AFTER UPDATE ON tbProduto
FOR EACH ROW
BEGIN
  IF OLD.PRO_PRECO_UNIT <> NEW.PRO_PRECO_UNIT THEN
    INSERT INTO tbProdutoPrecoLog
      (PRO_CODIGO, PRECO_ANTIGO, PRECO_NOVO, LOG_DATA)
    VALUES
      (NEW.PRO_CODIGO, OLD.PRO_PRECO_UNIT,
       NEW.PRO_PRECO_UNIT, NOW());
  END IF;
END $$

DELIMITER ;

-- Teste: a trigger só deve registrar quando o preço muda de fato.

-- =====================================================================
-- Teste 08 - trg_produto_au_log_preco (AFTER UPDATE tbProduto)
-- =====================================================================
SELECT COUNT(*) AS logs_antes FROM tbProdutoPrecoLog WHERE PRO_CODIGO = @prod_teste;

-- 8a) Muda o preço - deve gerar um registro de log
UPDATE tbProduto SET PRO_PRECO_UNIT = 45.00 WHERE PRO_CODIGO = @prod_teste;
SELECT * FROM tbProdutoPrecoLog WHERE PRO_CODIGO = @prod_teste ORDER BY LOG_CODIGO DESC LIMIT 1;
-- Esperado: 1 novo registro com PRECO_ANTIGO = 30.00 e PRECO_NOVO = 45.00.

-- 8b) "Atualiza" para o mesmo preço - NÃO deve gerar log
UPDATE tbProduto SET PRO_PRECO_UNIT = 45.00 WHERE PRO_CODIGO = @prod_teste;
SELECT COUNT(*) AS logs_depois FROM tbProdutoPrecoLog WHERE PRO_CODIGO = @prod_teste;
-- Esperado: mesma contagem do passo 8a (nenhum log novo, pois o preço não mudou).

-- =====================================================================
-- Exemplo 09 - Impedir exclusão de cliente com pedidos (NOVO)
-- Objetivo: a FK fk_tbPedido_tbCliente (em 02_dbSistema.sql) NÃO tem
-- ON DELETE CASCADE (diferente da FK de tbVendedor, que tem). Ou seja,
-- hoje excluir um cliente com pedidos já falha - mas com um erro
-- genérico de chave estrangeira. Esta trigger intercepta antes e dá
-- uma mensagem de negócio clara.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_cliente_bd_bloqueia_exclusao
BEFORE DELETE ON tbCliente
FOR EACH ROW
BEGIN
  DECLARE v_qtde_pedidos INT;

  SET v_qtde_pedidos = (
    SELECT COUNT(*) FROM tbPedido WHERE CLI_CODIGO = OLD.CLI_CODIGO
  );

  IF v_qtde_pedidos > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Não é possível excluir cliente com pedidos registrados.';
  END IF;
END $$

DELIMITER ;

-- Teste: tentar excluir um cliente que tenha pedido em tbPedido deve
-- falhar com a mensagem acima; um cliente sem pedidos pode ser excluído.

-- =====================================================================
-- Teste 09 - trg_cliente_bd_bloqueia_exclusao (BEFORE DELETE tbCliente)
-- =====================================================================
-- 9a) Cliente COM pedido (@cli_teste, usado no Teste 03) - deve FALHAR
DELETE FROM tbCliente WHERE CLI_CODIGO = @cli_teste;
-- Esperado: erro 1644 "Não é possível excluir cliente com pedidos registrados."

-- 9b) Cliente SEM pedidos - deve funcionar
INSERT INTO tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
VALUES ('TESTE_TRIGGER_cliente_sem_pedido', '00000000000', 'Rua Teste', 1, 'Bairro Teste');
SET @cli_sem_pedido = LAST_INSERT_ID();

DELETE FROM tbCliente WHERE CLI_CODIGO = @cli_sem_pedido;
SELECT * FROM tbCliente WHERE CLI_CODIGO = @cli_sem_pedido;
-- Esperado: exclusão bem-sucedida; o SELECT acima retorna 0 linhas.

-- =====================================================================
-- Exemplo 10 - Impedir exclusão de produto com pedido pendente
-- (substitui o antigo "Exemplo 08" do arquivo original)
-- Objetivo original: excluir os itens de tbPedidoProduto antes de
-- excluir o produto de tbProduto.
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_produto_bd_bloqueia_exclusao
BEFORE DELETE ON tbProduto
FOR EACH ROW
BEGIN
  DECLARE v_qtde_pendentes INT;

  SET v_qtde_pendentes = (
    SELECT COUNT(*)
    FROM tbPedidoProduto AS pp
    INNER JOIN tbPedido AS p ON pp.PED_CODIGO = p.PED_CODIGO
    WHERE pp.PRO_CODIGO = OLD.PRO_CODIGO
      AND p.PED_STATUS = 'pendente'
  );

  IF v_qtde_pendentes > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Não é possível excluir produto com pedido pendente.';
  END IF;
END $$

DELIMITER ;

-- Teste (ordem corrigida - a trigger precisa existir ANTES do teste):
-- select * from tbProduto;
-- select * from tbPedidoProduto;
-- delete from tbProduto where PRO_CODIGO = 1;
-- Se o produto 1 estiver em algum pedido 'pendente', a exclusão deve
-- falhar. Se não estiver (ou já estiver 'concluído'), a exclusão
-- funciona normalmente e o CASCADE da FK cuida do restante.


-- =====================================================================
-- Teste 10 - trg_produto_bd_bloqueia_exclusao (BEFORE DELETE tbProduto)
-- =====================================================================
-- Garante que o pedido de teste está 'pendente' (status padrão)
SELECT PED_CODIGO, PED_STATUS FROM tbPedido WHERE PED_CODIGO = @ped_teste;

-- Recria um item pendente para o produto de teste, já que o Teste 07 apagou o anterior
INSERT INTO tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
VALUES (@ped_teste, @prod_teste, 1);

-- 10a) Produto COM pedido pendente - deve FALHAR
DELETE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: erro 1644 "Não é possível excluir produto com pedido pendente."

-- 10b) Produto SEM pedidos - deve funcionar (e o cascade da FK não tem nada a fazer)
INSERT INTO tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO)
VALUES ('TESTE_TRIGGER_produto_sem_pedido', 5, 'UN', 10.00, @for);
SET @prod_sem_pedido = LAST_INSERT_ID();

DELETE FROM tbProduto WHERE PRO_CODIGO = @prod_sem_pedido;
SELECT * FROM tbProduto WHERE PRO_CODIGO = @prod_sem_pedido;
-- Esperado: exclusão bem-sucedida; o SELECT acima retorna 0 linhas.

-- 10c) Marcando o pedido como 'concluído' e testando de novo - deve funcionar
UPDATE tbPedido SET PED_STATUS = 'concluído' WHERE PED_CODIGO = @ped_teste;
DELETE FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
SELECT * FROM tbProduto WHERE PRO_CODIGO = @prod_teste;
-- Esperado: agora a exclusão funciona (não há mais pedido 'pendente' para
-- este produto); o CASCADE da FK apaga o item em tbPedidoProduto junto.

-- =====================================================================
-- Consultar e remover as triggers do sistema
-- =====================================================================

-- Exibe todas as triggers criadas no banco:
SHOW TRIGGERS FROM dbSistema;
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'dbSistema';

-- Apagar as triggers criadas neste script
DROP TRIGGER IF EXISTS dbSistema.trg_produto_bi_valida;
DROP TRIGGER IF EXISTS dbSistema.trg_produto_bu_valida;
DROP TRIGGER IF EXISTS dbSistema.trg_pedidoproduto_bi_valida;
DROP TRIGGER IF EXISTS dbSistema.trg_pedidoproduto_bu_valida;
DROP TRIGGER IF EXISTS dbSistema.trg_pedidoproduto_ai_baixa_estoque;
DROP TRIGGER IF EXISTS dbSistema.trg_pedidoproduto_au_ajusta_estoque;
DROP TRIGGER IF EXISTS dbSistema.trg_pedidoproduto_ad_devolve_estoque;
DROP TRIGGER IF EXISTS dbSistema.trg_produto_au_log_preco;
DROP TRIGGER IF EXISTS dbSistema.trg_cliente_bd_bloqueia_exclusao;
DROP TRIGGER IF EXISTS dbSistema.trg_produto_bd_bloqueia_exclusao;

-- =====================================================================
-- Limpeza dos dados de teste
-- =====================================================================
DELETE FROM tbPedido WHERE PED_CODIGO = @ped_teste;
DELETE FROM tbProduto WHERE PRO_NOME LIKE 'TESTE_TRIGGER_%';
DELETE FROM tbCliente WHERE CLI_NOME LIKE 'TESTE_TRIGGER_%';