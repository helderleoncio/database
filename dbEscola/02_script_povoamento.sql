USE dbEscola;

-- Inserção de dados na tabela de Professores
INSERT INTO tbProfessor (PRO_NOME, PRO_EMAIL, PRO_ESPECIALIDADE) VALUES
('João Silva', 'joaosilva@email.com', 'Matemática'),
('Maria Oliveira', 'mariaoliveira@email.com', 'História'),
('Carlos Souza', 'carlossouza@email.com', 'Física');

-- Inserção de dados na tabela de Cursos
INSERT INTO tbCurso (CUR_NOME, CUR_DESCICAO) VALUES
('Matemática', 'Curso de Matemática com foco em aplicações práticas e teóricas'),
('História', 'Curso abrangente sobre a História mundial, desde a antiguidade até os tempos modernos'),
('Física', 'Curso dedicado aos princípios e teorias da Física, com ênfase em experimentos práticos');

-- Inserção de dados na tabela de Disciplinas
INSERT INTO tbDisciplina (DIC_NOME, CUR_COD, PRO_COD) VALUES
('Álgebra', 1, 1),
('História Antiga', 2, 2),
('Mecânica Clássica', 3, 3);

-- Inserção de dados na tabela de Alunos
INSERT INTO tbAluno (ALU_NOME, ALU_DT_NASC, ALU_EMAIL) VALUES
('Ana Pereira', '2003-04-15', 'anapereira@email.com'),
('Lucas Martins', '2004-05-22', 'lucasmartins@email.com'),
('Sofia Gonçalves', '2005-06-30', 'sofiagoncalves@email.com');

-- Inserção de dados na tabela de Aluno_Disciplina
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 1),
(3, 3);
