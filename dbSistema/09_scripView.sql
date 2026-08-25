-- 1.0. Para criar uma view que exibe o código e o nome dos clientes:
CREATE VIEW vw_viewNomes AS
SELECT CLI_CODIGO, CLI_NOME
FROM tbCliente;

-- 1.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_viewNomes;

-- 2.0. Para alterar uma view existente, adicionando o CPF do cliente:
CREATE OR REPLACE VIEW vw_viewNomes AS
SELECT CLI_CODIGO, CLI_NOME, CLI_CPF
FROM tbCliente;

-- 2.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_viewNomes;

-- 3.0 Para alterar a view, renomear as colunas e exibir apenas os clientes
-- cujo nome inicia com "GA":
CREATE OR REPLACE VIEW vw_viewNomes AS
SELECT 
    CLI_CODIGO AS Codigo,
    CLI_NOME AS Nome,
    CLI_CPF AS CPF
FROM tbCliente
WHERE CLI_NOME LIKE 'GA%';

-- 3.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_viewNomes;

-- 4.. Para alterar o nome de um cliente específico:
UPDATE tbCliente
SET CLI_NOME = 'Gabriela Leoncio'
WHERE CLI_CODIGO = 14;

-- 4.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_viewNomes;

-- 5.0. Para criar uma view que exibe os pedidos realizados pelo vendedor de código 2:
CREATE VIEW vw_PedidoVendedor AS
SELECT 
    tbPedido.PED_CODIGO AS Codigo_Pedido, 
    tbPedido.PED_DATA AS Data, 
    tbPedido.CLI_CODIGO AS Codigo_Cliente, 
    tbVendedor.VEN_CODIGO AS Codigo_Vendedor, 
    tbVendedor.VEN_NOME AS Vendedor_Nome
FROM tbPedido 
INNER JOIN tbVendedor
    ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO 
WHERE tbVendedor.VEN_CODIGO = 2
WITH CHECK OPTION;

-- 5.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_PedidoVendedor;

-- 6.0. Para alterar ou recriar a view utilizando apelidos (aliases) para as tabelas:
CREATE OR REPLACE VIEW vw_PedidoVendedor AS
SELECT 
    p.PED_CODIGO AS Codigo_Pedido, 
    p.PED_DATA AS Data, 
    p.CLI_CODIGO AS Codigo_Cliente, 
    v.VEN_CODIGO AS Codigo_Vendedor, 
    v.VEN_NOME AS Vendedor_Nome
FROM tbPedido AS p
INNER JOIN tbVendedor AS v
    ON p.VEN_CODIGO = v.VEN_CODIGO 
WHERE v.VEN_CODIGO = 2
WITH CHECK OPTION;

-- 6.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_PedidoVendedor;

-- 7.0 Para alterar o código do vendedor chamado "Luis Gustavo" para 6:
UPDATE tbVendedor
SET VEN_CODIGO = 6
WHERE VEN_NOME = 'Luis Gustavo';

-- 7.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_PedidoVendedor;

-- 8.0 Para criar uma view que exibe os produtos com preço acima da média:
CREATE VIEW vw_Media_Preco_Produtos AS
SELECT 
    p.PRO_NOME AS Nome_Produto, 
    p.PRO_PRECO_UNIT AS Preco_Unitario
FROM tbProduto AS p
WHERE p.PRO_PRECO_UNIT > (
    SELECT AVG(PRO_PRECO_UNIT) 
    FROM tbProduto
);

-- 8.1. Para consultar os dados armazenados na view:
SELECT * FROM vw_Media_Preco_Produtos;

-- 9.0. Exibe informações sobre as VIEW's do Banco de Dados
SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW';
SHOW FULL TABLES IN dbSistema WHERE TABLE_TYPE LIKE 'VIEW';
SELECT TABLE_SCHEMA, TABLE_NAME FROM information_schema.TABLES WHERE TABLE_TYPE LIKE 'VIEW';

-- 10.0. Para apagar a view:
DROP VIEW vw_viewNomes;