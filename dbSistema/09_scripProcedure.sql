DELIMITER $$
	CREATE PROCEDURE spRelatorioClientes()
	BEGIN
		SELECT * FROM tbCliente;
	END $$
DELIMITER ;

CALL spRelatorioClientes();


DELIMITER $$
CREATE PROCEDURE exibir_produtos(IN QTD INT)
	BEGIN
		SELECT * FROM tbProduto LIMIT QTD;
	END $$
DELIMITER ;

CALL exibir_produtos(10);

DELIMITER $$
CREATE PROCEDURE contar_produtos(OUT QTD INT)
BEGIN
	SELECT COUNT(*) INTO QTD FROM tbProduto;
END $$
DELIMITER ;

CALL contar_produtos(@QTD);
SELECT @QTD;

