-- Atividade de classe 28/10
Create database sistema_comunitario;

 CREATE TABLE Bairro(
	idBairro INT PRIMARY KEY AUTO_INCREMENT,
    nome  VARCHAR(100) NOT NULL,
    populacao INT not null
 );
 
   insert into Bairro values (null, 'Tambaú', 9500), 
							 (null, 'Manaíra', 12000),
							 (null, 'Bancários', 8700), 
							 (null, 'Cabo Branco', 6400),
							 (null, 'Mangabeira', 18500), 
							 (null, 'Altiplano', 5200),
							 (null, 'Torre', 9100), 
							 (null, 'Bessa', 11300);
                             
select * from bairro;
   
 CREATE TABLE Morador(
	idMorador INT PRIMARY KEY AUTO_INCREMENT,
    nome  VARCHAR(100) NOT NULL,
    telefone  VARCHAR(50) NOT NULL,
    IdBairro Int
 );
    insert into Morador values (null, ' Ana Souza', '(83)98811-2233', 1), 
							   (null, 'João Pereira', '(83)99902-4455', 2),
							   (null, 'Maria Oliveira', '(83)98777-8899', 3), 
							   (null, 'Lucas Almeida', '(83)98822-3344', 4),
							   (null,  'Fernanda Costa', '(83)99123-4567', 5),
							   (null,  'Pedro Silva', '(83)98700-9988', 8),
								(null, 'Carla Mendes', '(83)99654-3210', 7),
								(null, 'Rafael Lima', '(83)98855-6677', 6),
								(null, 'Camila Ramos', '(83)99933-2244', 2),
								(null, 'Bruno Nogueira', '(83)98788-7766', 5);

 select * from morador;
 
  CREATE TABLE Evento(
	titulo VARCHAR(100) NOT NULL,
    dt_data Date,
    horario time,
    idMorador int,
    IdBairro Int
 );
 
     insert into evento values ('Feira de Artesanato de Tambaú', '2025-11-20', '09:00:00', 1, 1), 
							   ('Corrida de Rua de Manaíra', '2025-08-12', '06:30:00', 2, 2),
							   ('Festa de São João dos Bancários', '2025-06-15', '18:00:00', 3, 3), 
							   ('Limpeza da Praia de Cabo Branco', '2025-03-25', '08:00:00', 4, 4),
							   ('Feira Cultural de Mangabeira', '2025-12-05', '19:30:00', 5, 5),
							   ('Encontro Gastronômico do Bessa', '2025-09-01', '17:00:00', 6, 8),
								('Caminhada da Saúde na Torre', '2025-05-10', '07:30:00', 7, 7),
								('Mostra de Arte do Altiplano', '2025-04-18', '14:00:00', 8, 6),
								('Piquenique da Família', '2025-07-14', '10:00:00', 9, 2),
								('Ação Solidária Mangabeira 5', '2025-10-22', '09:30:00', 10, 5);
                                
                                ALTER TABLE evento ADD column idEvento INT PRIMARY KEY AUTO_INCREMENT;
                                select * from evento;

desc evento;
 
