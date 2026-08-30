-- Transação é um conjunto de operações SQL que devem acontecer como uma única unidade lógica.
-- Tudo dá certo ou nada é salvo.

-- Objetivo da Transação

-- Garantir:
-- integridade dos dados
-- consistência
-- segurança
-- recuperação em caso de erro

-- Uma transação é um conjunto de operações que devem ser executadas completamente ou não executadas.

select * from inscricao;
select * from evento;

Start transaction;
insert into inscricao values (null, '2026-04-30', 2, '10');
Update evento set qtd_vagas = qtd_vagas -10 where idEvento = 10;
commit;

-- OBS: Sem transação a inscrição poderia ser salva mas as vagas não seriam atualizadase o banco ficaria inconsistente.

update evento set qtd_vagas = -10;
rollback;

-- OBS: Durante a transaction pode fazer select para ver a mudanças, mas sem o commit a mudança não é confirmada.
-- ROLLBACK desfaz apenas alterações ainda não confirmadas;

SELECT @@autocommit; -- Verifica se o auto commit está ativado
SET autocommit = 1; -- ativar auto commit
SET autocommit = 0; -- desativar auto commit
