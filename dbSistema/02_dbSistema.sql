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
    primary key (PEP_CODIGO),
    constraint fk_tbPedidoProduto_tbPedido foreign key (PED_CODIGO) references tbPedido(PED_CODIGO),
    constraint fk_tbPedidoProduto_tbProduto foreign key (PRO_CODIGO) references tbProduto(PRO_CODIGO),
    ON DELETE RESTRICT
);