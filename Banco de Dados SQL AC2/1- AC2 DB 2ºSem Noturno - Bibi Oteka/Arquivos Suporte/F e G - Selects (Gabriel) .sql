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