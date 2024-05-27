-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ----------------------------------- SCRIPT CRIAÇÃO SCHEEMA ---------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

drop database if exists biblioteca_ac2;  -- Remove o banco de dados, caso exista
create database biblioteca_ac2 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; -- Cria o banco de dados
use biblioteca_ac2;                      -- Seleciona o banco para os próximos comandos

/* As linhas acima não devem ser executas em serviços online como o sqlite oline*/

-- LEITOR --------------------------
CREATE TABLE Leitor (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    leitor VARCHAR(45) NOT NULL,
	cpf VARCHAR(45) NOT NULL,
    nascimento DATE NOT NULL,
    phone VARCHAR(45) NOT NULL
);

-- EMPRESTIMO --------------------------
CREATE TABLE Emprestimo (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    retirada DATE NOT NULL,
    devolucao DATE NOT NULL,
    situacao boolean NOT NULL,
    multa boolean NOT NULL
    
);

-- LIVRO --------------------------
CREATE TABLE Livro (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45) NOT NULL,
    quantidade int NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    lancamento date NOT NULL,
    genero_livro VARCHAR(100) NOT NULL,
    
    id_emprestimo int NOT NULL,
    
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id)
);

-- AUTOR --------------------------
CREATE TABLE Autor (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    autor VARCHAR(45) NOT NULL,
    nacionalidade VARCHAR(30) NOT NULL,
    genero_autor VARCHAR(100) NOT NULL,
    nascimento date NOT NULL
);

-- LEITOR_AUTOR --------------------------
CREATE TABLE Livro_Autor (
	id_livro INT,
    id_autor INT,
    
    FOREIGN KEY (id_livro) REFERENCES Livro(id),
    FOREIGN KEY (id_autor) REFERENCES Autor(id),
    
	PRIMARY KEY(id_livro, id_autor)
	);

-- LEITOR_EMPRESTIMO --------------------------
CREATE TABLE Leitor_Emprestimo (
	id_leitor INT,
    id_emprestimo INT,
    
    FOREIGN KEY (id_leitor) REFERENCES Leitor(id),
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id),
    
	PRIMARY KEY(id_leitor, id_emprestimo)
	);
