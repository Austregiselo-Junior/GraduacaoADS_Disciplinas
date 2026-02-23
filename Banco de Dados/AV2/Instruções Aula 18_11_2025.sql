-- Instruções Aula 18/11/2025

/*
 FUNÇÕES DE AGREGAÇÃO:

 COUNT() - Conta registros
 SUM() - Soma valores numéricos
 AVG() - Calcula a média
 MAX() - Maior valor
 MIN() - Menor valor
 */
 -- Quantos moradores existem no total?
 select count(*) as 'Qtd Modador' from morador;
 
-- Quantos bairros existem cadastrados?
select count(*) as 'Qtd Bairros' from bairro;
 
-- Qual é a maior população entre os bairros?
select max(populacao) as 'Maior populacao' from bairro;

-- Qual é a média de população dos bairros?
select avg(populacao) as 'media de populacao' from bairro;
select round(avg(populacao), 1) as 'media de populacao' from bairro;

-- Quantos eventos existem cadastrados?
select count(*) as 'Qtd Eventos' from evento;

/*
GROUP BY (Agrupamento)
Mostra os totais por categoria, agrupando dados.
O GROUP BY é usado em SQL para agrupar registros que possuem valores iguais
em uma ou mais colunas.
Ele permite transformar vários registros individuais em grupos, sobre os quais
podemos aplicar funções de agregação.
*/

-- Quantidade de eventos por ano
select year(data) as 'Ano', count(*) as 'Qtd'
from evento
group by year(data);

update evento set data = '2026-03-11'
where idEvento in (1,4);

-- Quantidade de eventos por mês de forma crecente
select month(data) as 'Mês', count(*) as 'Qtd'
from evento
group by month(data)
order by month(data);

-- Contar moradores por código do bairro
select count(*) as 'Qtd', fk_idBairro as 'Cogido do Bairro' 
from morador
group by fk_idBairro;

/*
HAVING

 O HAVING é usado para filtrar grupos depois que eles já
 foram formados pelo GROUP BY.

 - Ele não filtra linhas individuais.
 - Ele filtra grupos inteiros.

 ATENÇÃO! Sempre usado junto de GROUP BY

 WHERE X HAVING

 WHERE - Filtra linhas.
 HAVING - Filtra grupos.
 */
 
 -- Mostrar meses que têm mais de 1 evento
 select month(data) as 'mês', count(*) as 'Qtd'
 from evento 
 group by(data)
 having count(*) > 1;
 
 -- Mostrar bairros (apenas o código) com mais de 1 morador
 select fk_idBairro as 'Num bairro', count(*) as 'Qtd'
 from morador
 group by fk_idBairro
 having count(*) > 1;
 
 -- Mostrar anos que tiveram mais de 2 eventos
 select year(data) as 'Ano do evento', count(*) as 'Qtd'
 from evento
 group by year(data)
 having count(*) > 2
 order by year(data);