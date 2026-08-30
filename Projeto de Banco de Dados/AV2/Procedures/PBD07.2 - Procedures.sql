/*
Projeto de Banco de Dados
Prof.ª M.ª Mariana Meirelles de Mello Oliveira
Semestre: 2026.1
Data: 05/05/2026

Aula 07 (Parte 2): Stored Procedures 
*/

DELIMITER $$
CREATE PROCEDURE ola_mundo()
BEGIN
	SELECT 'Ola Mundo!';
END $$
DELIMITER ;

CALL ola_mundo();

-- Criar procedure que mostre todos os moradores
DELIMITER $$
CREATE PROCEDURE listar_moradores()
BEGIN
	SELECT *
    FROM morador;
END $$
DELIMITER ;

CALL listar_moradores();

SELECT *
FROM morador
WHERE nome = 'Juliana Martins';

DELIMITER $$
CREATE PROCEDURE buscar_morador(IN p_nome VARCHAR(100))
BEGIN
	SELECT *
    FROM morador
    WHERE nome = p_nome;
END $$
DELIMITER ;

CALL buscar_morador('Juliana');

DROP PROCEDURE buscar_morador;

SELECT *
FROM morador
WHERE nome LIKE '%ana%';

DELIMITER $$
CREATE PROCEDURE buscar_morador2(IN p_nome VARCHAR(100))
BEGIN
	SELECT *
    FROM morador
    WHERE nome LIKE CONCAT ('%', p_nome,'%');
END $$
DELIMITER ;

CALL buscar_morador2('Ana');

DROP PROCEDURE buscar_morador2;

/*
Procedure de Ola Mundo personalizado.
Ola Mundo, Mariana!
*/

DELIMITER $$
CREATE PROCEDURE ola_mundo_personalizado(
	IN p_nome VARCHAR(100))
BEGIN
	SELECT CONCAT ('Olá Mundo, ', p_nome, '!') as 'Boas Vindas';
END $$
DELIMITER ;

CALL ola_mundo_personalizado('Mariana');