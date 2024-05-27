-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ------------------- SCRIPT COMPILADO COM TODOS OS SELECTS E CALLS NECESSÁRIOS --------------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- SELECTS Normais --

SELECT * FROM livro;

SELECT * FROM emprestimo;

SELECT * FROM autor;

SELECT * FROM leitor;

-- SELECTS da Function --

SELECT titulo AS Livro, ExemplaresDisponiveis(1) AS ExemplaresDisponiveis FROM Livro WHERE id = 1;
SELECT titulo AS Livro, ExemplaresDisponiveis(2) AS ExemplaresDisponiveis FROM Livro WHERE id = 2;
SELECT titulo AS Livro, ExemplaresDisponiveis(3) AS ExemplaresDisponiveis FROM Livro WHERE id = 3;
SELECT titulo AS Livro, ExemplaresDisponiveis(4) AS ExemplaresDisponiveis FROM Livro WHERE id = 4;
SELECT titulo AS Livro, ExemplaresDisponiveis(5) AS ExemplaresDisponiveis FROM Livro WHERE id = 5;

-- Calls da Procedure --

call registrar_emprestimo(1);
call registrar_emprestimo(2);
call registrar_emprestimo(3);
call registrar_emprestimo(4);
call registrar_emprestimo(5);
call registrar_emprestimo(6);
call registrar_emprestimo(7);
call registrar_emprestimo(8);
call registrar_emprestimo(9);
call registrar_emprestimo(10);

-- SELECTS da View --

SELECT * FROM DetalhesEmprestimos;

-- SELECTS da  --

select livro.titulo,descricao, emprestimo.retirada, emprestimo.devolucao 
from livro
join emprestimo on emprestimo.id = livro.id_emprestimo
where situacao = 1
order by retirada;

select leitor, cpf, phone, retirada, devolucao from leitor
join emprestimo on emprestimo.id = leitor.id
where situacao = 1 and devolucao < now();

-- Data de devolução > now() = multa on

-- 