-- Cria uma view que exibe os dados dos produtos:
CREATE VIEW vw_viewProdutos AS
SELECT PRO_CODIGO, PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT 
from tbProduto;

-- Cria uma view que exibe alguns dados dos clientes:
CREATE VIEW vw_viewClientes AS
SELECT CLI_CODIGO, CLI_NOME, CLI_RUA, CLI_NUMERO, CLI_BAIRRO
FROM tbCliente;

-- Consultar os dados armazenados na view:
SELECT * FROM vw_viewProdutos;
SELECT * FROM vw_viewClientes;

-- Altera uma view existente, adicionando o CPF do cliente:
CREATE OR REPLACE VIEW vw_viewClientes AS
SELECT CLI_CODIGO, CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO
FROM tbCliente;

-- Altera a view, renomear as colunas e exibir apenas os clientes
-- cujo nome inicia com "GA":
CREATE OR REPLACE VIEW vw_viewClientes2 AS
SELECT 
    CLI_CODIGO AS Codigo,
    CLI_NOME AS Nome,
    CLI_CPF AS CPF
FROM tbCliente
WHERE CLI_NOME LIKE 'GA%';

-- Altera o nome de um cliente específico:
UPDATE tbCliente
SET CLI_NOME = 'Gabriela Leoncio'
WHERE CLI_CODIGO = 14;

-- Cria uma view que exibe os pedidos realizados pelo vendedor de código 2:
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

-- Consulta os dados armazenados na view:
SELECT * FROM vw_PedidoVendedor;

-- Altera ou recriar a view utilizando apelidos (aliases) para as tabelas:
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

-- Altera o código do vendedor chamado "Luis Gustavo" para 6:
UPDATE tbVendedor
SET VEN_CODIGO = 6
WHERE VEN_NOME = 'Luis Gustavo';

-- Criar uma view que exibe os produtos com preço acima da média:
CREATE VIEW vw_MediaPrecoProdutos AS
SELECT 
    p.PRO_NOME AS Nome_Produto, 
    p.PRO_PRECO_UNIT AS Preco_Unitario
FROM tbProduto AS p
WHERE p.PRO_PRECO_UNIT > (
    SELECT AVG(PRO_PRECO_UNIT) 
    FROM tbProduto
);

-- Exibe informações sobre as VIEW's do Banco de Dados
SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW';
SHOW FULL TABLES IN dbSistema WHERE TABLE_TYPE LIKE 'VIEW';
SELECT TABLE_SCHEMA, TABLE_NAME FROM information_schema.TABLES WHERE TABLE_TYPE LIKE 'VIEW';

-- Apagar as views:
DROP VIEW vw_viewClientes;