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