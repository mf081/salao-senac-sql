-- 1. Relatório de Todos os Clientes com Seus Telefones
CREATE VIEW vw_clientes_telefones AS
SELECT c.nome_completo, c.email, t.telefone
FROM cliente c
JOIN telefone_cliente t ON c.telefone_cliente_idtelefone_cliente = t.idtelefone_cliente;

-- 2. Relatório de Agendamentos Confirmados
CREATE VIEW vw_agendamentos_confirmados AS
SELECT a.id_agendamento, a.data, a.hora, c.nome_completo
FROM agendamento a
JOIN cliente c ON a.cliente_id_cliente = c.id_cliente
WHERE a.status = 'Confirmado';

-- 3. Relatório de Agendamentos Pendentes por Cliente
CREATE VIEW vw_agendamentos_pendentes_cliente AS
SELECT c.nome_completo, a.data, a.status
FROM cliente c
JOIN agendamento a ON c.id_cliente = a.cliente_id_cliente
WHERE a.status = 'Pendente';

-- 4. Relatório de Todos os Funcionários com Seus Agendamentos
CREATE VIEW vw_funcionarios_agendamentos AS
SELECT f.nome_completo, f.cpf, a.id_agendamento, a.data, a.hora
FROM funcionario f
JOIN agendamento a ON f.id_funcionario = a.funcionario_id_funcionario;

-- 5. Relatório de Serviços e Seus Preços
CREATE VIEW vw_servicos_precos AS
SELECT s.categoria, s.preco, s.duracao
FROM servico s;

-- 6. Relatório de Agendamentos com Seus Serviços e Preços
CREATE VIEW vw_agendamentos_servicos_precos AS
SELECT a.id_agendamento, a.data, s.categoria, sa.preco_total
FROM agendamento a
JOIN servico_agendamento sa ON a.id_agendamento = sa.agendamento_id_agendamento
JOIN servico s ON sa.servico_id_servico = s.id_servico;

-- 7. Relatório de Total de Serviços por Agendamento
CREATE VIEW vw_total_servicos_agendamentos AS
SELECT a.id_agendamento, SUM(sa.preco_total) AS total_servicos
FROM agendamento a
JOIN servico_agendamento sa ON a.id_agendamento = sa.agendamento_id_agendamento
GROUP BY a.id_agendamento;

-- 8. Relatório de Funcionários com Mais Agendamentos
CREATE VIEW vw_funcionarios_com_mais_agendamentos AS
SELECT f.nome_completo, COUNT(a.id_agendamento) AS num_agendamentos
FROM funcionario f
JOIN agendamento a ON f.id_funcionario = a.funcionario_id_funcionario
GROUP BY f.id_funcionario
ORDER BY num_agendamentos DESC;

-- 9. Relatório de Clientes com Múltiplos Agendamentos Confirmados
CREATE VIEW vw_clientes_com_multiplo_agendamento AS
SELECT c.nome_completo, COUNT(a.id_agendamento) AS num_agendamentos
FROM cliente c
JOIN agendamento a ON c.id_cliente = a.cliente_id_cliente
WHERE a.status = 'Confirmado'
GROUP BY c.id_cliente
HAVING COUNT(a.id_agendamento) > 1;

-- 10. Relatório de Forma de Pagamento em Agendamentos Pendentes
CREATE VIEW vw_agendamentos_pendentes_pagamento AS
SELECT a.id_agendamento, a.data, f.tipo_pag
FROM agendamento a
JOIN forma_pag f ON a.forma_pag_id_pagamento = f.id_pagamento
WHERE a.status = 'Pendente';