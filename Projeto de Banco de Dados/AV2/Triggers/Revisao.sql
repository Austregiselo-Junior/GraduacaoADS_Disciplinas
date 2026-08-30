-- Triggers -- Bloco SQL que é executado automaticamente quanso um evento ocorre nuna tabela
 -- New (Insert e Update)
 -- OLD (Update Delete)
 
 CREATE TABLE log_inscricao(
	idLog INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO inscricao
(data_hora, fk_idmorador, fk_idevento)
VALUES (NOW(), 3, 5);

-- Salvar automaticamente um log quando houver inscrição.

Delimiter %%
Create trigger log
after insert on inscricao
for each row
begin
	insert into log_inscricao(mensagem) values(
    concat ('Deu certo:', new.idinscricao));
end %%
Delimiter ;
Drop trigger log;
select * from log_inscricao;


-- Trigger para validar vagas:
Delimiter %%
Create trigger vagaValidate
before insert on inscricao
for each row
begin 
	Declare v_vagas int;
    
    select qtd_vagas into v_vagas
    from evento
    where idevento = new.fk_idevento;
    
    if (v_vagas <= 0) then
		signal sqlstate '45000' 
        set message_text = 'Vaga indisponível.';
	end if;
end %%
Delimiter ;

INSERT INTO inscricao
(data_hora, fk_idmorador, fk_idevento)
VALUES (NOW(), 9, 8);

select * from evento;

-- Redução de vagas:
Delimiter %%
Create trigger VagasUpdate
before insert on inscricao
for each row
begin 
	Update evento 
    set qtd_vagas = qtd_vagas -1
    where idevento = new.fk_idevento;
end %%
Delimiter ;

