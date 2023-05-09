CREATE DATABASE dbEscola;

USE dbEscola;

CREATE TABLE tbAluno(
	ALU_CODIGO int not null auto_increment,
	ALU_NOME varchar(50) not null,
	ALU_CFP varchar(15) not null unique,
	primary key (ALU_CODIGO)
);