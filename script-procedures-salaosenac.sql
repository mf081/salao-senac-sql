
-- 1 Cadastrar cliente
delimiter $$

create procedure cadCliente(in pnome varchar(50),
                             in pemail varchar(45),
                             in pcpf varchar(14),
                             in pnomeSocial varchar(50),
                             in pdataNasc date,
                             in ptelefone varchar(15))
begin
    -- Primeiro, cadastramos o telefone na tabela telefone_cliente
    insert into telefone_cliente (telefone)
    values (ptelefone);
    
    -- Pegamos o id do telefone recém inserido
    set @telefoneId = last_insert_id();

    -- Agora cadastramos o cliente, associando o id do telefone
    insert into cliente (nome_completo, email, cpf, `nome social`, data_nasc, telefone_cliente_idtelefone_cliente)
    values (pnome, pemail, pcpf, pnomeSocial, pdataNasc, @telefoneId);
end $$ 

-- 2 cadastrar telefone do cliente
 delimiter $$

create procedure cadTelefoneCliente(in ptelefone varchar(15))
begin
    insert into telefone_cliente (telefone)
    values (ptelefone);
end $$ 

-- 3 Cadastrar serviço

delimiter $$

create procedure cadServico(in pduracao time,
                             in pcategoria varchar(75),
                             in ppreco decimal(10,2))
begin
    insert into servico (duracao, categoria, preco)
    values (pduracao, pcategoria, ppreco);
end $$ 

-- 4 cadastrar agendamento

delimiter $$

create procedure cadAgendamento(in pdata date,
                                 in pstatus varchar(20),
                                 in phora time,
                                 in pdataCriacao datetime,
                                 in pcomentarios text,
                                 in pformaPagId int,
                                 in pfuncionarioId int,
                                 in pclienteId int)
begin
    insert into agendamento (data, status, hora, data_criacao, comentarios, forma_pag_id_pagamento, funcionario_id_funcionario, cliente_id_cliente)
    values (pdata, pstatus, phora, pdataCriacao, pcomentarios, pformaPagId, pfuncionarioId, pclienteId);
end $$ 


-- 5 Cadastrar forma de pagamento 

delimiter $$

create procedure cadFormaPagamento(in ptipoPag varchar(45),
                                    in pdataPag date,
                                    in pvalorPago decimal(10,2),
                                    in pstatus varchar(30))
begin
    insert into forma_pag (tipo_pag, data_pag, valor_pago, status)
    values (ptipoPag, pdataPag, pvalorPago, pstatus);
end $$ 


-- 6 Cadastrar funcionario
delimiter $$

create procedure cadFuncionario(in pcpf varchar(14),
                                 in pnome varchar(80),
                                 in pfuncao varchar(30),
                                 in pinicioExpediente time,
                                 in pfimExpediente time,
                                 in ptelefoneFuncionarioId int)
begin
    insert into funcionario (cpf, nome_completo, funcao, inicio_expediente, fim_expediente, telefone_funcionario_idtelefone_funcionario)
    values (pcpf, pnome, pfuncao, pinicioExpediente, pfimExpediente, ptelefoneFuncionarioId);
end $$ 

-- 7 cadastrar telefone funcionario

delimiter $$

create procedure cadTelefoneFuncionario(in ptelefone varchar(15))
begin
    insert into telefone_funcionario (telefone)
    values (ptelefone);
end $$ 

-- 8 Cadastrar serviço de agendamento

delimiter $$

create procedure cadServicoAgendamento(in pprecoTotal decimal(10,2),
                                       in pquantidade int,
                                       in pservicoId int,
                                       in pagendamentoId int)
begin
    insert into servico_agendamento (preco_total, quantidade, servico_id_servico, agendamento_id_agendamento)
    values (pprecoTotal, pquantidade, pservicoId, pagendamentoId);
end $$ 


-- 9  Atualizar status de agendamento

delimiter $$

create procedure atualizaStatusAgendamento(in pagendamentoId int,
                                           in pstatus varchar(20))
begin
    update agendamento
    set status = pstatus
    where id_agendamento = pagendamentoId;
end $$ 


-- 10 Buscar cliente por CPF

delimiter $$

create procedure buscaClientePorCpf(in pcpf varchar(14))
begin
    select * from cliente
    where cpf = pcpf;
end $$ 



