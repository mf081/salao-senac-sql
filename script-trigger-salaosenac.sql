-- 1. Trigger para Atualizar Estoque Após Adicionar Serviço Agendado
DELIMITER $$
CREATE TRIGGER trg_atualizar_estoque_servico
AFTER INSERT ON servico_agendamento
FOR EACH ROW
BEGIN
    UPDATE servico
    SET estoque = estoque - 1
    WHERE id_servico = NEW.servico_id_servico;
END$$
DELIMITER ;

-- 2. Trigger para Evitar Agendamento com Funcionário Indisponível
DELIMITER $$
CREATE TRIGGER trg_verificar_disponibilidade_funcionario
BEFORE INSERT ON agendamento
FOR EACH ROW
BEGIN
    DECLARE ocupado INT;
    
    SELECT COUNT(*)
    INTO ocupado
    FROM agendamento
    WHERE funcionario_id_funcionario = NEW.funcionario_id_funcionario
      AND data = NEW.data
      AND hora = NEW.hora;
    
    IF ocupado > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Funcionário já tem um agendamento nesse horário!';
    END IF;
END$$
DELIMITER ;

-- 3. Trigger para Garantir que o Estoque do Serviço Não Fique Negativo
DELIMITER $$
CREATE TRIGGER trg_prevenir_estoque_negativo
BEFORE INSERT ON servico_agendamento
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    
    SELECT estoque
    INTO estoque_atual
    FROM servico
    WHERE id_servico = NEW.servico_id_servico;
    
    IF estoque_atual < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente para o serviço selecionado!';
    END IF;
END$$
DELIMITER ;

-- 4. Trigger para Registrar Histórico de Clientes Excluídos
DELIMITER $$
CREATE TRIGGER trg_registrar_historico_cliente
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO historico_cliente (id_cliente, nome_completo, email, data_exclusao)
    VALUES (OLD.id_cliente, OLD.nome_completo, OLD.email, NOW());
END$$
DELIMITER ;

-- 5. Trigger para Atualizar o Preço Total do Agendamento Quando Serviços São Adicionados
DELIMITER $$
CREATE TRIGGER trg_atualizar_preco_total
AFTER INSERT ON servico_agendamento
FOR EACH ROW
BEGIN
    DECLARE preco_total DECIMAL(10, 2);
    
    SELECT SUM(s.preco)
    INTO preco_total
    FROM servico_agendamento sa
    JOIN servico s ON sa.servico_id_servico = s.id_servico
    WHERE sa.agendamento_id_agendamento = NEW.agendamento_id_agendamento;
    
    UPDATE agendamento
    SET preco_total = preco_total
    WHERE id_agendamento = NEW.agendamento_id_agendamento;
END$$
DELIMITER ;

-- 6. Trigger para Garantir que Apenas Agendamentos Confirmados Possam Ter Pagamento Registrado
DELIMITER $$
CREATE TRIGGER trg_verificar_status_pagamento
BEFORE INSERT ON pagamento
FOR EACH ROW
BEGIN
    DECLARE status_agendamento VARCHAR(20);
    
    SELECT status
    INTO status_agendamento
    FROM agendamento
    WHERE id_agendamento = NEW.agendamento_id_agendamento;
    
    IF status_agendamento != 'Confirmado' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O pagamento só pode ser registrado para agendamentos confirmados!';
    END IF;
END$$
DELIMITER ;

-- Exemplos de Teste das Triggers

-- 1. Inserir um serviço agendado e verificar o estoque
INSERT INTO servico_agendamento (agendamento_id_agendamento, servico_id_servico, preco_total)
VALUES (1, 1, 100.00);

-- 2. Tentar agendar dois serviços no mesmo horário para o mesmo funcionário
INSERT INTO agendamento (cliente_id_cliente, funcionario_id_funcionario, data, hora, status, forma_pag_id_pagamento)
VALUES (1, 1, '2024-12-10', '14:00:00', 'Pendente', 1);

-- 3. Tentar adicionar um serviço com estoque insuficiente
INSERT INTO servico_agendamento (agendamento_id_agendamento, servico_id_servico, preco_total)
VALUES (2, 1, 100.00);

-- 4. Deletar um cliente e verificar o registro no histórico
DELETE FROM cliente WHERE id_cliente = 1;

-- 5. Adicionar um serviço a um agendamento e verificar o preço total atualizado
INSERT INTO servico_agendamento (agendamento_id_agendamento, servico_id_servico, preco_total)
VALUES (1, 2, 150.00);

-- 6. Tentar registrar pagamento para um agendamento não confirmado
INSERT INTO pagamento (agendamento_id_agendamento, valor, data_pagamento)
VALUES (2, 200.00, NOW());