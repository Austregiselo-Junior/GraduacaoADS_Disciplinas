-- Transações: Conjunto de operações SQL que devem acontecer como uma unidade lógica, tudo dá certo ou nada é salvo, evita a inconsistência
-- Objetivos: Integridade de dados, consistência, segurança e recuperação em caso de erro.

-- Propriedades ACID
-- A - Atomicidade -> tudo ou nada, se uma operação falar nada dar certo
-- C - Consistência -> O banco deve sair de um estado válido para outro estado válido
-- I - Isolamento -> Uma tansação não interfere na outra
-- D - Durabilidade -> Os dados ficam oermanentes após o COMMIT

-- Verifique se o banco o autocommit estar ativado:
Select @@autocommit;

-- Fazer o autocommit ficar ativo:
set autocommit = on;

-- Desligando autocommit:
set autocommit = 0;

-- Transação 
START TRANSACTION;
INSERT INTO inscricao VALUES
(null, '2026-04-30', 2, 10);

UPDATE evento
SET qtd_vagas = qtd_vagas - 1
WHERE idEvento = 10;
COMMIT; -- A alteração só fica permanente o commit for realizado

rollback -- Desfaz tudo da transação acima, é chamado se ocorrer alguma falha mas desfaz alterações ainda não comitadas

-- OBS: Dutante a transaction é importante sempre fazer select para observar as informações antes do commit


-- Exemplo que dar certo:
SET autocommit = 0;

START TRANSACTION;
UPDATE conta
SET saldo = saldo - 100
WHERE id = 1;

UPDATE conta
SET saldo = saldo + 100
WHERE id = 2;
COMMIT;

-- Exemplo de falha
START TRANSACTION;
UPDATE conta
SET saldo = saldo - 100
WHERE id = 1;

UPDATE conta
SET saldo = saldo + 'abc'
WHERE id = 2;
ROLLBACK;
