USE dbEscola;

-- Inserção de dados na tabela de Professores

INSERT INTO tbProfessor (PRO_NOME, PRO_EMAIL, PRO_ESPECIALIDADE) VALUE ('João Silva', 'joaosilva@email.com', 'Matemática'),
INSERT INTO tbProfessor (PRO_NOME, PRO_EMAIL, PRO_ESPECIALIDADE) VALUE ('Maria Oliveira', 'mariaoliveira@email.com', 'História'),
INSERT INTO tbProfessor (PRO_NOME, PRO_EMAIL, PRO_ESPECIALIDADE) VALUE ('Carlos Souza', 'carlossouza@email.com', 'Física');

-- Inserção de dados na tabela de Cursos

INSERT INTO tbCurso (CUR_NOME, CUR_DESCICAO) VALUE ('Matemática', 'Curso de Matemática com foco em aplicações práticas e teóricas'),
INSERT INTO tbCurso (CUR_NOME, CUR_DESCICAO) VALUE ('História', 'Curso abrangente sobre a História mundial, desde a antiguidade até os tempos modernos'),
INSERT INTO tbCurso (CUR_NOME, CUR_DESCICAO) VALUE ('Física', 'Curso dedicado aos princípios e teorias da Física, com ênfase em experimentos práticos');

-- Inserção de dados na tabela de Disciplinas

INSERT INTO tbDisciplina (DIS_NOME, CUR_COD, PRO_COD) VALUE ('Álgebra', 1, 1),
INSERT INTO tbDisciplina (DIS_NOME, CUR_COD, PRO_COD) VALUE ('História Antiga', 2, 2),
INSERT INTO tbDisciplina (DIS_NOME, CUR_COD, PRO_COD) VALUE ('Mecânica Clássica', 3, 3);

-- Inserção de dados na tabela de Alunos
INSERT INTO tbAluno (ALU_NOME, ALU_DT_NASC, ALU_EMAIL) VALUE ('Ana Pereira', '2003-04-15', 'anapereira@email.com'),
INSERT INTO tbAluno (ALU_NOME, ALU_DT_NASC, ALU_EMAIL) VALUE ('Lucas Martins', '2004-05-22', 'lucasmartins@email.com'),
INSERT INTO tbAluno (ALU_NOME, ALU_DT_NASC, ALU_EMAIL) VALUE ('Sofia Gonçalves', '2005-06-30', 'sofiagoncalves@email.com');

-- Inserção de dados na tabela de Aluno_Disciplina

INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (1, 1),
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (1, 2),
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (2, 2),
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (2, 3),
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (3, 1),
INSERT INTO tbAluno_Disciplina (ALU_COD, DIS_COD) VALUE (3, 3);
