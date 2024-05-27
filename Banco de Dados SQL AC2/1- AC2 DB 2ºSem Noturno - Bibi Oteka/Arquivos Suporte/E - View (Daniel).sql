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
INNER JOIN Livro L ON E.id = L.id_emprestimo
INNER JOIN Livro_Autor LA ON L.id = LA.id_livro
INNER JOIN Autor A ON LA.id_autor = A.id
INNER JOIN Leitor Lr ON LE.id_leitor = Lr.id;


SELECT * FROM DetalhesEmprestimos;