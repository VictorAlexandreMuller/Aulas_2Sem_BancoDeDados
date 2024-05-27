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
	
	-- Esta instrução SQL recupera a quantidade de exemplares 
    -- disponíveis do livro com o id igual ao valor de id_livro_param passado como parâmetro. 
    -- O resultado é armazenado na variável total_exemplares.
    SELECT quantidade 
    INTO total_exemplares 
    FROM Livro 
    WHERE id = id_livro_param;
	
    -- Esta instrução SQL conta quantos empréstimos foram feitos do livro especificado, 
    -- identificando os empréstimos através da tabela Leitor_Emprestimo. 
    -- O resultado é armazenado na variável total_emprestados.
    SELECT COUNT(*) 
    INTO total_emprestados 
    FROM Leitor_Emprestimo 
    WHERE id_emprestimo 
    IN (SELECT id_emprestimo FROM Livro WHERE id = id_livro_param);
	
    RETURN total_exemplares - total_emprestados;
END;
$$
DELIMITER ;

-- --------------------------------------- CRIAÇÃO PROCEDURE -----------------------------------------------

delimiter $$

create procedure registrar_emprestimo (
    in id_leitor int
)
begin
    declare id_emprestimo int;
    declare data_retirada date;
    declare data_devolucao date;
    
    set data_retirada = CURDATE();
    set data_devolucao = DATE_ADD(data_retirada, interval 7 day);
    
    if (select quantidade from Livro where id_emprestimo is null limit 1) > 0 then
    
        insert into emprestimo (retirada, devolucao, situacao, multa)
        values (data_retirada, data_devolucao, 1, 0);
        
        set id_emprestimo = LAST_INSERT_ID();
        
        insert into leitor_emprestimo (id_leitor, id_emprestimo)
        values (id_leitor, id_emprestimo);
    
    else
        SIGNAL SQLSTATE '45000' set MESSAGE_TEXT = 'Book not avaliable in the library';
    end if;
    
end $$

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
INNER JOIN Livro L ON E.id = L.id_emprestimo
INNER JOIN Livro_Autor LA ON L.id = LA.id_livro
INNER JOIN Autor A ON LA.id_autor = A.id
INNER JOIN Leitor Lr ON LE.id_leitor = Lr.id;

-- 

