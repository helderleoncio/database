CREATE DATABASE dbSistema;

use dbSistema;

CREATE TABLE tbCliente(
	CLI_CODIGO int not null auto_increment,
	CLI_NOME varchar(50) not null, 
	CLI_CPF varchar(15) not null unique,
	CLI_RUA varchar(50) not null,
	CLI_NUMERO int null,
	CLI_BAIRRO varchar(50) not null,
	primary key(CLI_CODIGO)
);

CREATE TABLE tbVendedor(
	VEN_CODIGO int not null auto_increment,
    VEN_NOME varchar(50) not null,
    VEN_CPF varchar(15) not null unique,
    primary key(VEN_CODIGO)
);

CREATE TABLE tbFornecedor(
	FOR_CODIGO int not null auto_increment,
    FOR_RAZAO_SOC varchar(50) not null,
    FOR_CNPJ varchar(20) not null unique,
    FOR_ESPECIALIDADE varchar(50) not null,
    primary key(FOR_CODIGO)
);

CREATE TABLE tbProduto(
	PRO_CODIGO int not null auto_increment,
	PRO_NOME varchar(50) not null,
	PRO_QTDE int not null,
	PRO_UNIDADE varchar(10),
	PRO_PRECO_UNIT double(10,2),
	FOR_CODIGO int not null,
    primary key(PRO_CODIGO),
    constraint fk_tbFornecedor_tbProduto foreign key(FOR_CODIGO) references tbFornecedor(FOR_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbPedido(
	PED_CODIGO int not null auto_increment,
	PED_DATA date,
	CLI_CODIGO int,
	VEN_CODIGO int,
    primary key (PED_CODIGO),
    constraint fk_tbPedido_tbCliente foreign key (CLI_CODIGO) references tbCliente(CLI_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE,
    constraint fk_tbPedido_tbVendedor foreign key (VEN_CODIGO) references tbVendedor(VEN_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbPedidoProduto(
	PEP_CODIGO int not null auto_increment,
	PED_CODIGO int not null,
	PRO_CODIGO int not null,
	PEP_QTDE int not null,
    primary key (PEP_CODIGO),
    constraint fk_tbPedidoProduto_tbPedido foreign key (PED_CODIGO) references tbPedido(PED_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE,
    constraint fk_tbPedidoProduto_tbProduto foreign key (PRO_CODIGO) references tbProduto(PRO_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Cadastro de Clientes --
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Sofia Rodriguez','781630492356','Rua do Sol',123,'Centro');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Lucas Santos','213540289654','Avenida das Flores',456,'Jardim Botânico');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Isabella Silva','846529018364','Rua dos Pinheiros',789,'Pinheiros');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Miguel Almeida','970218634125','Avenida da Praia',234,'Copacabana');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Ana Paula Costa','384769521039','Rua das Palmeiras',567,'Jardim Europa');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Tiago Ferreira','872109346523','Avenida das Dunas',890,'Barra da Tijuca');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Júlia Vieira','457982130964','Rua dos Cravos',123,'Vila Madalena');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Pedro Carvalho','925468713024','Avenida das Gaivotas',456,'Ipanema');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Lara Castro','345671982156','Rua das Acácias',789,'Perdizes');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Guilherme Souza','657890243561','Avenida das Amendoeiras',234,'Lagoa');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Giovanna Oliveira','231490785634','Rua dos Girassóis',567,'Itaim Bibi');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Rafael Pereira','876512093467','Avenida das Mangueiras',890,'Jardim Botânico');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Laura Martins','456389120367','Rua dos Crisântemos',123,'Jardins');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Gabriel Lima','981726304567','Avenida das Palmeiras',456,'Leblon');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Beatriz Gonçalves','456870913284','Rua das Orquídeas',789,'Vila Nova Conceição');

-- Tabela de Vendedores --
insert into tbVendedor (VEN_NOME, VEN_CPF) value ('Gabriel Heleno', '12332156769');
insert into tbVendedor (VEN_NOME, VEN_CPF) value ('Luis Gustavo', '98765498769');
insert into tbVendedor (VEN_NOME, VEN_CPF) value ('Michael Jesson', '99912355612');
insert into tbVendedor (VEN_NOME, VEN_CPF) value ('Fred da Silva', '87999385321');
insert into tbVendedor (VEN_NOME, VEN_CPF) value ('Alsione Arruda', '34112543399');

-- Tabela de Fornecedor --
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Suprimentos Globais', '23.456.789/0002-01', 'Alimentos');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Distribuição Versátil', '34.567.890/0003-02', 'Casa e Banho');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Artigos Essenciais', '45.678.901/0004-03', 'Eletrônicos');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Produtos Multifuncionais', '56.789.012/0005-04', 'Ferramentas');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Fornecedores de Tudo', '67.890.123/0006-05', 'Higiene');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Soluções Abrangentes', '78.901.234/0007-06', 'Iluminação');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Abastecimento Universal', '89.012.345/0008-07', 'Informática');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Importação e Exportação Diversificada', '90.123.456/0009-08', 'Limpeza');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Parcerias de Variedades', '01.234.567/0010-09', 'Papelaria');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Logística de Produtos Variados', '12.345.678/0011-10', 'Temperos');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Mercadorias Abastecidas', '23.456.789/0012-11', 'Utensílios de Cozinha');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Fontes de Produtos Multimarcas', '34.567.890/0013-12', 'Utilidades Domésticas');
insert into tbFornecedor (FOR_RAZAO_SOC, FOR_CNPJ, FOR_ESPECIALIDADE) value ('Ampliações de Estoques', '45.678.901/0014-13', 'Vestuário');

-- Tabela de Produto --
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Açúcar',1, 'kg', 2.49,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Arroz',5, 'kg', 22.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Biscoito',200, 'g', 3.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Cápsulas de Café',10, 'unidade', 7.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Chocolate',100, 'g', 3.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Iogurte',500, 'g', 2.49,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Leite',1, 'L', 3.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Manga',1, 'unidade', 2.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Manteiga',200, 'g', 5.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Molho de Tomate',350, 'g', 1.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Óleo de Cozinha',900, 'mL', 4.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Queijo Mussarela',250, 'g', 7.99,1);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Chuveiro',1, 'unidade', 29.99,2);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Bateria 9V',1, 'unidade', 12.99,3);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Bateria AA',4, 'unidade', 7.99,3);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Fone de Ouvido',1, 'unidade', 39.99,3);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Chave de Fenda',1, 'unidade', 6.99,4);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Lanterna',1, 'unidade', 19.99,4);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Martelo',1, 'unidade', 14.99,4);
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Algodão',50, 'g', 1.99,5);

-- Tabela Pedido --
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-2-02',14 ,1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2018-3-03',6 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2017-6-04',12 ,3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2020-10-05',2 ,3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-5-06',10 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2022-3-07',3 ,2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-4-08',5 ,2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2022-10-09',8 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-10-10',12 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-6-11',1 ,3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-10-12',7 ,1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2021-10-13',15 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2023-10-14',9 ,4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2023-10-15',8 ,2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2023-8-16',5 ,2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2023-9-17',11 ,2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2015-12-18',7 ,3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2015-10-19',4 ,3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2015-10-20',13 ,1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-11-25',13 ,1);

-- Tabela PedidoProduto --
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (1 , 16, 02);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (2, 09, 06);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (3, 07, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (4, 19, 09);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (5, 12, 09);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (6, 10, 08);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (7, 05, 09);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (8, 08, 06);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (9, 14, 01);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (20 , 03, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (19, 11, 07);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (18 , 01, 06);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (17 , 06, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (16 , 14, 08);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (15, 02, 07);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (14, 13, 01);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (13, 17, 02);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (12, 04, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (11, 15, 07);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (10, 11, 10);