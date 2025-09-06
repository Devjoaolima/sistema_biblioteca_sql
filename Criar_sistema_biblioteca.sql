-- =====================================================================
-- Script para criação do Banco de Dados da Biblioteca Universitária
-- =====================================================================

-- 1. CRIAÇÃO DO BANCO DE DADOS
-- Cria o banco de dados se ele ainda não existir, evitando erros.
CREATE DATABASE IF NOT EXISTS biblioteca_universitaria
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco de dados recém-criado para executar os comandos seguintes.
USE biblioteca_universitaria;


-- 2. CRIAÇÃO DAS TABELAS PRINCIPAIS (sem chaves estrangeiras)

-- Tabela de Alunos
CREATE TABLE Aluno (
    ra VARCHAR(20) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NULL,
    PRIMARY KEY (ra),
    UNIQUE INDEX email_unique (email ASC)
);

-- Tabela de Livros
CREATE TABLE Livro (
    isbn VARCHAR(13) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    paginas INT NULL,
    PRIMARY KEY (isbn)
);

-- Tabela de Colaboradores
CREATE TABLE Colaborador (
    cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    PRIMARY KEY (cpf),
    UNIQUE INDEX email_unique (email ASC)
);


-- 3. CRIAÇÃO DA TABELA ASSOCIATIVA (com chaves estrangeiras)

-- Tabela de Empréstimos
-- Esta tabela conecta Aluno, Livro e Colaborador
CREATE TABLE Emprestimo (
    id INT NOT NULL AUTO_INCREMENT,
    dataEmprestimo DATE NOT NULL,
    dataDevolucao DATE NULL,
    alunoRa VARCHAR(20) NOT NULL,
    livroIsbn VARCHAR(13) NOT NULL,
    colaboradorCpf VARCHAR(11) NOT NULL,
    PRIMARY KEY (id),
    
    -- Definição dos índices para as chaves estrangeiras (melhora a performance)
    INDEX fk_emprestimo_aluno_idx (alunoRa ASC),
    INDEX fk_emprestimo_livro_idx (livroIsbn ASC),
    INDEX fk_emprestimo_colaborador_idx (colaboradorCpf ASC),
    
    -- Definição das restrições de chave estrangeira (garante a integridade dos dados)
    CONSTRAINT fk_emprestimo_aluno
        FOREIGN KEY (alunoRa)
        REFERENCES Aluno (ra)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    CONSTRAINT fk_emprestimo_livro
        FOREIGN KEY (livroIsbn)
        REFERENCES Livro (isbn)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    CONSTRAINT fk_emprestimo_colaborador
        FOREIGN KEY (colaboradorCpf)
        REFERENCES Colaborador (cpf)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Fim do Script