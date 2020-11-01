-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fazenda_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fazenda_bd
-- -----------------------------------------------------
DROP DATABASE `fazenda_bd`;
CREATE SCHEMA IF NOT EXISTS `fazenda_bd` DEFAULT CHARACTER SET utf8 ;
USE `fazenda_bd` ;

-- -----------------------------------------------------
-- Table `fazenda_bd`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`produto` (
  `idproduto` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `preco` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idproduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`estoque` (
  `idestoque` INT(11) NOT NULL,
  `produto_idproduto` INT(10) UNSIGNED NOT NULL,
  `dataEntrada` DATE NOT NULL,
  `dataValidade` DATE NOT NULL,
  `quantidadeProdutoLote` INT NOT NULL,
  PRIMARY KEY (`idestoque`),
  CONSTRAINT `fk_estoque_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `fazenda_bd`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`alimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`alimentacao` (
  `idalimentacao` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quantidadeDiaria` INT(11) NOT NULL,
  `estoque_idestoque` INT(11) NOT NULL,
  PRIMARY KEY (`idalimentacao`),
  CONSTRAINT `fk_alimentacao_estoque1`
    FOREIGN KEY (`estoque_idestoque`)
    REFERENCES `fazenda_bd`.`estoque` (`idestoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`dadospessoais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`dadospessoais` (
  `iddadosPessoais` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `dataNAScimento` DATE NULL DEFAULT NULL,
  `salario` DECIMAL(7,2) NOT NULL,
  `cargo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`iddadosPessoais`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`equipamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`equipamento` (
  `idequipamento` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `estado` ENUM('Ativo', 'Em Uso', 'Em Manutenção') NULL DEFAULT NULL,
  PRIMARY KEY (`idequipamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`funcionarios` (
  `idfuncionarios` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `situacao` ENUM('Ativo', 'Inativo') NULL DEFAULT 'Ativo',
  `login` VARCHAR(45) NOT NULL DEFAULT 'funcionario',
  `senha` VARCHAR(45) NOT NULL DEFAULT 'senha',
  `dadospessoais_iddadosPessoais` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idfuncionarios`, `dadospessoais_iddadosPessoais`),
  CONSTRAINT `fk_funcionarios_dadospessoais1`
    FOREIGN KEY (`dadospessoais_iddadosPessoais`)
    REFERENCES `fazenda_bd`.`dadospessoais` (`iddadosPessoais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`prole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`prole` (
  `idprole` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `inseminacao` DATE NOT NULL,
  `expectativaParto` DATE NOT NULL,
  PRIMARY KEY (`idprole`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`vaca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`vaca` (
  `idvaca` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dataNAScimento` DATE NULL DEFAULT NULL,
  `quantidadeInseminacao` INT(11) NULL DEFAULT NULL,
  `estado` ENUM('Prenha', 'Produção', 'Bezerro') NOT NULL,
  `prole_idprole` INT(10) UNSIGNED NOT NULL,
  `alimentacao_idalimentacao` INT(10) UNSIGNED NOT NULL,
  `custo` DECIMAL(5,2) NULL DEFAULT NULL,
  `lucro` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idvaca`),
  CONSTRAINT `fk_vaca_alimentacao1`
    FOREIGN KEY (`alimentacao_idalimentacao`)
    REFERENCES `fazenda_bd`.`alimentacao` (`idalimentacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vaca_prole1`
    FOREIGN KEY (`prole_idprole`)
    REFERENCES `fazenda_bd`.`prole` (`idprole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`ordenha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`ordenha` (
  `idordenha` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dataOrdenha` DATE NOT NULL,
  `volume` INT(11) NULL DEFAULT NULL,
  `ordenhacol` VARCHAR(45) NULL DEFAULT NULL,
  `temperaturaLeite` VARCHAR(45) NULL DEFAULT NULL,
  `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
  `equipamento_idequipamento` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idordenha`),
  CONSTRAINT `fk_ordenha_equipamento1`
    FOREIGN KEY (`equipamento_idequipamento`)
    REFERENCES `fazenda_bd`.`equipamento` (`idequipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenha_vaca1`
    FOREIGN KEY (`vaca_idvaca`)
    REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`populacaovacAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`populacaovacAS` (
  `idvaca` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `especie` VARCHAR(45) NULL DEFAULT NULL,
  `quantidade` INT(11) NULL DEFAULT NULL,
  `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idvaca`),
  CONSTRAINT `fk_populacaoVacAS_vaca1`
    FOREIGN KEY (`vaca_idvaca`)
    REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`producaodeleite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`producaodeleite` (
  `idproducaoDeLeite` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ordenha_idordenha` INT(10) UNSIGNED NOT NULL,
  `produto_idproduto` INT(10) UNSIGNED NOT NULL,
  `funcionarios_idfuncionarios` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idproducaoDeLeite`, `funcionarios_idfuncionarios`),
  CONSTRAINT `fk_producaoDeLeite_ordenha1`
    FOREIGN KEY (`ordenha_idordenha`)
    REFERENCES `fazenda_bd`.`ordenha` (`idordenha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producaoDeLeite_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `fazenda_bd`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producaodeleite_funcionarios1`
    FOREIGN KEY (`funcionarios_idfuncionarios`)
    REFERENCES `fazenda_bd`.`funcionarios` (`idfuncionarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`ruminacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`ruminacao` (
  `idruminacao` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `minutagem` TIME NOT NULL,
  `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idruminacao`),
  CONSTRAINT `fk_ruminacao_vaca1`
    FOREIGN KEY (`vaca_idvaca`)
    REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`verejistAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`verejistAS` (
  `idverejistAS` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `cnpj` VARCHAR(14) NULL,
  PRIMARY KEY (`idverejistAS`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `fazenda_bd`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`venda` (
  `idvenda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NOT NULL,
  `produto_idproduto` INT(10) UNSIGNED NOT NULL,
  `verejistAS_idverejistAS` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idvenda`),
  CONSTRAINT `fk_venda_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `fazenda_bd`.`produto` (`idproduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venda_verejistAS1`
    FOREIGN KEY (`verejistAS_idverejistAS`)
    REFERENCES `fazenda_bd`.`verejistAS` (`idverejistAS`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------

-- INSERT FUNCIONÁRIOS
-- REGRA: DEVE SER INSERIDO OS DADOS PESSOAIS E DEPOIS A RELAÇÃO COM A TABELA FUNCIONÁRIOS.
-- A SEPARAÇÃO DESSAS DUAS SE DEVE AO FATO DO LOGIN E SENHA PRECISAREM SER MAIS REQUISITADOS QUE AS OUTRAS INFORMAÇÕES
-- POR MOTIVOS DE ACESSO AO SISTEMA. ISSO REDUZ O GASTO DE MEMÓRIA
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNAScimento`, `salario`, `cargo`) VALUES ('Matheus Cabral', '11122233344', '1995-09-22', '5200.00', 'Analista');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNAScimento`, `salario`, `cargo`) VALUES ('Analice Costa', '22233344455', '1993-03-12', '2300.00', 'Operador');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNAScimento`, `salario`, `cargo`) VALUES ('Dalva Santos', '33344455566', '1986-12-01', '1900.00', 'Fazendeiro');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNAScimento`, `salario`, `cargo`) VALUES ('Roberto Souto', '44455566677', '1954-11-10', '2200.00', 'Fazendeiro');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNAScimento`, `salario`, `cargo`) VALUES ('Jéssica DantAS', '11111111111', '1992-02-21', '2100.00', 'Operador');

INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('1');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('2');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('3');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('4');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('5');

-- -----------------------------------------------------
-- Consultas
-- -----------------------------------------------------

-- SELECT de todos os funcionários mostrando algumAS informações 
CREATE VIEW Consulta_Funcionarios AS
SELECT dp.nome AS 'Nome', dp.cpf AS 'CPF', dp.dataNAScimento AS 'Data de NAScimento', dp.salario AS 'Salário', dp.cargo AS 'Cargo'
FROM dadospessoais AS dp JOIN funcionarios AS f ON dp.iddadosPessoais = f.dadospessoais_iddadosPessoais
WHERE f.situacao = 'Ativo';

-- -----------------------------------------------------
-- VIEWS
-- -----------------------------------------------------

SELECT * FROM Consulta_Funcionarios;