-- Instruções Aula 28/10/2025

-- 1. Crie uma database: sistema_comunitario;
Create Database Sistema_Comunitario;
Use Sistema_Comunitario;

-- 2. Crie as tabelas com os seus campos e regras de acordo com o que é pedido no modelo lógico.
Create table bairro (
idBairro int primary key auto_increment,
nome int not null,
popupacao int
);

Create table morador (
idModarot Int primary key auto_increment,
nome varchar(100) not null,
telefone varchar(20),
fk_idBairro Int not null
);

CREATE TABLE evento (  -- Esse é um comando Linguagem de Definição de Dados (DDL)
 idEvento INT PRIMARY KEY AUTO_INCREMENT,
 titulo VARCHAR(150) NOT NULL,
 data DATE,
 horario TIME,
 fk_idMorador INT NOT NULL,
 fk_idBairro INT NOT NULL
);

Show tables;

-- 3. Se necessário faça alguma alteração na tabela, caso tenha esquecido de algo.
Alter table bairro modify nome Varchar(150) Not null; -- Esse é um comando Linguagem de Definição de Dados (DDL)

-- Alterar nome de coluna
Alter table bairro change popupacao populacao int; -- Esse é um comando Linguagem de Definição de Dados (DDL)

-- 4. Insira registros nas tabelas.
insert into bairro (nome, populacao) values -- Esse é um comando Linguagem de Manipulação de Dados (DML)
('Tambaú', 9500),
('Manaíra', 12000),
('Bancários', 8700),
('Cabo Branco', 6400),
('Mangabeira', 18500),
('Altiplano', 5200),
('Torre', 9100),
('Bessa', 11300);
select * from bairro; -- Linguagem de consulta de dados (DQL)

INSERT INTO morador (nome, telefone, fk_idBairro) VALUES
('Ana Souza', '(83)98811-2233', 1),
('João Pereira', '(83)99902-4455', 2),
('Maria Oliveira', '(83)98777-8899', 3),
('Lucas Almeida', '(83)98822-3344', 4),
('Fernanda Costa', '(83)99123-4567', 5),
('Pedro Silva', '(83)98700-9988', 8),
('Carla Mendes', '(83)99654-3210', 7),
('Rafael Lima', '(83)98855-6677', 6),
('Camila Ramos', '(83)99933-2244', 2),
('Bruno Nogueira', '(83)98788-7766', 5);
desc morador;
alter table morador change idModarot idMorador int;
SELECT * FROM morador;

INSERT INTO evento (titulo, data, horario, fk_idMorador, fk_idBairro) VALUES
 ('Feira de Artesanato de Tambaú', '2025-11-20', '09:00:00', 1, 1),
 ('Corrida de Rua de Manaíra', '2025-08-12', '06:30:00', 2, 2),
 ('Festa de São João dos Bancários', '2025-06-15', '18:00:00', 3, 3),
 ('Limpeza da Praia de Cabo Branco', '2025-03-25', '08:00:00', 4, 4),
 ('Feira Cultural de Mangabeira', '2025-12-05', '19:30:00', 5, 5),
 ('Encontro Gastronômico do Bessa', '2025-09-01', '17:00:00', 6, 8),
 ('Caminhada da Saúde na Torre', '2025-05-10', '07:30:00', 7, 7),
 ('Mostra de Arte do Altiplano', '2025-04-18', '14:00:00', 8, 6),
 ('Piquenique da Família', '2025-07-14', '10:00:00', 9, 2),
 ('Ação Solidária Mangabeira 5', '2025-10-22', '09:30:00', 10, 5);
SELECT * FROM evento;

-- Adicionar dois novos atributos:
alter table morador add column apelido varchar(50);

-- Remover um atributo da tabela:
alter table morador drop column apelido;