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

