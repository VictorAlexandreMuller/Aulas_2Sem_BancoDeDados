use biblioteca_ac2;

delimiter $$

drop procedure if exists registrar_emprestimo;
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

call registrar_emprestimo(1);