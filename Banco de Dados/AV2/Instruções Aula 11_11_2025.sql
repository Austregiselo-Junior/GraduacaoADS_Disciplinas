-- Instruções Aula 11/11/2025

-- Para apagar um dado específico utilizamos o DELETE, é um comando DML - Data Manipulation Language
select * from evento where idEvento = 7;
delete from evento where idEvento = 7;

select * from evento; -- É um comando DQL (consulta de dados). 

-- Para apagar todos os registros de uma tabela sem apagar a tabela, usamos o truncate

-- Usos do select:
select 'Calculo', 2 + 2;

select data as 'Data', horario, titulo from evento;

-- Para campos de data podemos utilizar a função DATE_FORMAT que irá formatar a data no formato que desejarmos. Atenção! Essa função não altera a forma como o dado foi inserido, ele apenas altera a formatação na exibição (SELECT).

/*
DATE_FORMAT(data, formato) - formata uma data de acordo com o formato especificado

 %d - dia
 %m - mês
 %Y - ano
*/

select date_format('2025-12-01', '%d/%m/%y');

select date_format(data, '%d/%m/%y') as 'Data', 
horario, 
titulo 
from evento;

-- Filtro com WHERE, Operadores lógicos e LIKE

select * from bairro where idBairro = 4;
select * from bairro where idBairro in (4,7,9);

-- Operadores Lógicos:
/*
AND (e) - tem que satisfazer todas as condições para ser apresentado na consulta
OR (OU) - se satisfizer uma das condições é apresentado no resultado da consulta
NOT (nao) - negação, traz o resultado oposto
*/
-- not
select * from bairro where idBairro not in (1, 2, 3);

-- like
select * from bairro where nome  like 'B%';
select * from bairro where nome  like '%s';
select * from bairro where nome  like '%c%';

Select nome, populacao from bairro where populacao >= 5000;

-- or
select nome, populacao from bairro where nome like 'B%' or populacao >= 9000;

-- BETWEEN: quando quiser buscar um intervalo de valores.
select nome, populacao 
from bairro 
where populacao between 9001 and 14999 
and nome like 'b%';

-- Ordenando e limitando resultados
/*O ORDER BY ordena o resultado de uma consulta de acordo com o campo passado de
forma crescente (ASC) ou decrescente (DESC). O ASC é a ordenação padrão, então pode ser omitido. 
*/
select * from bairro order by nome;
select * from bairro order by nome desc;
select * from bairro order by nome limit 3;

select * from bairro 
where populacao >= 5000 
and nome like 'a%'
order by nome limit 5;


