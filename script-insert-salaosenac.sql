-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`telefone_cliente`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`telefone_cliente` (`idtelefone_cliente`, `telefone`) VALUES
(1, '1234567890'),
(2, '2345678901'),
(3, '3456789012'),
(4, '4567890123'),
(5, '5678901234'),
(6, '6789012345'),
(7, '7890123456'),
(8, '8901234567'),
(9, '9012345678'),
(10, '0123456789');

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`cliente`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`cliente` (`id_cliente`, `nome_completo`, `email`, `cpf`, `nome social`, `data_nasc`, `telefone_cliente_idtelefone_cliente`) VALUES
(1, 'João Silva', 'joao.silva@gmail.com', '12345678901', 'João', '1990-05-10', 1),
(2, 'Maria Oliveira', 'maria.oliveira@yahoo.com', '23456789012', 'Maria', '1985-08-20', 2),
(3, 'Carlos Pereira', 'carlos.pereira@hotmail.com', '34567890123', 'Carlos', '1980-12-25', 3),
(4, 'Ana Souza', 'ana.souza@outlook.com', '45678901234', 'Ana', '1992-01-15', 4),
(5, 'Felipe Almeida', 'felipe.almeida@uol.com.br', '56789012345', 'Felipe', '1988-03-30', 5),
(6, 'Patrícia Costa', 'patricia.costa@globo.com', '67890123456', 'Patrícia', '1995-07-18', 6),
(7, 'Rafael Lima', 'rafael.lima@terra.com.br', '78901234567', 'Rafael', '1982-11-05', 7),
(8, 'Juliana Martins', 'juliana.martins@gmail.com', '89012345678', 'Juliana', '1993-06-22', 8),
(9, 'Felipe Santos', 'felipe.santos@yahoo.com', '90123456789', 'Felipe', '1986-02-13', 9),
(10, 'Fernanda Ribeiro', 'fernanda.ribeiro@hotmail.com', '01234567890', 'Fernanda', '1990-09-10', 10);

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`forma_pag`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`forma_pag` (`id_pagamento`, `tipo_pag`, `data_pag`, `valor_pago`, `status`) VALUES
(1, 'Cartão de Crédito', '2024-12-01', 150.50, 'Pago'),
(2, 'Dinheiro', '2024-12-02', 200.75, 'Pago'),
(3, 'Transferência Bancária', '2024-12-03', 300.00, 'Pendente'),
(4, 'Boleto', '2024-12-04', 500.00, 'Pago'),
(5, 'Pix', '2024-12-05', 450.20, 'Pendente'),
(6, 'Cartão de Crédito', '2024-12-06', 350.00, 'Pago'),
(7, 'Dinheiro', '2024-12-07', 120.30, 'Pendente'),
(8, 'Transferência Bancária', '2024-12-08', 250.00, 'Pago'),
(9, 'Boleto', '2024-12-09', 180.60, 'Pendente'),
(10, 'Pix', '2024-12-10', 410.80, 'Pago');

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`telefone_funcionario`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`telefone_funcionario` (`idtelefone_funcionario`, `telefone`) VALUES
(1, '9876543210'),
(2, '8765432109'),
(3, '7654321098'),
(4, '6543210987'),
(5, '5432109876'),
(6, '4321098765'),
(7, '3210987654'),
(8, '2109876543'),
(9, '1098765432'),
(10, '0987654321');

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`funcionario`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`funcionario` (`id_funcionario`, `inicio_expediente`, `fim_expediente`, `nome_completo`, `cpf`, `funcao`, `telefone_funcionario_idtelefone_funcionario`) VALUES
(1, '08:00:00', '17:00:00', 'Pedro Almeida', '12345678901', 'Recepcionista', 1),
(2, '08:30:00', '17:30:00', 'Fernanda Souza', '23456789012', 'Atendente', 2),
(3, '09:00:00', '18:00:00', 'Ricardo Oliveira', '34567890123', 'Coordenador', 3),
(4, '08:00:00', '17:00:00', 'Ana Martins', '45678901234', 'Recepcionista', 4),
(5, '09:00:00', '18:00:00', 'Gustavo Costa', '56789012345', 'Atendente', 5),
(6, '08:30:00', '17:30:00', 'Juliana Silva', '67890123456', 'Coordenador', 6),
(7, '08:00:00', '17:00:00', 'Roberto Pereira', '78901234567', 'Recepcionista', 7),
(8, '09:00:00', '18:00:00', 'Carla Oliveira', '89012345678', 'Atendente', 8),
(9, '08:30:00', '17:30:00', 'Lucas Almeida', '90123456789', 'Coordenador', 9),
(10, '09:00:00', '18:00:00', 'Tatiane Lima', '01234567890', 'Recepcionista', 10);

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`agendamento`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`agendamento` (`id_agendamento`, `data`, `status`, `hora`, `data_criacao`, `comentarios`, `forma_pag_id_pagamento`, `funcionario_id_funcionario`, `cliente_id_cliente`) VALUES
(1, '2024-12-01', 'Confirmado', '10:00:00', '2024-12-01 09:00:00', 'Nenhum', 1, 1, 1),
(2, '2024-12-02', 'Pendente', '14:00:00', '2024-12-02 13:00:00', 'Urgente', 2, 2, 2),
(3, '2024-12-03', 'Confirmado', '09:30:00', '2024-12-03 08:30:00', 'Nenhum', 3, 3, 3),
(4, '2024-12-04', 'Cancelado', '11:00:00', '2024-12-04 10:30:00', 'Cliente não apareceu', 4, 4, 4),
(5, '2024-12-05', 'Pendente', '15:30:00', '2024-12-05 15:00:00', 'Alguns ajustes', 5, 5, 5),
(6, '2024-12-06', 'Confirmado', '10:30:00', '2024-12-06 10:00:00', 'Nenhum', 6, 6, 6),
(7, '2024-12-07', 'Pendente', '13:00:00', '2024-12-07 12:30:00', 'Necessário mais tempo', 7, 7, 7),
(8, '2024-12-08', 'Confirmado', '16:00:00', '2024-12-08 15:30:00', 'Nenhum', 8, 8, 8),
(9, '2024-12-09', 'Confirmado', '09:00:00', '2024-12-09 08:30:00', 'Nenhum', 9, 9, 9),
(10, '2024-12-10', 'Pendente', '12:00:00', '2024-12-10 11:30:00', 'Cliente não pagou', 10, 10, 10);

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`servico`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`servico` (`id_servico`, `duracao`, `categoria`, `preco`) VALUES
(1, '01:00:00', 'Fotografia', 150.00),
(2, '01:30:00', 'Decoração', 300.00),
(3, '02:00:00', 'Som', 200.00),
(4, '01:00:00', 'Iluminação', 120.00),
(5, '01:30:00', 'Teatro', 250.00),
(6, '02:00:00', 'Brinquedos', 180.00),
(7, '01:30:00', 'Catering', 350.00),
(8, '01:00:00', 'DJ', 220.00),
(9, '02:00:00', 'Mágico', 200.00),
(10, '01:00:00', 'Palestra', 100.00);

-- -----------------------------------------------------
-- Inserts para a tabela `salaosenac`.`servico_agendamento`
-- -----------------------------------------------------
INSERT INTO `salaosenac`.`servico_agendamento` (`idservico_agendamento`, `preco_total`, `quantidade`, `servico_id_servico`, `agendamento_id_agendamento`) VALUES
(1, 150.00, 1, 1, 1),
(2, 300.00, 1, 2, 2),
(3, 200.00, 1, 3, 3),
(4, 120.00, 1, 4, 4),
(5, 250.00, 1, 5, 5),
(6, 180.00, 1, 6, 6),
(7, 350.00, 1, 7, 7),
(8, 220.00, 1, 8, 8),
(9, 200.00, 1, 9, 9),
(10, 100.00, 1, 10, 10);
