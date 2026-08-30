-- Usuário e Controle de Acesso.

-- Criando usuário 
create user 'cliente'@'localhost'
identified by 'senha123';
-- No lugar de localhost pode ser %, 192.168.0.% onde
-- localhost -> Apenas localmente
-- % -> Qualquer máquina
-- 192.168.0.% -> Rede específica

CREATE USER 'admin'@'%' IDENTIFIED BY '123'; -- Exemplo de código perigoso, porque permite acesso qa qualquer lugar

-- Dando permissão de usuário
-- Depois de criar devemos dar permissão porqque sem isso ele não faz nada
Grant select on gestao_eventos.* -- no lugar do select pode ser insert, update, delete e ALL PRIVILEGES
to 'cliente'@'localhost'; -- no lugar do localhost pode ser *.*, banco, banco.tabela
-- *.* -> servidor
-- banco -> acesso ao banco
-- banco.tabela -> acesso a tabela

-- Importante: Se um privilégio é concedidoem nível alto não é posível negar em nível mais baixo
REVOKE SELECT on gestao_eventos.bairro
from 'cliente'@'localhost'; -- iSSO NÃO FUNCIONA PORQUE UMA PERMISSÃO MAIOR JÁ FOI DADA, O CORRETO É DAR APENAS PERMISSÕES ESPECÍFICAS

SELECT USER(), -- usuário conectado
CURRENT_USER();-- usuário autenticado pelo MySQL

-- Revogando Permissão (Revoke)
Revoke select on gestao_eventos.* from 'cliente'@'localhost'; -- Revogação do select

-- Menor Privilégio (Least Privilege): Devemos remove permissões amplas e concede permissões específicas

-- Excluir Usuário
DROP USER 'user_bd'@'localhost';

-- Esxemplos:
-- Criar usuário
CREATE USER 'funcionario'@'localhost'
IDENTIFIED BY '123';

-- Permitir apenas leitura
GRANT SELECT ON empresa.*
TO 'funcionario'@'localhost';

-- Permitir inserir somente em pedidos
GRANT INSERT ON empresa.pedidos
TO 'funcionario'@'localhost';

-- Remover INSERT
REVOKE INSERT ON empresa.pedidos
FROM 'funcionario'@'localhost';



