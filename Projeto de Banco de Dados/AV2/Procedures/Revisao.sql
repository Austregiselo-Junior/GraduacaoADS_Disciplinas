-- Stored Procedures: É um bbloco de comando SQL salvo dentro do bando de dados.
-- Objetivos:
-- Reutilizar código
-- centralizar regras de negócio
-- automatizar operações
-- melhorar segurançalter
-- reduzir repetição

-- Estrutura
Delimiter %% -- muda temporariamente o delimitador
Create procedure nome()
Begin
	-- comandos
end %%
Delimiter ; -- restauraçõa do delimitador original

call nome();
Drop procedure nome;

-- Parâmetro (IN - entrada)
Delimiter %%
Create procedure GetMorador(in p_nome varchar(100))
begin
	select * from morador
    where nome like concat('%', p_nome, '%');
End %%
Delimiter ;

call GetMorador('Ana');
Drop procedure GetMorador;

-- Parametro (OUT - saída)
Delimiter %%
Create Procedure GetMoradores(out totalMoradores int)
begin
	select count(*) into totalMoradores
    from morador;
end %%
Delimiter ;

call GetMoradores(@valor); -- @valor -> Uma variável de sessão, ela é termporária
select @valor; -- Para ver o que tem dentro da variável

-- Parametros (IN + OUT -> entrada e saída)
Delimiter %%
Create Procedure GetMoradoresFromBairro(out p_total int, in p_fkBairro int)
begin
	select count(*) into p_total
    from morador
    where fk_idBairro = p_fkBairro;
end %%
Delimiter ;

Call GetMoradoresFromBairro(@total, 8);
select @total;

-- Parâmetro (INOUT - Entra com um valor mas a saíde é difernete)
Delimiter %%
Create Procedure atualizarVagas(in p_idevento int, inout p_vagas int)
begin
	update evento
    set qtd_vagas  = p_vagas + qtd_vagas
    where idevento = p_idevento;
    
    select qtd_vagas into p_vagas
    from evento
    where idevento = p_idevento;
end %%
Delimiter ;

SET @vagas = 5;
call atualizarVagas(8, @vagas);
Select @vagas;

-- Condicionais (IF - ELSE)
Delimiter %%
Create Procedure ValidarVagas(in p_ideventos int)
begin
	declare v_vagas int;
    declare v_evento int;
    
    select qtd_vagas, idevento into v_vagas, v_evento
    from evento
    where idevento = p_idevento;
    
    if (v_vagas >= 0) and (p_idevcento <= v_evento)
    then
		select 'Evento com vagas disponíveis';
	else
		select 'Eventos sem vagas';
	end if;
end %%
Delimiter ;

CALL ValidarVagas(0);

drop Procedure atualizarVagas;
