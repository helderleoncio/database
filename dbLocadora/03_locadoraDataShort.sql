-- Tabela de Clientes
INSERT INTO tbCliente (CLI_CPF, CLI_NOME, CLI_DATA_CADASTRO, CLI_CIDADE, CLI_UF)
	VALUES  ('12345678901', 'João Silva', '2024-02-25', 'Fortaleza', 'CE'),
			('98765432100', 'Maria Santos', '2024-02-20', 'Sobral', 'CE'),
			('45612378902', 'Carlos Pereira', '2024-01-15', 'Juazeiro do Norte', 'CE'),
			('32165498703', 'Ana Souza', '2023-12-10', 'Quixadá', 'CE'),
			('74185296304', 'Paulo Lima', '2023-11-05', 'Crato', 'CE'),
			('85296374105', 'Fernanda Costa', '2023-10-30', 'Iguatu', 'CE'),
			('36925814706', 'Ricardo Almeida', '2023-09-25', 'Russas', 'CE'),
			('15935748607', 'Juliana Rocha', '2023-08-15', 'Limoeiro do Norte', 'CE'),
			('75395185208', 'Gabriel Mendes', '2023-07-10', 'Canindé', 'CE'),
			('25874136909', 'Beatriz Ferreira', '2023-06-05', 'Maracanaú', 'CE'),
			('14785236910', 'Lucas Oliveira', '2023-05-20', 'Caucaia', 'CE'),
			('36974125811', 'Camila Martins', '2023-04-15', 'Fortaleza', 'CE'),
			('25896314712', 'Fernando Nunes', '2023-03-10', 'Juazeiro do Norte', 'CE'),
			('14725836913', 'Patrícia Castro', '2023-02-05', 'Sobral', 'CE'),
			('36914725814', 'Rafael Silva', '2023-01-30', 'Crato', 'CE'),
			('85214796315', 'Amanda Melo', '2022-12-25', 'Iguatu', 'CE'),
			('95135748616', 'Thiago Lima', '2022-11-20', 'Russas', 'CE'),
			('15975348617', 'Tatiane Ferreira', '2022-10-15', 'Maracanaú', 'CE'),
			('35795185218', 'Leonardo Souza', '2022-09-10', 'Quixadá', 'CE'),
			('78945612319', 'Juliane Araújo', '2022-08-05', 'Canindé', 'CE'),
			('25815975320', 'Roberto Almeida', '2022-07-25', 'Limoeiro do Norte', 'CE'),
			('74136925821', 'Vanessa Costa', '2022-06-20', 'Caucaia', 'CE'),
			('95125814722', 'Bruno Mendes', '2022-05-15', 'Fortaleza', 'CE'),
			('75395185223', 'Tatiana Rocha', '2022-04-10', 'Juazeiro do Norte', 'CE'),
			('85236974124', 'Gustavo Oliveira', '2022-03-05', 'Crato', 'CE'),
			('75315945625', 'Ana Paula Nunes', '2022-02-25', 'Sobral', 'CE'),
			('85296314726', 'Carlos Eduardo', '2022-01-20', 'Iguatu', 'CE'),
			('35715985227', 'Fernanda Martins', '2021-12-15', 'Russas', 'CE'),
			('14725836928', 'Rafael Silva', '2021-11-10', 'Maracanaú', 'CE'),
			('36985214729', 'Patrícia Castro', '2021-10-05', 'Quixadá', 'CE'),
			('15975348630', 'Leonardo Souza', '2021-09-25', 'Canindé', 'CE'),
			('75395185231', 'Juliane Araújo', '2021-08-20', 'Limoeiro do Norte', 'CE'),
			('25874136932', 'Roberto Almeida', '2021-07-15', 'Caucaia', 'CE');
 
 INSERT INTO tbCategoria (CAT_NOME)
	VALUES 	('Ação'),
 		 	('Comédia'),
 		 	('Drama'),
 		 	('Ficção Científica'),
 		 	('Terror'),
 		 	('Suspense'),
 		 	('Romance'),
 		 	('Fantasia'),
 		 	('Animação'),
 		 	('Documentário'),
 		 	('Musical'),
 		 	('Guerra'),
 		 	('Aventura'),
 		 	('Policial'),
 		 	('Faroeste'),
 		 	('Histórico'),
 		 	('Esportes'),
 		 	('Infantil'),
 		 	('Biografia'),
 		 	('Nacional');

INSERT INTO tbClasse (CLA_NOME, CLA_PRECO) 
	VALUES  ('Lançamento', 10.00),
			('Catálogo', 5.00);

 INSERT INTO tbTitulo (TIT_NOME, TIT_ANO, CAT_CODIGO, CLA_CODIGO) 
 	VALUES	('O Poderoso Chefão', 1972, 1, 2),
			('Matrix', 1999, 4, 2),
			('Jurassic Park', 1993, 13, 2),
			('Titanic', 1997, 7, 2),
			('Vingadores: Ultimato', 2019, 1, 1),
			('O Senhor dos Anéis: O Retorno do Rei', 2003, 8, 2),
			('Star Wars: Uma Nova Esperança', 1977, 4, 2),
			('Harry Potter e a Pedra Filosofal', 2001, 8, 2),
			('Coringa', 2019, 3, 1),
			('Toy Story', 1995, 9, 2),
			('O Rei Leão', 1994, 9, 2),
			('Pantera Negra', 2018, 1, 1),
			('Interestelar', 2014, 4, 1),
			('Clube da Luta', 1999, 3, 2),
			('Forrest Gump', 1994, 3, 2),
			('Gladiador', 2000, 12, 2),
			('It: A Coisa', 2017, 5, 1),
			('A Origem', 2010, 4, 1),
			('Deadpool', 2016, 1, 1),
			('Cidadão Kane', 1941, 3, 2);

INSERT INTO tbFilme (TIT_CODIGO, FIL_NOME_DISTRIBUIDOR)
	VALUES	(1, 'Paramount'),
			(2, 'Warner Bros'),
			(3, 'Universal'),
			(4, '20th Century Fox'),
			(5, 'Marvel Studios'),
			(6, 'New Line Cinema'),
			(7, 'Lucasfilm'),
			(8, 'Warner Bros'),
			(9, 'DC Films'),
			(10, 'Pixar'),
			(11, 'Disney'),
			(12, 'Marvel Studios'),
			(13, 'Paramount'),
			(14, '20th Century Fox'),
			(15, 'Paramount'),
			(16, 'DreamWorks'),
			(17, 'Warner Bros'),
			(18, 'Warner Bros'),
			(19, '20th Century Fox'),
			(20, 'RKO Pictures');

INSERT INTO tbEmprestimoDevolucao (CLI_CODIGO, FIL_CODIGO, EMD_DATA_EMPRESTIMO, EMD_DATA_DEVOLUCAO_PREVISTA, EMD_DATA_DEVOLUCAO_EFETIVA, EMD_VALOR_MULTA) 
	VALUES  (1, 3, '2024-02-01', '2024-02-08', '2024-02-07', 0.00),
			(2, 5, '2024-01-25', '2024-02-01', '2024-02-03', 2.50),
			(3, 8, '2024-01-30', '2024-02-06', '2024-02-06', 0.00),
			(4, 2, '2024-02-05', '2024-02-12', NULL, 0.00),
			(5, 6, '2024-02-10', '2024-02-17', NULL, 0.00),
			(6, 9, '2024-02-15', '2024-02-22', '2024-02-25', 3.00),
			(7, 4, '2024-02-18', '2024-02-25', NULL, 0.00),
			(8, 7, '2024-02-20', '2024-02-27', '2024-02-27', 0.00),
			(9, 1, '2024-02-22', '2024-02-29', NULL, 0.00);