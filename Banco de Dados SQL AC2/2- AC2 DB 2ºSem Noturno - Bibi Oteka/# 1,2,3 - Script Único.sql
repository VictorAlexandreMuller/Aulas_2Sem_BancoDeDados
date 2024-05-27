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
    genero_livro VARCHAR(100) NOT NULL
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

-- LIVRO_EMPRESTIMO --------------------------
CREATE TABLE Livro_Emprestimo (
	id_livro INT,
    id_emprestimo INT,
    
    FOREIGN KEY (id_livro) REFERENCES Livro(id),
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id),
    
	PRIMARY KEY(id_livro, id_emprestimo)
	);

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ------------------------------------- SCRIPT DE INSERTS ------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

use biblioteca_ac2; 

insert into Leitor (leitor, cpf, nascimento, phone) 
values 
('João Silva', '123.456.789-01', '1990-05-15', '(11) 1234-5678'),
('Maria Santos', '987.654.321-02', '1985-08-25', '(22) 3456-7890'),
('Carlos Oliveira', '456.789.012-03', '1998-12-10', '(33) 6789-0123'),
('Ana Pereira', '789.012.345-04', '1992-03-02', '(44) 9012-3456'),
('Pedro Alves', '234.567.890-05', '1980-11-20', '(55) 1234-5678');

insert into Emprestimo (retirada, devolucao, situacao, multa)
values 
('2023-11-01', '2023-11-08', 1, 0),
('2023-11-02', '2023-11-09', 1, 0),
('2023-11-03', '2023-11-10', 1, 0),
('2023-11-04', '2023-11-11', 1, 0),
('2023-11-05', '2023-11-12', 1, 0),
('2023-10-31', '2023-11-07', 1, 1),
('2023-11-30', '2023-11-06', 1, 1),
('2023-11-29', '2023-11-05', 1, 1),
('2023-11-28', '2023-11-04', 1, 1),
('2023-11-27', '2023-11-03', 1, 1);

insert into Livro (titulo, quantidade, descricao, lancamento, genero_livro)
values 
('Livro A', 3, 'Descrição do Livro A', '2022-05-10', 'Ficção Científica'),
('Livro B', 2, 'Descrição do Livro B', '2020-08-20', 'Fantasia'),
('Livro C', 1, 'Descrição do Livro C', '2023-01-15', 'Romance'),
('Livro D', 4, 'Descrição do Livro D', '2021-11-25', 'Suspense'),
('Livro E', 3, 'Descrição do Livro E', '2019-07-30', 'Mistério');

insert into Autor (autor, nacionalidade, genero_autor, nascimento)
values 
('Autor X', 'Brasileiro', 'Ficção Científica', '1975-03-12'),
('Autor Y', 'Americano', 'Fantasia', '1980-06-25'),
('Autor Z', 'Francês', 'Romance', '1968-09-18'),
('Autor W', 'Inglês', 'Suspense', '1985-11-30'),
('Autor V', 'Alemão', 'Mistério', '1970-04-05');

insert into Livro_Autor (id_livro, id_autor)
values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

insert into Leitor_Emprestimo (id_leitor, id_emprestimo)
values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 7),
(3, 8),
(4, 9),
(5, 10);

insert into Livro_Emprestimo (id_livro, id_emprestimo)
values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(5, 6),
(5, 7),
(4, 8),
(2, 9),
(1, 10);

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ----------- SCRIPT COMPILADO COM TODOS AS PROCEDURES, FUNCTIONS, TRIGGERS E VIEWS ----------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

use biblioteca_ac2;

-- --------------------------------------- CRIAÇÃO FUNCTION ------------------------------------------------

DELIMITER $$
CREATE FUNCTION ExemplaresDisponiveis(id_livro_param INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_exemplares INT;
    DECLARE total_emprestados INT;

    SELECT quantidade INTO total_exemplares FROM Livro WHERE id = id_livro_param;
    SELECT COUNT(*) INTO total_emprestados FROM Livro_Emprestimo WHERE id_livro = id_livro_param;

    RETURN total_exemplares - total_emprestados;
END;
$$
DELIMITER ;

-- --------------------------------------- CRIAÇÃO PROCEDURE -----------------------------------------------

delimiter //
create procedure register_emp (
    in id_leitor int,
    in id_livro int
)
begin
    declare data_retirada date;
    declare data_devolucao date;
    declare emprestimo int;
    
    set data_retirada = CURDATE();
    set data_devolucao = DATE_ADD(data_retirada, interval 7 day);
    
    select quantidade into @quantidade from Livro where id_livro = id_livro limit 1;
    
    if @quantidade > 0 then
        insert into Emprestimo (retirada, devolucao, situacao, multa)
        values (data_retirada, data_devolucao, 1, 0);
        
        set emprestimo = LAST_INSERT_ID();
        
        insert into Leitor_Emprestimo (id_leitor, id_emprestimo)
        values (id_leitor, emprestimo);
        
        insert into Livro_Emprestimo (id_livro, id_emprestimo)
        values (id_livro, emprestimo);
    end if;
    
end //
delimiter ;

-- --------------------------------------- CRIAÇÃO VIEW --------------------------------------------

CREATE VIEW DetalhesEmprestimos AS
SELECT
    E.id AS IdEmprestimo,
    L.titulo AS TituloLivro,
    A.autor AS NomeAutor,
    Lr.leitor AS NomeLeitor,
    E.retirada AS DataRetirada,
    E.devolucao AS DataDevolucao
FROM Emprestimo E
INNER JOIN Leitor_Emprestimo LE ON E.id = LE.id_emprestimo
INNER JOIN Livro_Emprestimo LEmp ON E.id = LEmp.id_emprestimo
INNER JOIN Livro L ON LEmp.id_livro = L.id
INNER JOIN Livro_Autor LA ON L.id = LA.id_livro
INNER JOIN Autor A ON LA.id_autor = A.id
INNER JOIN Leitor Lr ON LE.id_leitor = Lr.id;

-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------