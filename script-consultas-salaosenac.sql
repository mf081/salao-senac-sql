-- 1. Consulta de Todos os Clientes com Seus Telefones
SELECT c.nome_completo, c.email, t.telefone
FROM cliente c
JOIN telefone_cliente t ON c.telefone_cliente_idtelefone_cliente = t.idtelefone_cliente;

-- 2. Consulta de Todos os Funcionários com Seus Telefones
SELECT f.nome_completo, f.cpf, tf.telefone
FROM funcionario f
JOIN telefone_funcionario tf ON f.telefone_funcionario_idtelefone_funcionario = tf.idtelefone_funcionario;

-- 3. Consulta de Agendamentos Confirmados por Cliente
SELECT a.id_agendamento, a.data, a.hora, c.nome_completo
FROM agendamento a
JOIN cliente c ON a.cliente_id_cliente = c.id_cliente
WHERE a.status = 'Confirmado';

-- 4. Consulta de Clientes com Agendamentos Pendentes
SELECT c.nome_completo, a.data, a.status
FROM cliente c
JOIN agendamento a ON c.id_cliente = a.cliente_id_cliente
WHERE a.status = 'Pendente';

-- 5. Consulta de Todos os Agendamentos de um Funcionario Específico
SELECT a.id_agendamento, a.data, a.hora, a.status
FROM agendamento a
JOIN funcionario f ON a.funcionario_id_funcionario = f.id_funcionario
WHERE f.nome_completo = 'Pedro Almeida';

-- 6. Consulta de Todos os Serviços de um Agendamento
SELECT s.categoria, sa.preco_total, sa.quantidade
FROM servico_agendamento sa
JOIN servico s ON sa.servico_id_servico = s.id_servico
WHERE sa.agendamento_id_agendamento = 1;

-- 7. Consulta de Serviços e Seus Preços
SELECT s.categoria, s.preco, s.duracao
FROM servico s;

-- 8. Consulta de Agendamentos com Forma de Pagamento
SELECT a.id_agendamento, a.data, a.hora, f.tipo_pag
FROM agendamento a
JOIN forma_pag f ON a.forma_pag_id_pagamento = f.id_pagamento;

-- 9. Consulta de Total de Serviços por Agendamento
SELECT a.id_agendamento, SUM(sa.preco_total) AS total_servicos
FROM servico_agendamento sa
JOIN agendamento a ON sa.agendamento_id_agendamento = a.id_agendamento
GROUP BY a.id_agendamento;

-- 10. Consulta de Agendamentos Confirmados e Seus Serviços
SELECT a.id_agendamento, a.data, s.categoria
FROM agendamento a
JOIN servico_agendamento sa ON a.id_agendamento = sa.agendamento_id_agendamento
JOIN servico s ON sa.servico_id_servico = s.id_servico
WHERE a.status = 'Confirmado';

-- 11. Consulta de Funcionários com Maior Número de Agendamentos
SELECT f.nome_completo, COUNT(a.id_agendamento) AS num_agendamentos
FROM funcionario f
JOIN agendamento a ON f.id_funcionario = a.funcionario_id_funcionario
GROUP BY f.id_funcionario
ORDER BY num_agendamentos DESC;

-- 12. Consulta de Clientes com Mais de um Agendamento Confirmado
SELECT c.nome_completo, COUNT(a.id_agendamento) AS num_agendamentos
FROM cliente c
JOIN agendamento a ON c.id_cliente = a.cliente_id_cliente
WHERE a.status = 'Confirmado'
GROUP BY c.id_cliente
HAVING COUNT(a.id_agendamento) > 1;

-- 13. Consulta de Todos os Funcionários e Seus Horários de Expedição
SELECT f.nome_completo, f.inicio_expediente, f.fim_expediente
FROM funcionario f;

-- 14. Consulta de Forma de Pagamento com Status Pendente
SELECT a.id_agendamento, f.tipo_pag
FROM agendamento a
JOIN forma_pag f ON a.forma_pag_id_pagamento = f.id_pagamento
WHERE a.status = 'Pendente';

-- 15. Consulta de Serviços que Custam Acima de um Preço Específico
SELECT categoria, preco
FROM servico
WHERE preco > 200.00;

-- 16. Consulta de Agendamentos por Cliente e Forma de Pagamento
SELECT c.nome_completo, a.id_agendamento, f.tipo_pag
FROM agendamento a
JOIN cliente c ON a.cliente_id_cliente = c.id_cliente
JOIN forma_pag f ON a.forma_pag_id_pagamento = f.id_pagamento;

-- 17. Consulta de Agendamentos com Preço Total Superior a um Valor
SELECT a.id_agendamento, SUM(sa.preco_total) AS total_preco
FROM agendamento a
JOIN servico_agendamento sa ON a.id_agendamento = sa.agendamento_id_agendamento
GROUP BY a.id_agendamento
HAVING total_preco > 300;

-- 18. Consulta de Agendamentos com Serviços e Seus Preços
SELECT a.id_agendamento, s.categoria, sa.preco_total
FROM agendamento a
JOIN servico_agendamento sa ON a.id_agendamento = sa.agendamento_id_agendamento
JOIN servico s ON sa.servico_id_servico = s.id_servico;

-- 19. Consulta de Funcionario com Agendamentos por Data
SELECT f.nome_completo, a.id_agendamento, a.data
FROM agendamento a
JOIN funcionario f ON a.funcionario_id_funcionario = f.id_funcionario
WHERE a.data = '2024-12-01';

-- 20. Consulta de Todos os Clientes e Seus Agendamentos com Status
SELECT c.nome_completo, a.data, a.status
FROM cliente c
JOIN agendamento a ON c.id_cliente = a.cliente_id_cliente;