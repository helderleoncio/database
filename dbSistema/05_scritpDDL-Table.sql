create table tbClienteTelefone(
	CLT_CODIGO int(5) not null auto_increment,
	CLT_TELEFONE varchar(13) null,
	CLI_CODIGO int(5) not null,     
	primary key(CLT_CODIGO),
    constraint fk_Cliente_Telefone foreign key(CLI_CODIGO) references tbCliente(CLI_CODIGO)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- 1. Para apagar a tabela :
-- drop table tbClienteTelefone;

-- 2. Para apagar a coluna tbAluno->CLT_TELEFONE:
alter table tbClienteTelefone drop column CLT_TELEFONE;

-- 3. Para adicionar uma coluna na tbClienteTelefone:
alter table tbClienteTelefone add column CLT_TELEFONE varchar(20);

-- 4. Para alterar uma coluna:
alter table tbClienteTelefone modify column CLT_TELEFONE varchar(13);

-- 5. Para apagar uma chave
alter table tbClienteTelefone drop constraint fk_Cliente_Telefone;

-- 6. Para adicionar uma chave única
alter table tbClienteTelefone add constraint uk_cliente_telefone unique (CLT_TELEFONE);

-- 7. Para adicionar uma chave estrangeira:
alter table tbClienteTelefone add constraint fk_Cliente_Telefone foreign key(CLI_CODIGO) 
	references tbCliente(CLI_CODIGO);