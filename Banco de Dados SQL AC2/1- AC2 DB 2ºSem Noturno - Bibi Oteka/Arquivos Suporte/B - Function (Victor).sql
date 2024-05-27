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

SELECT titulo AS Livro, ExemplaresDisponiveis(5) AS ExemplaresDisponiveis FROM Livro WHERE id = 5;