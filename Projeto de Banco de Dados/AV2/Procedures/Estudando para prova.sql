-- Estudando para prova
-- Stored Procedure: É um bloco de coomando que funciona como uma função.

-- Procedure sem parâmetro --
Delimiter $$
Create procedure Ola_mundo()
begin
	select 'Olar Mundo!';
End $$
Delimiter ;

call Olar_mundo();

-- Listar moradores:
Delimiter $$
Create procedure listarMoradores()
begin
	select * from morador;
end $$
Delimiter ;

call listarMoradores();

-- Procedure com parâmetro de entrada IN:
Delimiter %%
create procedure buscarMoradorByNome(in p_nome Varchar(100))
begin 
	select * from morador where nome like concat('%',p_nome,'%');
end %%
delimiter ;

drop procedure buscarMoradorbyNome; -- Apagar procedure
call buscarMoradorbyNome('Ana');

Delimiter !!
Create procedure olarmundopersonalizado(in p_nome Varchar(100))
begin
	Select concat('Olá Mundo, ', p_nome, '!') as 'Boas Vindas';
end !!
Delimiter ;

call olarmundopersonalizado('Austregíselo Junior');

-- Procedure com parâmetro de saída OUT (variável de saída):
Delimiter &
Create Procedure contar_moradores(out total_morador int)
Begin
	Select count(*) into total_morador
    from morador;
End &
Delimiter ;

Call contar_moradores(@valor); -- @valor é uma variável de sessão que apenas existe durante a conexão.
select @valor;

--  Parâmetros In + OUT
Delimiter %
Create procedure qtd_morador_bairro(out p_total int, in p_fkbairro int)
begin 
	Select count(*) into p_total
    from morador
    where fk_idBairro = p_fkbairro;
end %
Delimiter ;

call qtd_morador_bairro(@total , 8);
select @total;

-- Parâmetro INOUT --  o parâmetro entra e sai modificado
Delimiter &
CREATE PROCEDURE atualizar_vagas(
	IN p_idevento INT,
	INOUT p_vagas INT)
BEGIN

	UPDATE evento
    SET qtd_vagas = p_vagas + qtd_vagas
    WHERE idevento = p_idevento;

	SELECT qtd_vagas INTO p_vagas
    FROM evento
    WHERE idevento = p_idevento;

END &
Delimiter ;
set @vagas = 5;
call atualizar_vagas(8, @vagas);
select @vagas;
drop procedure atualizar_vagas;

-- Condicional if em procedure --
Delimiter &
CREATE PROCEDURE validar_vagas(
	IN p_idevento INT)
BEGIN

	DECLARE v_vagas INT;

	SELECT qtd_vagas
    INTO v_vagas
    FROM evento
    WHERE idevento = p_idevento;

	IF (v_vagas > 0)
    THEN

		SELECT 'Evento com vagas disponíveis.';

	ELSE

		SELECT 'Evento indisponível.';

	END IF;
End &
Delimiter ;

call validar_vagas(10);
drop procedure validar_vagas;