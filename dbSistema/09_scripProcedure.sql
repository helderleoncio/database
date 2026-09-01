-- Cria uma procedure que consulta e exibe os dados dos clientes
-- armazenados na view vw_viewClientes:
DELIMITER $$
	CREATE PROCEDURE spRelatorioClientes()
	BEGIN
		SELECT * FROM vw_viewClientes;
	END $$
DELIMITER ;

-- Executa a procedure spRelatorioClientes:
CALL spRelatorioClientes();

-- Cria uma procedure que consulta uma quantidade limitada de produtos,
-- definida pelo parâmetro de entrada QTD:
DELIMITER $$
CREATE PROCEDURE spConsultaProdutos(IN QTD INT)
	BEGIN
		SELECT * FROM tbProduto LIMIT QTD;
	END $$
DELIMITER ;

-- Executa a procedure exibindo os 10 primeiros produtos:
CALL spConsultaProdutos(10);

-- Cria uma procedure que consulta uma quantidade de produtos.
-- Caso QTD seja NULL, exibe todos os produtos:
DELIMITER $$

CREATE PROCEDURE spConsultaProdutos2(IN QTD INT)
BEGIN
    IF QTD IS NULL THEN
        SELECT * FROM tbProduto;
    ELSE
        SELECT * FROM tbProduto LIMIT QTD;
    END IF;
END $$

DELIMITER ;

-- Exibe os 10 primeiros produtos:
CALL spConsultaProdutos2(10);

-- Exibe todos os produtos:
CALL spConsultaProdutos2(NULL);

-- Cria uma procedure que conta a quantidade total de produtos
-- e armazena o resultado no parâmetro de saída QTD:
DELIMITER $$
CREATE PROCEDURE spContarProdutos(OUT QTD INT)
BEGIN
    SELECT COUNT(*) INTO QTD 
    FROM tbProduto;
END $$
DELIMITER ;

-- Executa a procedure e armazena o resultado na variável @QTD:
CALL spContarProdutos(@QTD);
-- Exibe a quantidade de produtos armazenada na variável @QTD:
SELECT @QTD;

-- Cria uma procedure que calcula o valor total das compras
-- realizadas por um determinado cliente:
DELIMITER $$
CREATE PROCEDURE spTotalVendasCliente(
    IN P_CLI_CODIGO INT,
    OUT TOT_VENDAS DECIMAL(10,2)
)
BEGIN
    SELECT COALESCE(SUM(PP.PEP_QTDE * PR.PRO_PRECO_UNIT), 0)
    INTO TOT_VENDAS
    FROM tbPedido AS P
    INNER JOIN tbPedidoProduto AS PP
        ON P.PED_CODIGO = PP.PED_CODIGO
    INNER JOIN tbProduto AS PR
        ON PP.PRO_CODIGO = PR.PRO_CODIGO
    WHERE P.CLI_CODIGO = P_CLI_CODIGO;
END $$
DELIMITER ;

-- Executa a procedure para calcular o total de vendas do cliente de código 1:
CALL spTotalVendasCliente(100, @TOTAL);

-- Exibe o valor total das compras realizadas pelo cliente:
SELECT @TOTAL;

-- Cria uma procedure que lista todos os pedidos
-- realizados por um determinado cliente:
DELIMITER $$
CREATE PROCEDURE spListarPedidosCliente(IN P_CLI_CODIGO INT)
BEGIN
    SELECT *
    FROM tbPedido
    WHERE CLI_CODIGO = P_CLI_CODIGO;
END $$
DELIMITER ;

-- Executa a procedure e exibe os pedidos do cliente de código 1:
CALL spListarPedidosCliente(1);


-- Cria uma procedure que lista os pedidos de um cliente,
-- exibindo também o nome do cliente:
DELIMITER $$
CREATE PROCEDURE spListarPedidosCliente2(IN P_CLI_CODIGO INT)
BEGIN
    SELECT 
        P.PED_CODIGO,
        P.PED_DATA,
        C.CLI_CODIGO,
        C.CLI_NOME
    FROM tbPedido AS P
    INNER JOIN tbCliente AS C
        ON P.CLI_CODIGO = C.CLI_CODIGO
    WHERE P.CLI_CODIGO = P_CLI_CODIGO;
END $$
DELIMITER ;

-- Exibe os pedidos realizados pelo cliente de código 1:
CALL spListarPedidosCliente2(1);

-- Adiciona à tabela de pedidos um campo para armazenar o status:
ALTER TABLE tbPedido
ADD PED_STATUS VARCHAR(20) DEFAULT 'pendente';

-- Exibe os pedidos com seus respectivos status:
SELECT PED_CODIGO, PED_DATA, PED_STATUS
FROM tbPedido;

-- Cria uma procedure que atualiza para "concluído" o status
-- dos pedidos que possuem mais dias que o valor informado:
DELIMITER $$
CREATE PROCEDURE spAtualizarStatusPedidos(IN P_DIAS INT)
BEGIN
    UPDATE tbPedido
    SET PED_STATUS = 'concluído'
    WHERE DATEDIFF(CURDATE(), PED_DATA) > P_DIAS;
END $$
DELIMITER ;

-- Atualiza para "concluído" os pedidos realizados há mais de 30 dias
-- Um pedido feito há 40 dias passaria para: concluído
-- Um pedido feito há apenas 10 dias continuaria como: pendente
CALL spAtualizarStatusPedidos(30);

-- Exibe todas as stored procedures criadas:
SHOW PROCEDURE STATUS;

-- Apagar as stored procedures criadas:
DROP VIEW spRelatorioClientes;