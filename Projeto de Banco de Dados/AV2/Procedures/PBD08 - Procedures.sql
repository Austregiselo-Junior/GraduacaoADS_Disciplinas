/*
Projeto de Banco de Dados
Prof.ª M.ª Mariana Meirelles de Mello Oliveira
Semestre: 2026.1
Data: 12/05/2026

Aula 08: Stored Procedures (continuação)
*/

-- OUT
/*
Desenvolva uma procedure que informe a quantidade 
de moradores total.
*/

SELECT COUNT(*) 
FROM morador;

DELIMITER $$
CREATE PROCEDURE contar_moradores(OUT total_morador INT)
BEGIN
	
    SELECT COUNT(*) INTO total_morador 
    FROM morador;
    
END $$
DELIMITER ;

CALL contar_moradores(@valor);
SELECT @valor;

-- Variáveis de sessão (temporário)
SET @n = 'ADS';
SELECT @n;

/*
Desenvolva uma procedure que informe a quantidade 
de moradores total, por bairro.
*/

SELECT COUNT(*)
FROM morador
WHERE fk_idBairro = 1;

DELIMITER $$
CREATE PROCEDURE qtd_morador_bairro(OUT p_total INT,
									IN p_fkbairro INT)
BEGIN
	
	SELECT COUNT(*) INTO p_total
    FROM morador
    WHERE fk_idbairro = p_fkbairro;
    
END $$
DELIMITER ;

CALL qtd_morador_bairro(@total, 8);
SELECT @total as 'Qtd';

/*
Desenvolva uma procedure que receba o id de um 
evento e retorne a quantidade de inscritos 
cadastrados nele.
*/

SELECT COUNT(*)
FROM inscricao
WHERE fk_idEvento = 10;

-- INOUT

/*
Desenvolva uma procedure que atualize a quantidade 
de vagas de um evento. 
Deve receber quantas vagas aumentar e retornar a 
nova quantidade de vagas disponível para o evento.
*/

SELECT titulo, qtd_vagas
FROM evento
WHERE idEvento = 8; -- 50 vagas disponíveis

DELIMITER $$
CREATE PROCEDURE atualizar_vagas(IN p_idevento INT,
								 INOUT p_vagas INT)
BEGIN
	
    UPDATE evento
    SET qtd_vagas = p_vagas + qtd_vagas 
    WHERE idevento = p_idevento;
    
    SELECT qtd_vagas INTO p_vagas
    FROM evento
    WHERE idevento = p_idevento;
    
END $$
DELIMITER ;

SET @vagas = 5;
SELECT @vagas as 'Antes da Procedure';
CALL atualizar_vagas(8, @vagas);
SELECT @vagas as 'Após procedure';

SELECT titulo, qtd_vagas
FROM evento
WHERE idEvento = 6; -- 100 vagas disponíveis

-- Versão 2.0
DELIMITER $$
CREATE PROCEDURE atualizar_vagas_v2(IN p_idevento INT,
								    INOUT p_vagas INT)
BEGIN
	DECLARE v_vagas INT;
    
    SELECT qtd_vagas INTO v_vagas
    FROM evento
    WHERE idevento = p_idevento;
    
    SET p_vagas = v_vagas + p_vagas;
    
    UPDATE evento
    SET qtd_vagas = p_vagas
    WHERE idevento = p_idevento;
    
END $$
DELIMITER ;

SET @total = 10;
SELECT @total as 'Antes';
CALL atualizar_vagas_v2(6, @total);
SELECT @total;
DROP PROCEDURE atualizar_vagas_v2;

/*
Desenvolva uma procedure que: receba o valor atual 
da inscrição, aplique um desconto de 10% e retorne 
o novo valor atualizado.
*/
DELIMITER $$
CREATE PROCEDURE desconto_inscricao(INOUT p_valor FLOAT(6,2))
BEGIN
	
    SET p_valor = p_valor - (p_valor * 0.1);
    
END $$
DELIMITER ;

SET @valor = 120;
CALL desconto_inscricao(@valor);
SELECT @valor;

-- IF
/*
Em um sistema de gestão de eventos, desenvolva uma 
stored procedure que receba o id de um evento e 
informe se ele ainda possui vagas disponíveis.
*/

SELECT max(idEvento)
from evento;

DELIMITER $$
CREATE PROCEDURE validar_vagas(IN p_idevento INT)
BEGIN 
	DECLARE v_vagas INT;
    DECLARE v_evento INT;
    
    SELECT qtd_vagas, MAX(idevento)
    INTO v_vagas, v_evento
    FROM evento
    WHERE idevento = p_idevento;
           
    IF (v_vagas > 0) AND (p_idevento <= v_evento)THEN
		SELECT 'Evento com vagas disponíveis.';
	ELSE
		SELECT 'Evento indisponível.';
	END IF;
    
END $$
DELIMITER ;

CALL validar_vagas(0);
DROP PROCEDURE validar_vagas;

/*
Adapte a procedure anterior para ele retornar o status
através de uma variável de saída.
*/



/*
Adapte a procedure anterior para que mostre além da
mensagem de status, o titulo do evento e a quantidade
de vagas.
*/
