CREATE DATABASE dbLocadora;

USE dbLocadora;

CREATE TABLE tbCliente(
	CLI_CODIGO int auto_increment comment 'Cógido do cliente',
	CLI_CPF char(11) comment 'CPF do cliente',
	CLI_NOME varchar(20) not null comment 'Nome do cliente',
	CLI_DATA_CADASTRO date comment 'Data de cadastro do cliente',
	CLI_CIDADE varchar(20) comment 'Cidade do cliente',
	CLI_UF char(2) default 'CE' comment 'Estado do cliente',
	constraint UN_CLI_CPF unique (CLI_CPF) comment 'Definindo o CPF como chade unica',
	primary key(CLI_CODIGO) comment 'Chave primária'
) comment 'Tabela de cadastro de clientes';

CREATE TABLE tbCategoria(
	CAT_CODIGO int auto_increment,
	CAT_NOME varchar(20) not null,
	primary key(CAT_CODIGO)
);

CREATE TABLE tbClasse(
	CLA_CODIGO int auto_increment,
	CLA_NOME varchar(20) not null,
	CLA_PRECO numeric(4,2) not null,
	constraint ck_NomeClasse check (CLA_NOME in ('Lançamento', 'Catálogo')),
    primary key(CLA_CODIGO)
);

CREATE TABLE tbTitulo(
	TIT_CODIGO int auto_increment,
	TIT_NOME varchar(50) NOT NULL,
	TIT_ANO numeric(4),
	CAT_CODIGO INT,
	CLA_CODIGO INT,
	primary key(TIT_CODIGO),
    constraint fk_tbTitulo_tbCategoria foreign key(CAT_CODIGO) references tbCategoria(CAT_CODIGO)
	on delete cascade on update cascade,
	constraint fk_tbTitulo_tbClasse foreign key(CLA_CODIGO) references tbClasse(CLA_CODIGO)
	on delete cascade on update cascade
);

CREATE TABLE tbFilme( 
	FIL_CODIGO int auto_increment,
	TIT_CODIGO int,
	FIL_NOME_DISTRIBUIDOR VARCHAR(20),
	primary key(FIL_CODIGO),
	constraint fk_tbFilme_tbTitulo foreign key(TIT_CODIGO) references tbTitulo(TIT_CODIGO)
	on delete cascade on update cascade
);

CREATE TABLE tbEmprestimoDevolucao (
	CLI_CODIGO int,
	FIL_CODIGO int,
	EMD_DATA_EMPRESTIMO date not null,
	EMD_DATA_DEVOLUCAO_PREVISTA date not null,
	EMD_DATA_DEVOLUCAO_EFETIVA date,
	EMD_VALOR_MULTA numeric(4,2) default 0,
	primary key(CLI_CODIGO, FIL_CODIGO, EMD_DATA_EMPRESTIMO),
	constraint fk_tbEmpDev_tbCliente foreign key (CLI_CODIGO) references tbCliente (CLI_CODIGO)
	on delete cascade on update cascade,
	constraint fk_tbEmpDev_tbFilme foreign key (FIL_CODIGO) references tbFilme (FIL_CODIGO)
	on delete cascade on update cascade
);