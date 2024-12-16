-- -----------------------------------------------------
-- Schema salaosenac
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salaosenac` DEFAULT CHARACTER SET utf8 ;
USE `salaosenac` ;

-- -----------------------------------------------------
-- Table `salaosenac`.`telefone_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telefone_cliente` (
  `idtelefone_cliente` INT NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idtelefone_cliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL,
  `nome_completo` VARCHAR(50) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `nome social` VARCHAR(50) NULL,
  `data_nasc` DATE NOT NULL,
  `telefone_cliente_idtelefone_cliente` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_cliente_telefone_cliente1_idx` (`telefone_cliente_idtelefone_cliente` ASC),
  CONSTRAINT `fk_cliente_telefone_cliente1`
    FOREIGN KEY (`telefone_cliente_idtelefone_cliente`)
    REFERENCES `telefone_cliente` (`idtelefone_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`forma_pag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forma_pag` (
  `id_pagamento` INT NOT NULL,
  `tipo_pag` VARCHAR(45) NOT NULL,
  `data_pag` DATE NOT NULL,
  `valor_pago` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_pagamento`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`telefone_funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telefone_funcionario` (
  `idtelefone_funcionario` INT NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idtelefone_funcionario`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT NOT NULL,
  `inicio_expediente` TIME NOT NULL,
  `fim_expediente` TIME NOT NULL,
  `nome_completo` VARCHAR(80) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `funcao` VARCHAR(30) NOT NULL,
  `telefone_funcionario_idtelefone_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`, `telefone_funcionario_idtelefone_funcionario`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_funcionario_telefone_funcionario1_idx` (`telefone_funcionario_idtelefone_funcionario` ASC),
  CONSTRAINT `fk_funcionario_telefone_funcionario1`
    FOREIGN KEY (`telefone_funcionario_idtelefone_funcionario`)
    REFERENCES `telefone_funcionario` (`idtelefone_funcionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agendamento` (
  `id_agendamento` INT NOT NULL,
  `data` DATE NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `hora` TIME NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `comentarios` TEXT NOT NULL,
  `forma_pag_id_pagamento` INT NULL,
  `funcionario_id_funcionario` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `fk_agendamento_forma_pag1_idx` (`forma_pag_id_pagamento` ASC),
  INDEX `fk_agendamento_funcionario1_idx` (`funcionario_id_funcionario` ASC),
  INDEX `fk_agendamento_cliente1_idx` (`cliente_id_cliente` ASC),
  CONSTRAINT `fk_agendamento_forma_pag1`
    FOREIGN KEY (`forma_pag_id_pagamento`)
    REFERENCES `forma_pag` (`id_pagamento`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_agendamento_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_agendamento_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servico` (
  `id_servico` INT NOT NULL,
  `duracao` TIME NOT NULL,
  `categoria` VARCHAR(75) NOT NULL,
  `preco` DECIMAL(10,2) ZEROFILL NOT NULL,
  PRIMARY KEY (`id_servico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `salaosenac`.`servico_agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servico_agendamento` (
  `idservico_agendamento` INT NOT NULL,
  `preco_total` DECIMAL(10,2) ZEROFILL NOT NULL,
  `quantidade` INT NOT NULL,
  `servico_id_servico` INT NOT NULL,
  `agendamento_id_agendamento` INT NOT NULL,
  PRIMARY KEY (`idservico_agendamento`),
  INDEX `fk_servico_agendamento_servico1_idx` (`servico_id_servico` ASC),
  INDEX `fk_servico_agendamento_agendamento1_idx` (`agendamento_id_agendamento` ASC),
  CONSTRAINT `fk_servico_agendamento_servico1`
    FOREIGN KEY (`servico_id_servico`)
    REFERENCES `servico` (`id_servico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_servico_agendamento_agendamento1`
    FOREIGN KEY (`agendamento_id_agendamento`)
    REFERENCES `agendamento` (`id_agendamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;