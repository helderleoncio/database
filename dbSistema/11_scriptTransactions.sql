-- =====================================================================
-- TRANSAÇÕES EM MYSQL
-- Banco: dbSistema
-- Disciplina: Banco de Dados II
--
-- Objetivos:
--   1) Verificar e compreender o autocommit.
--   2) Demonstrar ROLLBACK e COMMIT.
--   3) Demonstrar SAVEPOINT.
--   4) Tratar erros em transações dentro de Stored Procedures.
--   5) Demonstrar atomicidade em tabelas relacionadas:
--      tbPedido e tbPedidoProduto.
-- =====================================================================

USE dbSistema;

-- =====================================================================
-- 0. DIAGNÓSTICO INICIAL
-- =====================================================================

-- Verifica o estado atual do autocommit:
SELECT @@autocommit AS autocommit_atual;
-- 1 = ligado
-- 0 = desligado

-- Confere o mecanismo de armazenamento das tabelas usadas nos exemplos.
-- Para transações, o esperado é InnoDB.
SELECT
    TABLE_NAME,
    ENGINE
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN (
      'tbCliente',
      'tbPedido',
      'tbPedidoProduto',
      'tbProduto',
      'tbVendedor'
  )
ORDER BY TABLE_NAME;


-- =====================================================================
-- 1. EXEMPLO: ROLLBACK
-- Objetivo: provar que uma alteração feita dentro da transação pode
-- ser completamente desfeita.
-- =====================================================================

-- Remove apenas um eventual registro de teste de execução anterior.
DELETE FROM tbCliente
WHERE CLI_CPF = '999000000001';

START TRANSACTION;

    INSERT INTO tbCliente
        (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
    VALUES
        ('CLIENTE_TESTE_ROLLBACK',
         '999000000001',
         'Rua da Transacao',
         100,
         'Centro');

    -- Durante a transação, a própria sessão consegue enxergar o registro:
    SELECT
        CLI_CODIGO,
        CLI_NOME,
        CLI_CPF
    FROM tbCliente
    WHERE CLI_CPF = '999000000001';

-- Desfaz o INSERT:
ROLLBACK;

-- Esperado: nenhuma linha.
SELECT
    CLI_CODIGO,
    CLI_NOME,
    CLI_CPF
FROM tbCliente
WHERE CLI_CPF = '999000000001';


-- =====================================================================
-- 2. EXEMPLO: COMMIT
-- Objetivo: confirmar permanentemente uma alteração.
-- =====================================================================

DELETE FROM tbCliente
WHERE CLI_CPF = '999000000002';

START TRANSACTION;

    INSERT INTO tbCliente
        (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
    VALUES
        ('CLIENTE_TESTE_COMMIT',
         '999000000002',
         'Avenida do Commit',
         200,
         'Centro');

COMMIT;

-- Esperado: 1 linha persistida.
SELECT
    CLI_CODIGO,
    CLI_NOME,
    CLI_CPF
FROM tbCliente
WHERE CLI_CPF = '999000000002';


-- =====================================================================
-- 3. EXEMPLO: SAVEPOINT
-- Objetivo: desfazer apenas parte da transação.
-- =====================================================================

DELETE FROM tbCliente
WHERE CLI_CPF IN ('999000000003', '999000000004');

START TRANSACTION;

    -- Este registro será mantido.
    INSERT INTO tbCliente
        (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
    VALUES
        ('CLIENTE_ANTES_SAVEPOINT',
         '999000000003',
         'Rua do Savepoint',
         300,
         'Centro');

    SAVEPOINT sp_apos_primeiro_cliente;

    -- Este registro será desfeito.
    INSERT INTO tbCliente
        (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
    VALUES
        ('CLIENTE_DEPOIS_SAVEPOINT',
         '999000000004',
         'Rua do Savepoint',
         301,
         'Centro');

    -- Desfaz somente o que ocorreu depois do SAVEPOINT:
    ROLLBACK TO SAVEPOINT sp_apos_primeiro_cliente;

    RELEASE SAVEPOINT sp_apos_primeiro_cliente;

COMMIT;

-- Esperado:
--   CPF 999000000003 -> existe
--   CPF 999000000004 -> não existe
SELECT
    CLI_CODIGO,
    CLI_NOME,
    CLI_CPF
FROM tbCliente
WHERE CLI_CPF IN ('999000000003', '999000000004')
ORDER BY CLI_CPF;


-- =====================================================================
-- 4. AUTOCOMMIT
-- Objetivo: visualizar o comportamento descrito na aula.
--
-- START TRANSACTION já suspende temporariamente o autocommit para a
-- transação corrente. Portanto, na prática, não é necessário desligar
-- o autocommit globalmente para usar COMMIT e ROLLBACK.
-- =====================================================================

SELECT @@autocommit AS autocommit_antes;

-- Exemplo didático de alteração do modo da sessão:
SET autocommit = 0;
SELECT @@autocommit AS autocommit_desativado;

-- Nenhuma alteração de dados é feita aqui de propósito.
-- Retorna ao comportamento padrão da sessão:
SET autocommit = 1;
SELECT @@autocommit AS autocommit_reativado;


-- =====================================================================
-- 5. STORED PROCEDURE COM TRATAMENTO DE ERRO
-- Objetivo: garantir que duas operações formem uma única unidade
-- atômica. Se a segunda falhar, a primeira também será desfeita.
--
-- O erro é provocado por uma violação REAL da restrição UNIQUE de
-- CLI_CPF, em vez de utilizar um nome de coluna inexistente.
-- =====================================================================

DELETE FROM tbCliente
WHERE CLI_CPF IN ('999000000005', '999000000006');

DROP PROCEDURE IF EXISTS sp_demo_transacao_clientes;

DELIMITER $$

CREATE PROCEDURE sp_demo_transacao_clientes(IN p_forcar_erro BOOLEAN)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT
            'ROLLBACK executado: nenhuma operação da transação foi persistida.'
            AS Resultado;
    END;

    START TRANSACTION;

        INSERT INTO tbCliente
            (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
        VALUES
            ('CLIENTE_PROC_1',
             '999000000005',
             'Rua da Procedure',
             500,
             'Centro');

        IF p_forcar_erro THEN
            -- Gera erro de chave UNIQUE propositalmente:
            INSERT INTO tbCliente
                (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
            VALUES
                ('CLIENTE_PROC_ERRO',
                 '999000000005',
                 'Rua da Procedure',
                 501,
                 'Centro');
        ELSE
            INSERT INTO tbCliente
                (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO)
            VALUES
                ('CLIENTE_PROC_2',
                 '999000000006',
                 'Rua da Procedure',
                 502,
                 'Centro');
        END IF;

    COMMIT;

    SELECT
        'COMMIT executado: todas as operações foram persistidas.'
        AS Resultado;
END $$

DELIMITER ;

-- ---------------------------------------------------------------------
-- 5.1 Teste com erro
-- ---------------------------------------------------------------------
CALL sp_demo_transacao_clientes(TRUE);

-- Esperado: 0 linhas, pois a duplicidade de CPF força ROLLBACK.
SELECT
    CLI_CODIGO,
    CLI_NOME,
    CLI_CPF
FROM tbCliente
WHERE CLI_CPF IN ('999000000005', '999000000006');

-- ---------------------------------------------------------------------
-- 5.2 Teste sem erro
-- ---------------------------------------------------------------------
CALL sp_demo_transacao_clientes(FALSE);

-- Esperado: 2 linhas persistidas.
SELECT
    CLI_CODIGO,
    CLI_NOME,
    CLI_CPF
FROM tbCliente
WHERE CLI_CPF IN ('999000000005', '999000000006')
ORDER BY CLI_CPF;


-- =====================================================================
-- 6. TRANSAÇÃO EM TABELAS RELACIONADAS
-- Objetivo: demonstrar a atomicidade usando o modelo do sistema:
--
-- tbCliente ----< tbPedido >---- tbVendedor
--                    |
--                    v
--             tbPedidoProduto >---- tbProduto
--
-- O pedido e seu item devem ser gravados juntos. Caso o item falhe,
-- o pedido recém-criado também deve ser desfeito.
--
-- Se as triggers do arquivo 10_scripTrigger.sql estiverem instaladas,
-- eventuais atualizações de estoque disparadas por trigger também
-- pertencem à mesma transação e serão desfeitas no ROLLBACK.
-- =====================================================================

DROP PROCEDURE IF EXISTS sp_demo_pedido_atomico;

DELIMITER $$

CREATE PROCEDURE sp_demo_pedido_atomico(IN p_forcar_erro BOOLEAN)
BEGIN
    DECLARE v_cli_codigo INT DEFAULT NULL;
    DECLARE v_ven_codigo INT DEFAULT NULL;
    DECLARE v_pro_codigo INT DEFAULT NULL;
    DECLARE v_ped_codigo INT DEFAULT NULL;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT
            'ROLLBACK: pedido e itens não foram persistidos.'
            AS Resultado;
    END;

    START TRANSACTION;

        -- Seleciona registros existentes para respeitar as chaves
        -- estrangeiras do modelo.
        SELECT MIN(CLI_CODIGO)
        INTO v_cli_codigo
        FROM tbCliente;

        SELECT MIN(VEN_CODIGO)
        INTO v_ven_codigo
        FROM tbVendedor;

        -- FOR UPDATE bloqueia a linha escolhida durante esta transação,
        -- ajudando a evitar alterações concorrentes no mesmo produto.
        SELECT PRO_CODIGO
        INTO v_pro_codigo
        FROM tbProduto
        WHERE PRO_QTDE > 0
        ORDER BY PRO_CODIGO
        LIMIT 1
        FOR UPDATE;

        IF v_cli_codigo IS NULL
           OR v_ven_codigo IS NULL
           OR v_pro_codigo IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                    'É necessário existir cliente, vendedor e produto com estoque.';
        END IF;

        INSERT INTO tbPedido
            (PED_DATA, CLI_CODIGO, VEN_CODIGO)
        VALUES
            (CURDATE(), v_cli_codigo, v_ven_codigo);

        SET v_ped_codigo = LAST_INSERT_ID();

        INSERT INTO tbPedidoProduto
            (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
        VALUES
            (v_ped_codigo, v_pro_codigo, 1);

        IF p_forcar_erro THEN
            -- Código de produto propositalmente inexistente.
            -- A chave estrangeira (ou uma trigger de validação) deve
            -- causar erro e acionar o handler.
            INSERT INTO tbPedidoProduto
                (PED_CODIGO, PRO_CODIGO, PEP_QTDE)
            VALUES
                (v_ped_codigo, 2147483647, 1);
        END IF;

    COMMIT;

    SELECT
        'COMMIT: pedido e item persistidos com sucesso.' AS Resultado,
        v_ped_codigo AS PED_CODIGO;
END $$

DELIMITER ;

-- ---------------------------------------------------------------------
-- 6.1 Teste com erro
-- Deve ocorrer ROLLBACK de todo o pedido.
-- ---------------------------------------------------------------------
CALL sp_demo_pedido_atomico(TRUE);

-- ---------------------------------------------------------------------
-- 6.2 Teste sem erro
-- Deve ocorrer COMMIT.
-- ---------------------------------------------------------------------
CALL sp_demo_pedido_atomico(FALSE);

-- Exibe os pedidos mais recentes para conferência:
SELECT
    p.PED_CODIGO,
    p.PED_DATA,
    p.CLI_CODIGO,
    p.VEN_CODIGO,
    pp.PEP_CODIGO,
    pp.PRO_CODIGO,
    pp.PEP_QTDE
FROM tbPedido AS p
LEFT JOIN tbPedidoProduto AS pp
    ON pp.PED_CODIGO = p.PED_CODIGO
ORDER BY p.PED_CODIGO DESC
LIMIT 10;