/*
Atividade Prática Avaliativa Final
26/05/2026
Projeto de Banco de Dados — Valor: até 3,0 pontos
Tema da atividade: Sistema de Reserva de Equipamentos Acadêmicos

Contexto
Uma instituição de ensino possui equipamentos que podem ser reservados por professores para uso em aulas e projetos.

A equipe deverá importar o banco fornecido e implementar um fluxo utilizando:
    procedures;
    triggers;
    transações;
    usuários;
    permissões.

Só pode consultar material da disciplina. Outro material não é permitido e a equipe perderá os pontos.
*/

/*
Integrantes Grupo Desenvolvedor: (Nome Sobrenome e Matrícula)
*/

-- Script inicial do banco (SÓ EXECUTAR)

CREATE DATABASE IF NOT EXISTS reserva_equipamentos;
USE reserva_equipamentos;

DROP TABLE IF EXISTS log_reserva;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS equipamento;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS setor;

CREATE TABLE setor (
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL
);

CREATE TABLE professor (
    idProfessor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fk_idSetor INT NOT NULL,
    FOREIGN KEY (fk_idSetor) REFERENCES setor(idSetor)
);

CREATE TABLE equipamento (
    idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    quantidade_disponivel INT NOT NULL
);

CREATE TABLE reserva (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    fk_idProfessor INT NOT NULL,
    fk_idEquipamento INT NOT NULL,
    data_reserva DATE NOT NULL,
    quantidade INT NOT NULL,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_idProfessor) REFERENCES professor(idProfessor),
    FOREIGN KEY (fk_idEquipamento) REFERENCES equipamento(idEquipamento)
);

CREATE TABLE log_reserva (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    idReserva INT,
    descricao VARCHAR(255),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO setor (nome) VALUES
('Coordenação de ADS'),
('Laboratório de Informática'),
('Extensão Universitária');

INSERT INTO professor (nome, email, fk_idSetor) VALUES
('Ana Souza', 'ana.souza@faculdade.com', 1),
('Carlos Lima', 'carlos.lima@faculdade.com', 2),
('Mariana Costa', 'mariana.costa@faculdade.com', 3);

INSERT INTO equipamento (nome, tipo, quantidade_disponivel) VALUES
('Projetor Epson', 'Imagem', 3),
('Notebook Dell', 'Computador', 5),
('Caixa de Som JBL', 'Áudio', 2),
('Microfone Sem Fio', 'Áudio', 4),
('Câmera Logitech', 'Vídeo', 1);

-- ---------------------------------------------------------- ATIVIDADE ---------------------------------------------------------- 

/*
Parte 1 — Procedure com transação

Criar uma procedure chamada:

realizar_reserva(
    IN p_idProfessor INT,
    IN p_idEquipamento INT,
    IN p_dataReserva DATE,
    IN p_quantidade INT
)

A procedure deverá:
    Iniciar uma transação.
    Inserir uma reserva na tabela reserva.
    Confirmar a transação com COMMIT.
*/

-- Resposta da Parte 1 abaixo


/*
Parte 2 — Trigger BEFORE INSERT

Criar uma trigger BEFORE INSERT na tabela reserva para validar:
    A quantidade reservada não pode ser maior que a quantidade disponível.

Caso a regra seja violada, usar:

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'mensagem do erro';

Obs.: Pode personalizar a mensagem de erro
*/

-- Resposta da Parte 2 abaixo


/*
Parte 3 — Trigger AFTER INSERT

Criar uma trigger AFTER INSERT na tabela reserva para:
    Reduzir a quantidade disponível do equipamento reservado.
    Inserir um registro na tabela log_reserva.

Exemplo:
    Reserva realizada com sucesso.
*/

-- Resposta da Parte 3 abaixo


/*
Parte 4 — Usuário e permissões

Criar o usuário:
    usuario_reserva

Permissões necessárias:
    SELECT
    INSERT
    EXECUTE
*/

-- Resposta da Parte 4 abaixo


-- ---------------------------------------------------------- TESTES ---------------------------------------------------------- 

/*
Após finalizar a implementação:

Um outro grupo virá testar o seu banco.
E seu grupo testará o banco de outro grupo.

O grupo responsável pelos testes deverá validar:
    reservas válidas;
    reservas inválidas;
    funcionamento das triggers;
    funcionamento das permissões.

Ao final de cada teste o grupo avaliador deverá colocar uma avaliação do teste.
Se foi sucesso ou se apresentou falha.

Não devem ser feitas correções.

Integrantes Grupo Avaliador: (Nome Sobrenome e Matrícula)
*/


/*
Teste 1 — Reserva válida

CALL realizar_reserva(1, 1, '2026-06-10', 1);

Resultado esperado:
    reserva realizada;
    quantidade reduzida;
    log gerado.
*/

-- Grupo Avaliador deve validar o resultado e apresentar parecer abaixo.


/*
Teste 2 — Quantidade inválida

CALL realizar_reserva(1, 5, '2026-06-11', 3);

Resultado esperado: erro gerado pela trigger.
*/

-- Grupo Avaliador deve validar o resultado e apresentar parecer abaixo.


/*
Teste 3 — Permissões

Entrar com o usuário usuario_reserva e executar:

CALL realizar_reserva(2, 2, '2026-06-12', 1);

Resultado esperado: procedure executada com sucesso.
*/

-- Grupo Avaliador deve validar o resultado e apresentar parecer abaixo.


/*
Entregáveis

Cada grupo deverá entregar:

    Script .sql completo;
    procedure;
    triggers;
    usuário e permissões;
    testes realizados.
*/