-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema agenda_corporativa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema agenda_corporativa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agenda_corporativa` DEFAULT CHARACTER SET utf8 ;
USE `agenda_corporativa` ;

-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Empresa` (
  `PK_empresa` INT NOT NULL COMMENT 'Chave primária da tabela empresa',
  `cnpj` VARCHAR(14) NOT NULL COMMENT 'Cadastro Nacional da Pessoa Jurídica.',
  `nome_empresa` VARCHAR(45) NOT NULL COMMENT 'Nome de identificação da empresa.',
  `endereco_empresa` VARCHAR(45) NULL COMMENT 'Endereço de localização física da empresa.',
  `telefone_empresa` VARCHAR(13) NOT NULL COMMENT 'Número de contato da empresa.',
  PRIMARY KEY (`PK_empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Colaborador` (
  `PK_colaborador` INT NOT NULL COMMENT 'Chave primária da tabela colaborador',
  `cpf` VARCHAR(11) NOT NULL COMMENT 'Cadastro de Pessoa Física, identificador único do colaborador.',
  `nome_colaborador` VARCHAR(45) NOT NULL COMMENT 'Nome de identificação do colaborador.',
  `endereco_colaborador` VARCHAR(45) NULL COMMENT 'Endereço residencial do colaborador',
  `telefone_colaborador` VARCHAR(13) NULL COMMENT 'Número de contato do colaborador.',
  PRIMARY KEY (`PK_colaborador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TD_Tipo_Compromisso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TD_Tipo_Compromisso` (
  `PK_cod_tipo_compromisso` INT NOT NULL COMMENT 'Identificador único do tipo de compromisso',
  `tipo` VARCHAR(45) NULL COMMENT 'Descrição do tipo de compromisso',
  PRIMARY KEY (`PK_cod_tipo_compromisso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Compromisso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Compromisso` (
  `PK_cod_compromisso` INT NOT NULL COMMENT 'Identificador único do evento (compromisso).',
  `data_hora_inicio` DATETIME NOT NULL COMMENT 'Data/hora de início do compromisso.',
  `data_hora_fim` DATETIME NULL COMMENT 'Data/hora final do compromisso.',
  `descricao` VARCHAR(255) NULL COMMENT 'Descrição geral sobre o compromisso.',
  `FK_cod_tipo_compromisso` INT NOT NULL COMMENT 'Identificador único do tipo do compromisso.',
  PRIMARY KEY (`PK_cod_compromisso`),
  INDEX `fk_TB_Compromisso_TD_Tipo_Compromisso1_idx` (`FK_cod_tipo_compromisso` ASC),
  CONSTRAINT `fk_TB_Compromisso_TD_Tipo_Compromisso1`
    FOREIGN KEY (`FK_cod_tipo_compromisso`)
    REFERENCES `agenda_corporativa`.`TD_Tipo_Compromisso` (`PK_cod_tipo_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Pessoal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Pessoal` (
  `PK_cod_pessoal` INT NOT NULL COMMENT 'Identificador único do compromisso \'pessoal\'',
  `local` VARCHAR(45) NULL COMMENT 'Localização onde o compromisso ocorrerá',
  `FK_cod_compromisso` INT NOT NULL COMMENT 'Chave estrangeira do compromisso criado',
  PRIMARY KEY (`PK_cod_pessoal`),
  INDEX `fk_TB_Pessoal_TB_Compromisso1_idx` (`FK_cod_compromisso` ASC),
  CONSTRAINT `fk_TB_Pessoal_TB_Compromisso1`
    FOREIGN KEY (`FK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Conta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Conta` (
  `PK_cod_conta` INT NOT NULL COMMENT 'Identificador único do compromisso \'conta\'',
  `cod_barra` VARCHAR(13) NULL COMMENT 'Codigo de barra da conta',
  `valor` DOUBLE NULL COMMENT 'Valor total da conta',
  `FK_cod_compromisso` INT NOT NULL COMMENT 'Chave estrangeira do compromisso criado',
  PRIMARY KEY (`PK_cod_conta`),
  INDEX `fk_TB_Conta_TB_Compromisso1_idx` (`FK_cod_compromisso` ASC),
  CONSTRAINT `fk_TB_Conta_TB_Compromisso1`
    FOREIGN KEY (`FK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Atividade_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Atividade_Projeto` (
  `PK_cod_atividade_projeto` INT NOT NULL COMMENT 'Identificador único do compromisso \'Atividade Projeto\'',
  `nome_projeto` VARCHAR(45) NULL COMMENT 'Nome da atividade do Projeto',
  `FK_cod_compromisso` INT NOT NULL COMMENT 'Chave estrangeira do compromisso criado',
  PRIMARY KEY (`PK_cod_atividade_projeto`),
  INDEX `fk_TB_Atividade_Projeto_TB_Compromisso1_idx` (`FK_cod_compromisso` ASC),
  CONSTRAINT `fk_TB_Atividade_Projeto_TB_Compromisso1`
    FOREIGN KEY (`FK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Reuniao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Reuniao` (
  `PK_cod_reuniao` INT NOT NULL,
  `local` VARCHAR(45) NULL,
  `assunto` VARCHAR(45) NULL,
  `pauta` VARCHAR(255) NULL,
  `ata` VARCHAR(255) NULL,
  `FK_cod_compromisso` INT NOT NULL COMMENT 'Chave estrangeira do compromisso criado',
  PRIMARY KEY (`PK_cod_reuniao`),
  INDEX `fk_TB_Reuniao_TB_Compromisso1_idx` (`FK_cod_compromisso` ASC),
  CONSTRAINT `fk_TB_Reuniao_TB_Compromisso1`
    FOREIGN KEY (`FK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TA_Agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TA_Agenda` (
  `TB_Colaborador_PK_colaborador` INT NOT NULL COMMENT 'Identificador único do colaborador.',
  `TB_Compromisso_PK_cod_compromisso` INT NOT NULL COMMENT 'Identificador único do compromisso.',
  `criador` TINYINT(1) NULL DEFAULT 0 COMMENT 'Indica se o colaborador é o criador do evento ou não.',
  PRIMARY KEY (`TB_Colaborador_PK_colaborador`, `TB_Compromisso_PK_cod_compromisso`),
  INDEX `fk_TB_Colaborador_has_TB_Compromisso_TB_Compromisso1_idx` (`TB_Compromisso_PK_cod_compromisso` ASC),
  INDEX `fk_TB_Colaborador_has_TB_Compromisso_TB_Colaborador1_idx` (`TB_Colaborador_PK_colaborador` ASC),
  CONSTRAINT `fk_TB_Colaborador_has_TB_Compromisso_TB_Colaborador1`
    FOREIGN KEY (`TB_Colaborador_PK_colaborador`)
    REFERENCES `agenda_corporativa`.`TB_Colaborador` (`PK_colaborador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_Colaborador_has_TB_Compromisso_TB_Compromisso1`
    FOREIGN KEY (`TB_Compromisso_PK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TD_Tipo_Efemeride`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TD_Tipo_Efemeride` (
  `PK_cod_Efemerides` INT NOT NULL COMMENT 'Identificador único do tipo de efemeride',
  `tipo_efemeride` VARCHAR(45) NULL COMMENT 'Descrição do tipo de efemeride',
  PRIMARY KEY (`PK_cod_Efemerides`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Efemeride`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Efemeride` (
  `PK_cod_Efemeride` INT NOT NULL COMMENT 'Identificador único do compromisso \'efemeride\'',
  `observacao` VARCHAR(45) NULL COMMENT 'Observação relacionada à efemeride',
  `FK_cod_compromisso` INT NOT NULL COMMENT 'Chave estrangeira do compromisso criado',
  `FK_cod_Efemerides` INT NOT NULL COMMENT 'Chave estrangeira do codigo de efemerides',
  PRIMARY KEY (`PK_cod_Efemeride`),
  INDEX `fk_TB_Efemeride_TB_Compromisso1_idx` (`FK_cod_compromisso` ASC),
  INDEX `fk_TB_Efemeride_TD_Efemerides1_idx` (`FK_cod_Efemerides` ASC),
  CONSTRAINT `fk_TB_Efemeride_TB_Compromisso1`
    FOREIGN KEY (`FK_cod_compromisso`)
    REFERENCES `agenda_corporativa`.`TB_Compromisso` (`PK_cod_compromisso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_Efemeride_TD_Efemerides1`
    FOREIGN KEY (`FK_cod_Efemerides`)
    REFERENCES `agenda_corporativa`.`TD_Tipo_Efemeride` (`PK_cod_Efemerides`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenda_corporativa`.`TB_Empresa_has_TB_Colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenda_corporativa`.`TB_Empresa_has_TB_Colaborador` (
  `TB_Empresa_PK_empresa` INT NOT NULL COMMENT 'Identificador único da empresa.',
  `TB_Colaborador_PK_colaborador` INT NOT NULL COMMENT 'Identificador único do colaborador.',
  `numero_contrato` VARCHAR(45) NOT NULL COMMENT 'Numero do contrato empresa-colaborador',
  PRIMARY KEY (`TB_Empresa_PK_empresa`, `TB_Colaborador_PK_colaborador`),
  INDEX `fk_TB_Empresa_has_TB_Colaborador_TB_Colaborador1_idx` (`TB_Colaborador_PK_colaborador` ASC),
  INDEX `fk_TB_Empresa_has_TB_Colaborador_TB_Empresa1_idx` (`TB_Empresa_PK_empresa` ASC),
  CONSTRAINT `fk_TB_Empresa_has_TB_Colaborador_TB_Empresa1`
    FOREIGN KEY (`TB_Empresa_PK_empresa`)
    REFERENCES `agenda_corporativa`.`TB_Empresa` (`PK_empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_Empresa_has_TB_Colaborador_TB_Colaborador1`
    FOREIGN KEY (`TB_Colaborador_PK_colaborador`)
    REFERENCES `agenda_corporativa`.`TB_Colaborador` (`PK_colaborador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- População das tabelas
-- -----------------------------------------------------
INSERT INTO tb_empresa VALUES (1, '06429005151', 'Empresa Maneira', 'CLS 103 Bloco A', '5561995571112');

INSERT INTO tb_colaborador VALUES (1, '06429005151', 'Giordano Migliorini', 'SQS 103 Bloco A', '5561995571112');
INSERT INTO tb_colaborador VALUES (2, '55545454545', 'Lucas Felippe', 'SQS 103 Bloco A', '5561995571113');

INSERT INTO tb_empresa_has_tb_colaborador VALUES (1, 1, '0001');
INSERT INTO tb_empresa_has_tb_colaborador VALUES (1, 2, '0002');

INSERT INTO td_tipo_compromisso VALUES (1, 'Compromisso Pessoal');
INSERT INTO td_tipo_compromisso VALUES (2, 'Conta a Pagar');
INSERT INTO td_tipo_compromisso VALUES (3, 'Atividade de Projetos');
INSERT INTO td_tipo_compromisso VALUES (4, 'Reunião');
INSERT INTO td_tipo_compromisso VALUES (5, 'Efeméride');

INSERT INTO td_tipo_efemeride VALUES (1, 'Aniversário');
INSERT INTO td_tipo_efemeride VALUES (2, 'Feriado');
INSERT INTO td_tipo_efemeride VALUES (3, 'Ponto Facultativo');

INSERT INTO tb_compromisso VALUES (1, CAST(N'2019-05-30 10:34:09.000' AS DateTime), CAST(N'2019-05-30 11:34:09.000' AS DateTime), 'Café da manhã com família', 1);
INSERT INTO tb_pessoal VALUES (1, 'Casa da vó', 1);
INSERT INTO ta_agenda VALUES (1, 1, TRUE);

INSERT INTO tb_compromisso VALUES (2, CAST(N'2019-05-31 10:34:09.000' AS DateTime), CAST(N'2019-05-31 11:34:09.000' AS DateTime), 'Conta de Luz', 2);
INSERT INTO tb_conta VALUES (1, '1002454780012', 12.99, 2);
INSERT INTO ta_agenda VALUES (2, 2, TRUE);

INSERT INTO tb_compromisso VALUES (3, CAST(N'2019-05-29 10:34:09.000' AS DateTime), CAST(N'2019-05-29 11:34:09.000' AS DateTime), 'TCC', 3);
INSERT INTO tb_atividade_projeto VALUES (1, 'Impactos do desmatamento da Amazonia na China', 3);
INSERT INTO ta_agenda VALUES (1, 3, TRUE);
INSERT INTO ta_agenda VALUES (2, 3, FALSE);

INSERT INTO tb_compromisso VALUES (4, CAST(N'2019-05-30 14:34:09.000' AS DateTime), CAST(N'2019-05-30 15:34:09.000' AS DateTime), 'Empresários da Bahia', 4);
INSERT INTO tb_reuniao VALUES (1, 'Brasília-DF', 'Canibalismo', 'Tribos canibais da America Central', 'Estão comendo pessoas', 4);
INSERT INTO ta_agenda VALUES (1, 4, TRUE);
INSERT INTO ta_agenda VALUES (2, 4, FALSE);

INSERT INTO tb_compromisso VALUES (5, CAST(N'2019-05-30 07:34:09.000' AS DateTime), CAST(N'2019-05-30 08:34:09.000' AS DateTime), 'Aniversário da Matilda', 5);
INSERT INTO tb_efemeride VALUES (1, '65 anos, bolo mediano', 5, 1);
INSERT INTO ta_agenda VALUES (1, 5, TRUE);

INSERT INTO tb_compromisso VALUES (6, CAST(N'2019-04-30 07:34:09.000' AS DateTime), CAST(N'2019-04-30 08:34:09.000' AS DateTime), 'Feriado nacional do amor ao elefante', 5);
INSERT INTO tb_efemeride VALUES (2, 'Faltaram elefantes', 5, 2);
INSERT INTO ta_agenda VALUES (1, 6, TRUE);

INSERT INTO tb_compromisso VALUES (7, CAST(N'2019-05-16 07:34:09.000' AS DateTime), CAST(N'2019-05-16 08:34:09.000' AS DateTime), 'Greve de onibus', 5);
INSERT INTO tb_efemeride VALUES (3, 'Paralização geral dos onibus do DF', 5, 3);
INSERT INTO ta_agenda VALUES (1, 7, TRUE);
INSERT INTO ta_agenda VALUES (2, 7, FALSE);

select c.nome_colaborador as Nome, 
       co.descricao as Evento, 
       co.data_hora_inicio as Inicio, 
       co.data_hora_fim as Fim 
  from ta_agenda a
  inner join tb_colaborador c inner join tb_compromisso co
  where a.TB_Colaborador_PK_colaborador = c.PK_colaborador 
    and a.TB_Compromisso_PK_cod_compromisso = co.PK_cod_compromisso
    and co.data_hora_inicio > CAST(N'2019-05-26 00:00:00.000' AS DateTime)
    and co.data_hora_fim < CAST(N'2019-06-02 00:00:00.000' AS DateTime)
    and c.PK_colaborador = 1
  order by co.data_hora_inicio;

/*  */
select c.nome_colaborador as Nome, 
       co.descricao as Evento, 
       co.data_hora_inicio as Inicio, 
       co.data_hora_fim as Fim 
  from ta_agenda a
  inner join tb_colaborador c inner join tb_compromisso co
  where a.TB_Colaborador_PK_colaborador = c.PK_colaborador 
    and a.TB_Compromisso_PK_cod_compromisso = co.PK_cod_compromisso
    and co.data_hora_inicio > CAST(N'2019-06-2 00:00:00.000' AS DateTime)
    and co.data_hora_inicio < CAST(N'2019-06-09 00:00:00.000' AS DateTime)
    and c.PK_colaborador = 1
  order by co.data_hora_inicio;
  
select c.nome_colaborador as Nome,
       ap.nome_projeto as Nome_Projeto,
       case when co.data_hora_fim < sysdate() then 'Terminado' else 'Não Terminado' end as Estado_Projeto,
       co.data_hora_fim, co.PK_cod_compromisso
  from ta_agenda a inner join tb_colaborador c
   inner join tb_atividade_projeto ap inner join tb_compromisso co
  where co.PK_cod_compromisso = ap.FK_cod_compromisso
    and a.TB_Colaborador_PK_colaborador = c.PK_colaborador
    and a.TB_Compromisso_PK_cod_compromisso = co.PK_cod_compromisso
  order by co.data_hora_inicio; 

update tb_compromisso c set c.data_hora_fim = CAST(N'2020-05-16 07:34:09.000' AS DateTime) where c.pk_cod_compromisso = 3;

select c.nome_colaborador as Nome,
       ap.nome_projeto as Nome_Projeto,
       case when co.data_hora_fim < sysdate() then 'Terminado' else 'Não Terminado' end as Estado_Projeto,
       co.data_hora_fim, co.PK_cod_compromisso
  from ta_agenda a inner join tb_colaborador c
   inner join tb_atividade_projeto ap inner join tb_compromisso co
  where co.PK_cod_compromisso = ap.FK_cod_compromisso
    and a.TB_Colaborador_PK_colaborador = c.PK_colaborador
    and a.TB_Compromisso_PK_cod_compromisso = co.PK_cod_compromisso
  order by co.data_hora_inicio; 

select c.nome_colaborador as Nome,
       r.pauta as Pauta,
       r.ata as Ata
  from tb_compromisso co inner join tb_reuniao r
   inner join ta_agenda a inner join tb_colaborador c
  where co.pk_cod_compromisso = r.fk_cod_compromisso
	and co.data_hora_inicio > CAST(N'2019-05-26 00:00:00.000' AS DateTime)
    and co.data_hora_inicio < CAST(N'2019-06-02 00:00:00.000' AS DateTime)
    and a.TB_Colaborador_PK_colaborador = c.PK_colaborador
    and a.TB_Compromisso_PK_cod_compromisso = co.PK_cod_compromisso;
    
select co.data_hora_fim as Vencimento,
	   co.descricao as Descrição,
       c.valor as Valor
  from tb_compromisso co inner join tb_conta c
  where co.pk_cod_compromisso = c.fk_cod_compromisso
    and co.data_hora_fim > CAST(N'2019-05-26 00:00:00.000' AS DateTime)
    and co.data_hora_fim < CAST(N'2019-06-02 00:00:00.000' AS DateTime)
  order by data_hora_fim;

(todas os compromissos de pagamento com data, descrição e valor
ordenados por data de vencimento dentro do período dado)