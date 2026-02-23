-- Aula 25/11

-- consulta con Join, união de tabelas pra a informação ser mais produtiva
/*
Inner JOin -> Pega valosres iguais entre tabelas
left join -> Pega os valores a esquerda
right join -> Pega os valores a direita
*/

/*
Instruções Aula 25/11/2025 

Obs.: Use apenas JOINs explicados na aula.
*/

-- 1. Liste todos os moradores com o nome do bairro onde moram.
 select m.nome 'n_morador', b.nome 'n_Bairro' from morador m inner join bairro b on  m.fk_idbairro = b.idBairro;

-- 2. Liste todos os eventos com o nome do bairro onde acontecem.
select e.titulo 'nome do evento', b.nome 'n_bairro' from evento e inner join bairro b on m.Fk_Idevento = b.idBairro;
-- 3. Liste todos os moradores e, caso tenham evento organizado, mostrar o título.
-- 4. Liste todos os bairros mesmo que não tenham eventos. (Left join invertido)
-- 5. Exiba todos os eventos e mostre o nome da organização (se houver).
-- 6. Mostre: bairro, quantidade de moradores por bairro.


ALTER TABLE morador RENAME COLUMN idBairro TO Fk_Idbairro;


desc evento;

