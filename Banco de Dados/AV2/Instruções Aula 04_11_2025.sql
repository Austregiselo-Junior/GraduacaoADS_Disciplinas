-- Instruções Aula 04/11/2025

-- UPDATE - é um comando para alterar dados já inseridos em uma tabela (entidade).

update morador 
set telefone = '(83)988223342'
where idMorador = 4;

update evento 
set data = '2025-12-01',
horario = '20:00:00'
where idEvento = 6; -- atualizando dado em apenas um idEventos

update evento 
set data = '2025-12-01',
horario = '20:00:00'
where idEvento in (1,4,6); -- atualizando dados em vários idEventos

select * from evento;

-- Criando chave estrangeira (Uma chave estrangeira (FOREIGN KEY) é um campo que cria vínculo entre duas tabelas, garantindo a integridade referencial dos dados.)

alter table morador -- tablela filha
add constraint fk_morador_bairro -- adicionando a restrição (regra) na tabela morador com o nome fk_morador_bairro
foreign key (fk_idBairro) -- defini qual coluna da tyabela morador recebe o ID da tabela pai
references bairro (idBairro); -- indica a tebela e a coluna de origem da chave estrangeira

alter table evento 
add constraint fk_evento_morador
foreign key (fk_idMorador) references morador (idMorador),
add constraint fk_evento_bairro 
foreign key (fk_idBairro) references bairro (idBairro);