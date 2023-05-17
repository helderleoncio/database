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
);

CREATE TABLE tbPedido(
	PED_CODIGO int not null auto_increment,
	PED_DATA date,
	CLI_CODIGO int,
	VEN_CODIGO int,
    primary key (PED_CODIGO),
    constraint fk_tbPedido_tbCliente foreign key (CLI_CODIGO) references tbCliente(CLI_CODIGO),
    constraint fk_tbPedido_tbVendedor foreign key (VEN_CODIGO) references tbVendedor(VEN_CODIGO)
);

CREATE TABLE tbPedidoProduto(
	PEP_CODIGO int not null auto_increment,
	PED_CODIGO int not null,
	PRO_CODIGO int not null,
	PEP_QTDE int not null,
	PEP_PRECO_UNIT double(10,2),
    primary key (PEP_CODIGO),
    constraint fk_tbPedidoProduto_tbPedido foreign key (PED_CODIGO) references tbPedido(PED_CODIGO),
    constraint fk_tbPedidoProduto_tbProduto foreign key (PRO_CODIGO) references tbProduto(PRO_CODIGO)
);

-- Cadastro de Clientes --
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Sofia Rodriguez','781630492356','Rua do Sol',123,'Centro');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Lucas Santos','213540289654','Avenida das Flores',456,' Jardim Botânico');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Isabella Silva','846529018364','Rua dos Pinheiros',789,' Pinheiros');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Miguel Almeida','970218634125','Avenida da Praia',234,' Copacabana');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Ana Paula Costa','384769521039','Rua das Palmeiras',567,' Jardim Europa');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Tiago Ferreira','872109346523','Avenida das Dunas',890,' Barra da Tijuca');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Júlia Vieira','457982130964','Rua dos Cravos',123,' Vila Madalena');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Pedro Carvalho','925468713024','Avenida das Gaivotas',456,' Ipanema');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Lara Castro','345671982156','Rua das Acácias',789,' Perdizes');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Guilherme Souza','657890243561','Avenida das Amendoeiras',234,' Lagoa');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Giovanna Oliveira','231490785634','Rua dos Girassóis',567,' Itaim Bibi');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Rafael Pereira','876512093467','Avenida das Mangueiras',890,' Jardim Botânico');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Laura Martins','456389120367','Rua dos Crisântemos',123,' Jardins');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Gabriel Lima','981726304567','Avenida das Palmeiras',456,' Leblon');
insert into tbCliente (CLI_NOME, CLI_CPF, CLI_RUA, CLI_NUMERO, CLI_BAIRRO) value ('Beatriz Gonçalves','456870913284','Rua das Orquídeas',789,' Vila Nova Conceição');

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
insert into tbProduto (PRO_NOME, PRO_QTDE, PRO_UNIDADE, PRO_PRECO_UNIT, FOR_CODIGO) value ('Álcool Gel',500, 'mL', 9.99,5);

-- Tabela Pedido --
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-02', 67, 1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-03', 29, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-04', 92, 3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-05', 13, 3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-06', 41, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-07', 55, 2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-08', 77, 2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-09', 22, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-10', 38, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-11', 89, 3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-12', 17, 1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-13', 43, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-14', 6, 4);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-15', 83, 2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-16', 9, 2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-17', 99, 2);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-18', 51, 3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-19', 70, 3);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-20', 25, 1);
insert into tbPedido (PED_DATA, CLI_CODIGO, VEN_CODIGO) value ('2019-10-21', 8, 1);


-- Tabela de tbPedidoProduto --
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (85, 49, 2);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (134, 17, 6);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (40, 55, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (82, 8, 9);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (118, 13, 9);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (157, 46, 8);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (137, 48, 9);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (82, 45, 6);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (136, 14, 1);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (72, 16, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (160, 43, 7);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (72, 8, 6);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (127, 26, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (62, 10, 8);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (51, 28, 7);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (98, 50, 1);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (36, 18, 2);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (141, 40, 10);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (143, 21, 7);
insert into tbPedidoProduto (PED_CODIGO, PRO_CODIGO, PEP_QTDE) value (23, 24, 10);