-- Data: Atividade pontuáda 02/12/2025

   /* 1) Eventos com data formatada
26   
27      Mostre todos os eventos, exibindo:
28        - título do evento,
29        - data no formato brasileiro (dd/mm/aaaa) com o alias 'Data do Evento',
30   
31      Ordene os resultados do evento MAIS recente para o MAIS antigo.
   */
use sistema_comunitario;

select titulo as 'titulo do evento', date_format(data, '%d/%m/%y') as 'Data do Evento'
from evento
order by (data) desc;

  
   /* 2) Moradores de um bairro específico
39   
40      Liste o NOME e o TELEFONE dos moradores que moram no bairro
41      'Mangabeira'.
42   
43      Observações:
44      - Use as tabelas 'morador' e 'bairro'.
45      - O comando deve funcionar mesmo que você não saiba o código (id)
46        do bairro Mangabeira.
   */
   
   select m.nome, m.telefone 
   from morador m
	Inner join bairro b
	On b.idBairro = m.Fk_Idbairro
    where b.nome = 'Mangabeira';
    
       
   /* 3) Bairros mais populosos
56   
57      Mostre o NOME dos bairros e sua POPULAÇÃO, apenas para os bairros com
58      população maior que 10.000 habitantes.
59   
60      Ordene os resultados da MAIOR para a MENOR população.
   */
   
   select nome, populacao
   from bairro
   where populacao > 10000
   order by populacao desc;
   
   /* 4) Quantidade de moradores por bairro
69   
70      Mostre, para cada bairro:
71        - o NOME do bairro;
72        - a quantidade de moradores, com o alias 'QtdMoradores'.
73   
74      Ordene pelo nome do bairro, em ordem alfabética.
   */
   
   select b.nome 'bairro', count(m.idMorador) 'Qtd morador'
   from bairro b
	left join morador m
    on b.idBairro = m.Fk_Idbairro
   group by(b.nome)
   order by(b.nome);
   
    
   /* 5) Bairros com muitos moradores 
85   
86      Mostre apenas os bairros que possuem MAIS DE 2 moradores, exibindo:
87        - o NOME do bairro;
88        - a quantidade de moradores (alias 'QtdMoradores').
89   
90      Use GROUP BY e HAVING para filtrar os grupos.
   */
   
select b.nome 'Bairro', b.populacao 'QtdMoradores'
from bairro b
where b.populacao > 5000;

   /* 6) Exclusão de eventos de um período
101   
102      Escreva o comando SQL que apagaria TODOS os eventos realizados
103      no ano de 2024.
104   
105      Observação:
106      - Use a coluna 'data' da tabela 'evento'.
107      - Não é para executar, apenas escrever o comando DELETE.
   */
   
   select * from evento;
   
   delete from evento where year(data) = 2024;
	
   
   
   

  
