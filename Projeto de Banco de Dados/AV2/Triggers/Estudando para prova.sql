-- Estudando triggrs --
-- Uma Trigger (gatilho) é um bloco SQL executado automaticamente quando um evento acontece em uma tabela.
-- Ela funciona como:
-- “Quando algo acontecer nessa tabela, execute esse código automaticamente.”

CREATE TABLE log_inscricao(
	idLog INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

select * from log_inscricao;

Delimiter $$
Create trigger log_inscricao
After insert on inscricao
for each row
begin
	insert into log_inscricao(mensagem)
    values(concat('Inscrição realizada, ID', new.idinscricao));
End $$
Delimiter ;
drop trigger log_inscricao;

select * from inscricao;
Insert into inscricao (data_hora, fk_idmorador, fk_idevento)
values (now(),3,5);

-- Trigger para validar vagas:
Delimiter &&
create trigger validar_vagas
Before insert on inscricao
for each row
Begin
	Declare v_vagas int;
    
    select qtd_vagas
    into v_vagas
    from evento
    where idevento = new.fk_idevento;
    
    if v_vagas <= 0 then
		signal sqlstate '45000'
		set message_text = 'Vagas indisponíveis';
	end if;
End &&
Delimiter ;

drop trigger validar_vagas;
select * from evento;
Insert into inscricao (data_hora, fk_idmorador, fk_idevento)
values (now(),8,3);

-- Trigger para atualizar vagas


