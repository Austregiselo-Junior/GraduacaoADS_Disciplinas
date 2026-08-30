Create User 'Cliente'@'localhost' identified by '123';
-- 'Cliente' nome do cliente
-- 'localhost' Acesso 
-- '123'; senha

SELECT USER(); -- saber o usuário conectado

SELECT user, host
FROM mysql.user; -- Saber os usuários ligado ao host

-- Dando acesso ao usuário
-- Dar permissão -> Grant
-- retira permissão -> Revoke

Grant select on gestao_eventos.*
to 'Cliente'@'localhost'; -- Permite apenas a consulta de dados na tabela

GRANT ALL PRIVILEGES ON *.*
TO 'admin'@'localhost'; -- Permissão a todo servidor


GRANT ALL PRIVILEGES ON gestao_eventos.*
TO 'admin'@'localhost'; -- Permissão ao banco todo

GRANT ALL PRIVILEGES ON gestao_eventos.bairro
TO 'admin'@'localhost'; -- Permissão a tabela bairro

-- Se um usuário tem permissão alta, não é possível negar alguma mais baixa, como acesso a uma tabela

Grant insert on gestao_eventos.bairro
to 'Cliente'@'localhost'; -- Usuário cliente pode fazer select e insert na tabela bairro

Revoke insert on gestao_eventos.bairro from 'Cliente'@'localhost'; -- Usuário não pode mais fazer insert na tabela

REVOKE ALL PRIVILEGES ON gestao_eventos.* 
FROM 'Cliente'@'localhost'; -- Remove todas as permissões

DROP USER 'Cliente'@'localhost'; -- Remover completamente o usuário

-- OBS:Least Privilege -> O Usuário deve ter apenas acesso ao necessário

-- Hierarquia 
-- servidor *.* 
-- banco database.*
-- tabela database.tabela