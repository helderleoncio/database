CREATE VIEW vw_ClientesPedidos
        AS SELECT tbCliente.CLI_NOME AS Cliente, tbPedido.PED_CODIGO AS Pedido FROM tbCliente
			INNER JOIN tbPedido ON tbCliente.CLI_CODIGO = tbPedido.CLI_CODIGO;

 SELECT tbCliente.CLI_NOME AS Cliente, tbPedido.PED_CODIGO AS Pedido FROM tbCliente
			INNER JOIN tbPedido ON tbCliente.CLI_CODIGO = tbPedido.CLI_CODIGO;

SELECT Cliente, Pedido FROM vw_ClientesPedidos ORDER BY Pedido;

SHOW FULL TABLES IN dbsistema WHERE TABLE_TYPE LIKE 'VIEW';

SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW';

SELECT TABLE_SCHEMA, TABLE_NAME FROM information_schema.TABLES WHERE TABLE_TYPE LIKE 'VIEW';

DROP VIEW vw_ClientesPedidos;