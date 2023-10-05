select * from tbProduto;
select * from tbPedidoProduto;

delete from tbProduto where PRO_CODIGO = 1;

DELIMITER $$
	CREATE TRIGGER tg_excluir_produto
	BEFORE DELETE ON tbProduto
		FOR EACH ROW
        BEGIN
			DELETE FROM tbPedidoProduto WHERE PRO_CODIGO = OLD.PRO_CODIGO;
	END $$
DELIMITER ;

DROP TRIGGER IF EXISTS dbSistema.tg_excluir_produto;