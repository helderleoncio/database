-- Cria o banco de dados Escola
CREATE DATABASE dbEscola;

USE dbEscola;

-- Criação da tabela de Professores
CREATE TABLE tbProfessor (
    PRO_COD INT AUTO_INCREMENT PRIMARY KEY,
    PRO_NOME VARCHAR(255) NOT NULL,
    PRO_EMAIL VARCHAR(255) UNIQUE NOT NULL,
    PRO_ESPECIALIDADE VARCHAR(255) NOT NULL
);

-- Criação da tabela de Cursos
CREATE TABLE tbCurso (
    CUR_COD INT AUTO_INCREMENT PRIMARY KEY,
    CUR_NOME VARCHAR(255) NOT NULL,
    CUR_DESCICAO TEXT
);

-- Criação da tabela de Disciplinas
CREATE TABLE tbDisciplina (
    DIS_COD INT AUTO_INCREMENT PRIMARY KEY,
    DIS_NOME VARCHAR(255) NOT NULL,
    CUR_COD INT,
    PRO_COD INT,
    FOREIGN KEY (CUR_COD) REFERENCES tbCurso(CUR_COD),
    FOREIGN KEY (PRO_COD) REFERENCES tbProfessor(PRO_COD)
);

-- Criação da tabela de Alunos
CREATE TABLE tbAluno (
    ALU_COD INT AUTO_INCREMENT PRIMARY KEY,
    ALU_NOME VARCHAR(255) NOT NULL,
    ALU_DT_NASC DATE NOT NULL,
    ALU_EMAIL VARCHAR(255) UNIQUE NOT NULL
);

-- Criação da tabela de Aluno_Disciplina para relacionar alunos e as disciplinas que estão matriculados
CREATE TABLE tbAluno_Disciplina (
    ALU_COD INT,
    DIS_COD INT,
    PRIMARY KEY (ALU_COD, DIS_COD),
    FOREIGN KEY (ALU_COD) REFERENCES tbAluno(ALU_COD),
    FOREIGN KEY (DIS_COD) REFERENCES tbDisciplina(DIS_COD)
);