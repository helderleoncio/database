-- Estudo sobre exclusão de registros do banco de dados:

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