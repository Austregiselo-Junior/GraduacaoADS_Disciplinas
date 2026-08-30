/*
Projeto de Banco de Dados
Prof.ª M.ª Mariana Meirelles de Mello Oliveira
Semestre: 2026.1
Data: 28/04/2026

Aula 06: Controle de Acesso e Transações
*/

/*
Criar usuário
Conceder permissões
Testar limitações
Revogar permissões
Introduzir transações
Controle com COMMIT/ROLLBACK
*/

/*
Controle de Acesso:
	O banco diz qual usuário pode acessar e o que pode fazer
    - Segurança de dados
    - Evitar alterações indevidas
    - Separação de papéis (responsabilidades)
*/

/* Criar um novo usuário
Sintaxe:
CREATE USER 'usuario'@'localhost' 
IDENTIFIED BY 'senha';

usuario_teste - nome do usuário
localhost - de onde pode acessar
IDENTIFIED BY - senha
*/

-- Criar usuário
CREATE USER 'user_bd'@'localhost'
IDENTIFIED BY '123456';

-- Criar uma nova conexão para o usuário na página inicial do workbench

/*
Conceder permissões:

Sintaxe:
GRANT permissao ON banco.tabela TO 'usuario'@'host';

ATENÇÃO!
O MySQL trabalha com hierarquia de privilégios:

	*.* → tudo no servidor
	database.* → tudo no banco
	database.tabela → específico

OBS.: Se um privilégio é concedido em nível mais alto, 
você não consegue negar em nível mais baixo.

*/

-- Conceder permissão para SELECT em tudo de gestao_evento
GRANT SELECT ON gestao_eventos.*
TO 'user_bd'@'localhost';

/*
Pode consultar
NÃO pode inserir, atualizar ou deletar
*/

-- Validar o usuário que está conectado:
SELECT USER(), CURRENT_USER();

-- Permitir INSERT apenas na tabela, bairro
GRANT INSERT ON gestao_eventos.bairro
TO 'user_bd'@'localhost';

/*
Revogando Permissões
Sintaxe:

REVOKE permissao ON banco.tabela FROM 'usuario'@'host';

REVOKE ALL PRIVILEGES ON banco.tabela FROM 'usuario'@'host';
*/

-- Revogar a permissão do INSERT
REVOKE INSERT ON gestao_eventos.bairro
FROM 'user_bd'@'localhost';

REVOKE SELECT ON gestao_eventos.vw_eventos
FROM 'user_bd'@'localhost';
/* Não consegue revogar a permissão para a view, pois a permissão fornecida tem um privilégio maior.
Precisa revogar toda a permissão, para depois dar permissão apenas as tabelas. */

REVOKE SELECT ON gestao_eventos.*
FROM 'user_bd'@'localhost';

-- Permissão apenas das tabelas
GRANT SELECT ON gestao_eventos.evento
TO 'user_bd'@'localhost';

GRANT SELECT ON gestao_eventos.bairro
TO 'user_bd'@'localhost';

GRANT SELECT ON gestao_eventos.inscricao
TO 'user_bd'@'localhost';

GRANT SELECT ON gestao_eventos.morador
TO 'user_bd'@'localhost';

GRANT SELECT ON gestao_eventos.organizacao
TO 'user_bd'@'localhost';

/*
Excluir Usuário

DROP USER 'usuario'@'host';
*/

-- Não precisa deletar o usuário 

