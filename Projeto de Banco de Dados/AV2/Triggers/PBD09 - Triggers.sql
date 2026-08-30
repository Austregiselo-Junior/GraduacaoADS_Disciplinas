/*
Projeto de Banco de Dados
Prof.ª M.ª Mariana Meirelles de Mello Oliveira
Semestre: 2026.1
Data: 19/05/2026

Aula 09: Triggers
*/

/* 
TRIGGER 

Uma trigger (gatilho) no MySQL é um conjunto de 
instruções que é automaticamente executado em resposta 
a determinados eventos em uma tabela. 
Esses eventos podem ser operações como INSERT, DELETE 
ou UPDATE de registros na tabela.
A trigger pode ser acionada antes de uma operação 
(BEFORE) ou depois (AFTER).

Antes de criar uma trigger devemos trocar o 
delimitador.

Sintaxe:

DELIMITER $$
CREATE TRIGGER NOME_TRIGGER
BEFORE/AFTER INSERT/DELETE/UPDATE ON NOME_TABELA
FOR EACH ROW
BEGIN
	
    COMANDOS;

END $$
DELIMITER ;

BEFORE - trigger executa antes da operação
AFTER - trigger executa após a operação
INSERT - trigger é acionada quando tem insert na tabela
DELETE - trigger é acionada quando tem delete na tabela
UPDATE - trigger é acionada quando tem update na tabela
FOR EACH ROW - executa para cada linha afetada
*/

/*
OLD e NEW:
	NEW - Representa os novos valores.
		  Usado em: INSERT e UPDATE
    OLD - Representa os valores antigos.
		  Usado em: UPDATE e DELETE
*/

-- EXEMPLOS 

/* Criar uma tabela de log para salvar a informação
quando uma inscrição é realizada. */

CREATE TABLE IF NOT EXISTS log_inscricao(
	idLog INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_log_inscricao
AFTER INSERT ON inscricao
FOR EACH ROW
BEGIN
	
    INSERT INTO log_inscricao(mensagem) VALUES
    (concat('Inscrição realizada. Id inscrição: ', 
    NEW.idinscricao));
    
END $$
DELIMITER ;

-- Testando a trigger
-- Registrar uma nova inscrição
SELECT * FROM log_inscricao;
SELECT * FROM inscricao;

INSERT INTO inscricao (data_hora, fk_idmorador, fk_idevento)
VALUES (NOW(), 3, 5),
	   (NOW(), 5, 1);
       
SELECT * FROM inscricao;
SELECT * FROM log_inscricao;

/* Impedir inscrição em evento sem vagas. */
DELIMITER $$
CREATE TRIGGER trg_validar_vagas
BEFORE INSERT ON inscricao
FOR EACH ROW
BEGIN
	
    DECLARE v_vagas INT;
    
    -- Verificar quantidade de vagas do evento
	SELECT qtd_vagas INTO v_vagas
    FROM evento
    WHERE idevento = NEW.fk_idevento;
    
    -- Verificar qtd_vagas 
    IF v_vagas <= 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vagas indisponíveis.';
	END IF;

END $$
DELIMITER ;

SELECT * FROM evento;

-- Testando a trigger
-- Atualizar a quantidade de vagas de um evento para 0 e tentar realizar uma inscrição no evento
UPDATE evento
SET qtd_vagas = 0
WHERE idevento = 1;

SHOW CREATE TABLE evento;

-- CONSTRAINT `chk_evento_qtd_vagas` CHECK ((`qtd_vagas` > 0))

ALTER TABLE evento
DROP CONSTRAINT chk_evento_qtd_vagas;

ALTER TABLE evento
ADD CONSTRAINT chk_evento_qtd_vagas
CHECK (qtd_vagas >= 0);

UPDATE evento
SET qtd_vagas = 0
WHERE idevento = 1;

SELECT * FROM evento WHERE idevento = 1;

INSERT INTO inscricao (data_hora, fk_idmorador, fk_idevento)
VALUES (now(), 8, 1);

SELECT * FROM inscricao;
SELECT * FROM log_inscricao;

INSERT INTO inscricao (data_hora, fk_idmorador, fk_idevento)
VALUES (now(), 12, 4),  
	   (now(), 10, 1);

/*
Ao realizar inscrição diminuir quantidade 
de vagas.
*/
DELIMITER $$
CREATE TRIGGER trg_atualizar_vagas
AFTER INSERT ON inscricao
FOR EACH ROW
BEGIN

	UPDATE evento
    SET qtd_vagas = qtd_vagas - 1
    WHERE idevento = NEW.fk_idevento;
    
END $$
DELIMITER ;

-- Testando trigger
-- Validar a quantidade de vagas antes e depois realizar uma nova inscrição
SELECT * FROM evento WHERE idevento = 10;

INSERT INTO inscricao (data_hora, fk_idmorador, fk_idevento)
VALUES (now(), 12, 10),  
	   (now(), 10, 10);
       
SELECT * FROM log_inscricao;

/* Registrar alterações de vagas. */
CREATE TABLE auditoria_evento (
    idAuditoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_evento VARCHAR(100),
    vagas_antes INT,
    vagas_depois INT,
    data_alteracao DATETIME 
);

DELIMITER $$
CREATE TRIGGER trg_auditoria_vaga
AFTER UPDATE ON evento
FOR EACH ROW
BEGIN

	INSERT INTO auditoria_evento (
		nome_evento,
        vagas_antes,
        vagas_depois,
        data_alteracao
    ) VALUES(
		OLD.titulo,
        OLD.qtd_vagas,
        NEW.qtd_vagas,
        now()
    );

END $$
DELIMITER ;

SELECT * FROM evento WHERE idevento = 10;

UPDATE evento
SET qtd_vagas = 80
WHERE idevento = 10;

DROP TRIGGER trg_auditoria_vaga;

SELECT * FROM auditoria_evento;

-- Testando trigger
-- Atualizar a quantidade de vagas de um evento e depois validar a tabela de auditoria


/* Registrar exclusões de eventos. */

CREATE TABLE log_exclusao_evento (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    nome_evento VARCHAR(100),
    data_exclusao DATETIME 
);

-- Testando a trigger
-- Apagar um evento e depois validar a tabela de log.

-- EXERCÍCIOS
/*
1. Crie uma trigger que:
	registre em uma tabela de log
	toda vez que um morador for inserido

2. Crie uma trigger que:
	ao excluir uma inscrição
	devolva 1 vaga ao evento

3. Criar trigger que:
	impeça inscrição duplicada
	mesmo morador no mesmo evento
    -- Dica: Use COUNT(*) e SIGNAL SQLSTATE '45000'
*/
