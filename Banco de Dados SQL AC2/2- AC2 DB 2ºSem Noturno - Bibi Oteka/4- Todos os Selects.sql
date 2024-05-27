-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ------------------- SCRIPT COMPILADO COM TODOS OS SELECTS E CALLS NECESSÁRIOS --------------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- SELECTS Normais --
-- OK
SELECT * FROM livro;
SELECT * FROM emprestimo;
SELECT * FROM autor;
SELECT * FROM leitor;

-- SELECTS Livros emprestados no momento e Quem está devendo devolução à biblioteca --
-- OK
SELECT L.titulo, E.retirada, E.devolucao 
FROM Livro AS L 
JOIN Livro_Emprestimo AS LE ON L.id = LE.id_livro 
JOIN Emprestimo AS E ON LE.id_emprestimo = E.id 
WHERE E.devolucao >= CURDATE();

SELECT L.leitor, E.retirada, E.devolucao 
FROM Leitor AS L 
JOIN Leitor_Emprestimo AS LE ON L.id = LE.id_leitor 
JOIN Emprestimo AS E ON LE.id_emprestimo = E.id 
WHERE E.devolucao < CURDATE();

-- SELECTS da Function --
-- OK
SELECT titulo AS Livro, ExemplaresDisponiveis(5) AS ExemplaresDisponiveis 
FROM Livro WHERE id= 5; -- Substitua 1 pelo ID do livro desejado

-- Calls da Procedure --
-- OK
call register_emp(1,2);
call register_emp(5,4);
call register_emp(2,1);

select * from Leitor_emprestimo;
select * from Livro_emprestimo;
select * from emprestimo;

-- SELECTS da View --
-- OK
SELECT * FROM DetalhesEmprestimos;


-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------