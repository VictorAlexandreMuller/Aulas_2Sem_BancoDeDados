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
('2023-11-05', '2023-11-12', 1, 0);

insert into Livro (titulo, quantidade, descricao, lancamento, genero_livro, id_emprestimo)
values 
('Livro A', 3, 'Descrição do Livro A', '2022-05-10', 'Ficção Científica', 1),
('Livro B', 2, 'Descrição do Livro B', '2020-08-20', 'Fantasia', 2),
('Livro C', 1, 'Descrição do Livro C', '2023-01-15', 'Romance', 3),
('Livro D', 4, 'Descrição do Livro D', '2021-11-25', 'Suspense', 4),
('Livro E', 3, 'Descrição do Livro E', '2019-07-30', 'Mistério', 5);

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
(5, 5);