-- Criação e edição de tabela:
Create database AtividadeClasse;

 CREATE TABLE Produto(
	idProduto INT PRIMARY KEY AUTO_INCREMENT,
    nome  VARCHAR(100) NOT NULL,
    preco FLOAT(8,2) NOT NULL,
    dt_validade Date
 );
  -- A colula DEFAULT é ´pra definir um valor padrão para o atributo
  -- []
  
 Show tables;
 
 DESC Produto; -- mostra a descrissão da tabela
 
 ALTER TABLE Produto RENAME TO Produtos;
 
 SHOW tables;
 
alter table produtos change preco valor FLOAT(8,2) NOT NULL; 
 -- Aqui tem que repedir o tipo do nome, se não ele muda pro padrão
 
 ALTER TABLE produtos modify valor decimal(7,2) NOT NULL;
 
  DESC Produtos;
  
   ALTER TABLE Produtos ADD column quantidade int not null , add column fabricante varchar(50); -- para add várias colunas de uma unica vez int não precisa do tamanho mas varchar sim
   
  ALTER TABLE Produtos drop column fabricante; -- Para remover atributo, para apagar mais de um basta por uma virtgula e fazer como o de cima.
 
 -- Inserir valores na tabela:
 
 insert into Produtos values (null, 'Coca-Cola 350ml', 5.50, '2025-10-29', 10); -- para datas e caracteres precisa ter '' mas número não precisa.
 
  insert into Produtos values (null, 'Coca-Cola 350ml', 5.50, '2025-10-29', 10), 
							  (null, 'Coca-Cola 500ml', 10, '2025-10-29', 10);  -- Como o idProduto é autoinrement não precida add, se coloca null.
                              
 insert into Produtos (nome , valor, quantidade) Values ('Arroz', 6.25, 10); -- add valores específicos
 
  insert into Produtos (nome , valor, quantidade) Values ('Feijão', 9.99, 12),
														 ('Macarrão', 3.80, 5),
                                                         ('Frango', 15.99, 5);

 
 select * from produtos; -- Pega todos os valores da tabela
 
 -- Para atualizar o registro de um dado da tabela se usa o update
 update morador set telefone = '(83)98822-3344' where idmorador = 4;
 


update evento set dt_data = '2025-12-01', horario = '20:00:00' where idEvento = 6;

update evento set dt_data = '2025-12-01', horario = '20:00:00' where idEvento in (1,2,6); -- altera as mesmas informações para o conjuto de ids

-- Add chave estrangeira na tb 
Alter table morador add constraint fk_morador_bairro foreign key (IdBairro) references bairro(idBairro);

alter table evento add constraint fk_evento_morador foreign key (idMorador) references morador(idMorador), 
add constraint fk_evento_bairro foreign key (idBairro) references bairro(idBairro);
 
 
 
 

 
 
