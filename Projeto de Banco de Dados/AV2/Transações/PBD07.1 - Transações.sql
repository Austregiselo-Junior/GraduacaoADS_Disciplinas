/*
Projeto de Banco de Dados
Prof.ª M.ª Mariana Meirelles de Mello Oliveira
Semestre: 2026.1
Data: 05/05/2026

Aula 07 (Parte 1): Entendendo Transações 
*/

/*
TRANSAÇÕES

Uma transação é um conjunto de operações que devem ser executadas 
completamente ou não executadas.

Propriedades ACID
A – Atomicidade: tudo ou nada
C – Consistência: estado válido > estado válido
I – Isolamento: não a interferência entre transações
D – Durabilidade: após COMMIT, dados permanentes
*/

-- Desligar o autocommit
SELECT @@autocommit;
SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 0;

/*
Iniciar transação
Insert em inscrição
Update em evento (qtd_vagas)
Observar comportamentos
*/

START TRANSACTION;

INSERT INTO inscricao VALUES
(null, '2026-04-30', 2, 10);

INSERT INTO inscricao VALUES
(null, '2026-04-30', 3, 10);

UPDATE evento
SET qtd_vagas = qtd_vagas - 1
WHERE idEvento = 10;

SELECT *
FROM inscricao
WHERE fk_idEvento = 10;

ROLLBACK; -- Caso de erro, desfaz a transação

SELECT *
FROM evento
WHERE idEvento = 10;

COMMIT; -- Persiste, confirma a transação

/*
Prática:

- Crie um novo usuário
- Conceda permissão apenas no SELECT para todas as tabelas
- Conceda permissão para INSERT em apenas na tabela, inscrição
- Teste inserir em evento: ERRO
- Teste inserir em inscrição: FUNCIONAR
- Revogar INSERT
- Criar uma transação:
	- Inserir inscrição
	- Atualizar vagas
	- Testar com:
		COMMIT
		ROLLBACK
*/

-- Analisem esse script:

START TRANSACTION;

INSERT INTO inscricao (fk_idMorador, fk_idEvento)
VALUES (1, 10);

UPDATE evento
SET qtd_vagas = qtd_vagas - 1
WHERE idEvento = 10;

UPDATE evento
SET qtd_vagas = -10
WHERE idEvento = 10; -- Nao é permitido pois viola regra do check

COMMIT;

SHOW CREATE TABLE evento; -- Verificar a regra existente no check


SELECT qtd_vagas 
FROM evento 
WHERE idEvento = 10;

-- Iniciar uma transação

START TRANSACTION;

UPDATE evento
SET qtd_vagas = 50
WHERE idEvento = 10;

-- O valor já foi alterado no banco?

COMMIT;

SET autocommit = 0;
-- Valor alterado após o COMMIT

START TRANSACTION;

UPDATE evento
SET qtd_vagas = 30
WHERE idEvento = 10;

SELECT qtd_vagas 
FROM evento 
WHERE idEvento = 10;

ROLLBACK;

SELECT qtd_vagas 
FROM evento 
WHERE idEvento = 10;

-- Pratica 1:
/*
Um morador será inscrito em um evento. 
Para isso, o sistema deveria:

	Inserir uma linha na tabela inscricao;
	Diminuir uma vaga na tabela evento;
	Confirmar a operação apenas se tudo estiver correto.
*/
/*
Quantidade de vagas antes: 50 
Quantidade de inscrições antes: 3
*/

-- Verificar a situação atual no evento e em inscrições

SELECT idEvento, titulo, qtd_vagas
FROM evento
WHERE idEvento = 10;

SELECT count(*)
FROM inscricao
WHERE fk_idEvento = 10;

-- Iniciar a transação
START TRANSACTION;

-- Fazer uma inscrição no evento 10
INSERT INTO inscricao (fk_idMorador, fk_idEvento)
VALUES (4, 10);

/*
A inscrição apareceu?
Ela já está definitivamente salva?
*/
SELECT *
FROM inscricao
WHERE fk_idEvento = 10;

-- Atualizar vagas
UPDATE evento
SET qtd_vagas = qtd_vagas - 1
WHERE idEvento = 10;

SELECT idEvento, titulo, qtd_vagas
FROM evento
WHERE idEvento = 10;

/*
O número de vagas diminuiu?
A transação já terminou?
*/

-- Atualize erroneamente a qtd_vagas
UPDATE evento
SET qtd_vagas = -10
WHERE idEvento = 10;

/*
Como um erro aconteceu no meio da transação, 
devemos usar COMMIT ou ROLLBACK?
*/
-- Desfazer a transação
ROLLBACK;

SELECT idEvento, titulo, qtd_vagas
FROM evento
WHERE idEvento = 10;

SELECT *
FROM inscricao
WHERE fk_idEvento = 10;

/*
Quantidade de vagas antes: 50
Quantidade de vagas depois do ROLLBACK: 50

Quantidade de inscrições antes: 3
Quantidade de inscrições depois do ROLLBACK: 3
*/

-- Realizar o processo correto e confirmar ao final
START TRANSACTION;

INSERT INTO inscricao (fk_idMorador, fk_idEvento)
VALUES (4, 10);

UPDATE evento
SET qtd_vagas = qtd_vagas - 1
WHERE idEvento = 10;

COMMIT;

SELECT idEvento, titulo, qtd_vagas
FROM evento
WHERE idEvento = 10;

SELECT *
FROM inscricao
WHERE fk_idEvento = 10;
/*
Quantidade de vagas antes: 50
Quantidade de vagas depois do COMMIT: 49

Quantidade de inscrições antes: 3
Quantidade de inscrições depois do COMMIT: 4
*/

/*
1. O que aconteceu com a inscrição após o ROLLBACK?
2. Por que o UPDATE qtd_vagas = -10 deu erro?
3. Por que usamos ROLLBACK e não COMMIT após o erro?
4. O que mudou quando usamos COMMIT no segundo teste?
5. Qual propriedade ACID foi demonstrada nesse exemplo?
*/

/*
Transação = conjunto de operações
COMMIT = confirma
ROLLBACK = desfaz
*/