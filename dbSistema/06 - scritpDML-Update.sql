-- Estudo sobre atualização de registros do banco de dados:

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