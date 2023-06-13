-- Estudo sobre seleão de registros do banco de dados:

SELECT * FROM tbCliente;

SELECT CLI_BAIRRO FROM tbCliente WHERE CLI_BAIRRO='Centro';

SELECT distinct CLI_BAIRRO FROM tbCliente WHERE CLI_BAIRRO='Centro';

SELECT * FROM tbCliente WHERE CLI_CODIGO=1 or CLI_CODIGO=2;

SELECT * FROM tbCliente WHERE CLI_CODIGO=1 and CLI_CODIGO=2;

SELECT * FROM tbCliente order by CLI_NOME ASC;

SELECT * FROM tbCliente order by CLI_NOME DESC;

SELECT CLI_NOME as 'Nome do Ciente' FROM tbCliente;

SELECT MIN(CLI_CODIGO) as MENOR_COD FROM tbCliente

SELECT MAX(CLI_CODIGO) MAIOR_COD FROM tbCliente

SELECT COUNT(CLI_CODIGO) as 'Quantidade Clientes'  FROM tbCliente

SELECT AVG(PRO_PRECO_UNIT) FROM tbProduto

SELECT SUM(PRO_QTDE) FROM tbProduto WHERE PRO_UNIDADE='unidade';

SELECT COUNT(*), CLI_CODIGO from tbCliente GROUP BY CLI_CODIGO;

SELECT COUNT(*), PRO_QTDE from tbProduto GROUP BY PRO_QTDE;

SELECT PRO_QTDE, COUNT(*) FROM tbProduto GROUP BY PRO_QTDE HAVING COUNT(*) < 10;

SELECT TOP(10) * FROM tbCliente;

SELECT TOP(50) PERCENT * FROM tbCliente;

SELECT * FROM tbCliente ORDER BY CLI_CODIGO ASC LIMIT=10 ;

SELECT * FROM tbCliente ORDER BY CLI_CODIGO ASC LIMIT 5 OFFSET 10;

-- Retorna todos os registros da tabela da esquerda.
SELECT * FROM tbPedido LEFT JOIN tbVendedor 
                 ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;

SELECT tbPedido.PED_CODIGO, tbPedido.PED_DATA, tbPedido.CLI_CODIGO, 
		tbVendedor.VEN_CODIGO, tbVendedor.VEN_NOME 
	FROM tbPedido LEFT JOIN tbVendedor 
		ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;

-- RIGHT JOIN*: Retorna todos os registros da tabela da direita.
SELECT * FROM tbPedido RIGHT JOIN tbVendedor ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;

SELECT tbPedido.PED_CODIGO, tbPedido.PED_DATA, tbPedido.CLI_CODIGO, 
		tbVendedor.VEN_CODIGO, tbVendedor.VEN_NOME 
	FROM tbPedido RIGHT JOIN tbVendedor 
		ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;
        
-- INNER JOIN*: Retorna todos os registros em comum entre as tabelas.
SELECT * FROM tbPedido INNER JOIN tbVendedor ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;

SELECT tbPedido.PED_CODIGO, tbPedido.PED_DATA, tbPedido.CLI_CODIGO, 
		tbVendedor.VEN_CODIGO, tbVendedor.VEN_NOME 
	FROM tbPedido INNER JOIN tbVendedor 
		ON tbPedido.VEN_CODIGO = tbVendedor.VEN_CODIGO;
        
-- *É necessária uma condição de união (geralmente chaves estrangeiras).
