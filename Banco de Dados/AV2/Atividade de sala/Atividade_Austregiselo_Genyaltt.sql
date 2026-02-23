
/* ******************************************************************
   APENAS PARA ALUNOS PRESENTES NO LABORATÓRIO!
   ******************************************************************
   
   UNINASSAU - Curso de Análise e Desenvolvimento de Sistemas
   Disciplina: Banco de Dados
   Prof.ª M.ª Mariana Meirelles de Mello
   Data: 02/12/2025
   Discentes: Austregíselo Junior - 03249515
			  Genyaltt Junior - 03360574

   ******************************************************************

   INSTRUÇÕES:

   - Utilize a base 'sistema_comunitario' já criada em aula.
   - NÃO crie ou altere tabelas.
   - Resolva os itens usando apenas:
        SELECT, WHERE, ORDER BY, JOIN, funções de agregação,
        GROUP BY, HAVING e DELETE.
   - Entregue apenas os COMANDOS SQL de cada questão.
   - Cuide da identação e da escrita (boas práticas contam ponto!).
*/

/* 1) Eventos com data formatada

   Mostre todos os eventos, exibindo:
     - título do evento,
     - data no formato brasileiro (dd/mm/aaaa) com o alias 'Data do Evento',

   Ordene os resultados do evento MAIS recente para o MAIS antigo.
*/
select titulo,  date_format(dt_data, '%d/%m/%Y') as 'Data do Evento'
from evento
Order By dt_data DESC;

/* 2) Moradores de um bairro espec 

   Liste o NOME e o TELEFONE dos moradores que moram no bairro
   'Mangabeira'.

   Observações:
   - Use as tabelas 'morador' e 'bairro'.
   - O comando deve funcionar mesmo que você não saiba o código (id)
     do bairro Mangabeira.
*/
Select m.nome, m.telefone from morador m Inner Join bairro b on b.idBairro = m.Fk_Idbairro where b.nome = 'Mangabeira';

/* 3) Bairros mais populosos

   Mostre o NOME dos bairros e sua POPULAÇÃO, apenas para os bairros com
   população maior que 10.000 habitantes.

   Ordene os resultados da MAIOR para a MENOR população.
*/
select m.nome, b.nome, b.populacao 
from morador m
	inner Join bairro b 
    on m.Fk_Idbairro = b.idBairro 
    where b.populacao > 10000
Order by b.populacao desc;

/* 4) Quantidade de moradores por bairro

   Mostre, para cada bairro:
     - o NOME do bairro;
     - a quantidade de moradores, com o alias 'QtdMoradores'.

   Ordene pelo nome do bairro, em ordem alfabética.
*/
Select  count(*) as 'QtdMoradores', b.nome from morador m 
inner join bairro b on m.Fk_Idbairro = b.idBairro
group by b.nome
order by b.nome;

/* 5) Bairros com muitos moradores

   Mostre apenas os bairros que possuem MAIS DE 2 moradores, exibindo:
     - o NOME do bairro;
     - a quantidade de moradores (alias 'QtdMoradores').

   Use GROUP BY e HAVING para filtrar os grupos.
*/
Select  count(*) as 'QtdMoradores', b.nome from morador m 
inner join bairro b on m.Fk_Idbairro = b.idBairro
group by b.nome
Having count(*) > 2
order by b.nome;

/* 6) Exclusão de eventos de um período

   Escreva o comando SQL que apagaria TODOS os eventos realizados
   no ano de 2024.

   Observação:
   - Use a coluna 'data' da tabela 'evento'.
   - Não é para executar, apenas escrever o comando DELETE.
*/
delete from evento where date_format(dt_data, '%d/%m/%Y') like '%/%/2024';


/* ******************************************************************
   FIM DA ATIVIDADE – ENTREGAR APENAS OS COMANDOS SQL
   ****************************************************************** */
