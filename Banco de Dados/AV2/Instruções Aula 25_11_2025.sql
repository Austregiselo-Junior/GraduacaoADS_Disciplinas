-- Instruções Aula 25/11/2025

/*
 Não devemos realizar SELECTs separados para buscar as informações que desejamos.
 Podemos unir as tabelas através do uso do JOIN. Temos diferentes tipos de JOIN:
 - INNER JOIN: retorna as linhas que tem valores correspondentes em todas as tabelas.
 - LEFT JOIN: retorna todas as linhas da tabela a esquerda (a que aparecer antes no
 JOIN), mesmo que não tenha correspondência com as outras tabelas.
 - RIGHT JOIN: retorna todas as linhas da tabela a direita (a que aparecer por último
 JOIN), mesmo que não tenha correspondência com as outras tabelas.

 Sintaxe:
 SELECT campo1, campo2, campoN
 FROM tabela1 (alias)
 INNER/LEFT/RIGHT JOIN tabela2 (alias)
 ON chave_estrangeira = chave_primaria;

 O 'alias' é opcional, mas é muito utilizado para tirar duplicidade de nomes de campos
 iguais das tabelas. Verifique o uso do 'alias' no exemplo abaixo.
 No caso da consulta solicitada vamos usar um INNER JOIN, pois queremos que mostre osprofessores e suas respectivas disciplinas. Os professores que não tem disciplina associada, ou vice-versa, não nos interessa.
 */
 
 -- 7. Mostre o nome dos moradores e do bairro, mas usando alias.
 select m.nome 'nome do morador', b.nome 'nome do bairro'
 from morador m 
 inner join bairro b
 on m.fk_idBairro = b.idBairro
 order by m.nome;
 
 -- Mostre os eventos e seus bairros
 select e.titulo 'titulo do evento', b.nome 'nome do bairro'
 from evento e
 inner join bairro b
 on e.fk_idBairro = b.idBairro 
 order by e.titulo;
 
 -- Mostre todos os moradores e os seus eventos, mesmo aqueles que não tenham organizado evento
 select m.nome 'n do morador', e.titulo 'n do evento'
 from morador m
 left join evento e
 on m.idMorador = e.fk_idMorador;
 
  -- Mostre todos os moradores e os seus eventos, apenas aqueles que tenham organizado evento
 select m.nome 'n do morador', e.titulo 'n do evento'
 from morador m
 inner join evento e
 on m.idMorador = e.fk_idMorador;
 
 -- Mostre o nome e o telefone dos moradores do bairro “Mangabeira”.
 select m.nome 'n do morador', m.telefone 'telefone'
 from morador m
 inner join bairro b
 on m.fk_idBairro = b.idBairro
 where b.nome = 'Mangabeira';
 