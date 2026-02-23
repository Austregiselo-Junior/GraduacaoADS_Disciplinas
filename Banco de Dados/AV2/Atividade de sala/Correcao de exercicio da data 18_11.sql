
/*
Instruções Aula 18/11/2025 

Obs.: Procure utilizar nas suas consultas Alias!
*/




-- Atividade:

-- 1. Mostre quantos eventos aconteceram em cada mês de 2025.
select year(dt_data) as 'ano', count(*) as 'qtd' from evento group by year(dt_data);

select * from evento;

-- 2. Mostre quantos moradores existem em cada código de bairro.
select year(populacao) as 'qtd moradores', count(*) as 'idbairro' from bairro group by(populacao);

-- 3. Mostre os meses que tiveram mais de 1 evento.


-- 4. Mostre a média de população dos bairros.

-- 5. Mostre o maior valor de população entre os bairros.

-- 6. Liste somente os anos que tiveram mais de 1 evento.
Select year(data) 'ano', count(*) 'qtd' from evento group by year(data) having count(*) >1 order by year(data);

-- 7. Quantos bairros têm mais de 10 mil habitantes?


-- Dúvidas: 
-- Para que serve o * no Count(*)? 
-- Resposta: Serve para trazer todos os dados de uma tabela, o * ler todas as linhas mas pode colocar uma coluna específica que o resultado será as linhas quie tiver valor da coluna.

 