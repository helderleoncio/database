-- Exclua os seguintes registros do banco de dados:

-- 1. Da tbPedido o registro de número 1
DELETE FROM tbPedido WHERE PED_CODIGO=1;

-- 2. Da tbPedido onde a data está entre 04/06/2017 a 03/03/2018
DELETE FROM tbPedido WHERE PED_DATA BETWEEN '2017/06/04' AND '2018/03/03';

-- 3. Na tbCliente cujo nome começa com J.
DELETE FROM tbCliente WHERE CLI_NOME LIKE 'J%';

-- 4. Quando o bairro é Centro, Copacabana, Ipanema e Jardim Botânico.
DELETE FROM tbCliente WHERE CLI_BAIRRO IN ('Centro', 'Copacabana', 'Ipanema', 'Jardim Botânico');

-- 5. Onde o vendedor cujo código é 1 ou o nome termina com o.
DELETE FROM tbVendedor WHERE VEN_CODIGO = 1 OR VEN_NOME LIKE '%o';

-- Atualize os registros abaixo do Bando de Dados:

-- 1. A unidade do produto Leite para Leite Denatado.
UPDATE tbProduto SET PRO_NOME = 'Leite Desnatado' WHERE PRO_NOME = 'Leite';

-- 2. Os clientes que começam com J para o Bairro: Centro.
UPDATE tbCliente SET CLI_BAIRRO = 'Centro' WHERE CLI_NOME LIKE 'J%';

-- 3. O cliente cujo no número  > 700 para Nº nulo.
UPDATE tbCliente SET CLI_NUMERO = NULL WHERE CLI_NUMERO > 700;

-- 4. O cliente Pedro Carvalho para CPF 925468713000 e o Endereço: Rua da lama, Nº: 100.
UPDATE tbCliente SET CLI_CPF = '925468713000', CLI_RUA='Rua da lama', CLI_NUMERO=100, 
	CLI_BAIRRO = 'Centro' WHERE CLI_NOME='Pedro Carvalho';

-- 5. Almentar a quantidade em produtos são iguais a 1 para 10
UPDATE tbProduto SET PRO_QTDE = 20 WHERE PRO_QTDE = 10;

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
