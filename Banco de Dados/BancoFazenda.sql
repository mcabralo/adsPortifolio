-- Drop Statement --

DROP DATABASE IF EXISTS `fazenda_bd`;

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
    PRIMARY KEY (`idproduto`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


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
    CONSTRAINT `fk_estoque_produto1` FOREIGN KEY (`produto_idproduto`)
        REFERENCES `fazenda_bd`.`produto` (`idproduto`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`vaca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`vaca` (
    `idvaca` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `dataNascimento` DATE NULL DEFAULT NULL,
    `quantidadeInseminacao` INT(11) NULL DEFAULT NULL,
    `estado` ENUM('Prenha', 'Produção', 'Bezerro') NOT NULL,
    `custo` DECIMAL(7 , 2 ) NULL DEFAULT NULL,
    `lucroEsperado` DECIMAL(10 , 2 ) NULL DEFAULT NULL,
    `lucroReal` DECIMAL(10 , 2 ) NULL DEFAULT NULL,
    `especie` VARCHAR(45) NULL,
    PRIMARY KEY (`idvaca`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`alimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`alimentacao` (
    `idalimentacao` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `quantidadeDiaria` INT(11) NOT NULL,
    `estoque_idestoque` INT(11) NOT NULL,
    `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idalimentacao` , `vaca_idvaca`),
    CONSTRAINT `fk_alimentacao_estoque1` FOREIGN KEY (`estoque_idestoque`)
        REFERENCES `fazenda_bd`.`estoque` (`idestoque`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_alimentacao_vaca1` FOREIGN KEY (`vaca_idvaca`)
        REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`dadospessoais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`dadospessoais` (
    `iddadosPessoais` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,
    `cpf` VARCHAR(11) NOT NULL,
    `dataNascimento` DATE NULL DEFAULT NULL,
    `salario` DECIMAL(7 , 2 ) NOT NULL,
    `cargo` VARCHAR(45) NULL DEFAULT NULL,
    PRIMARY KEY (`iddadosPessoais`)
)  ENGINE=INNODB AUTO_INCREMENT=6 DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`equipamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`equipamento` (
    `idequipamento` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,
    `tipo` VARCHAR(45) NOT NULL,
    `estado` ENUM('Ativo', 'Em Uso', 'Em Manutenção') NULL DEFAULT NULL,
    PRIMARY KEY (`idequipamento`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`funcionarios` (
    `idfuncionarios` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `situacao` ENUM('Ativo', 'Inativo') NULL DEFAULT 'Ativo',
    `login` VARCHAR(45) NOT NULL DEFAULT 'funcionario',
    `senha` VARCHAR(45) NOT NULL DEFAULT 'senha',
    `dadospessoais_iddadosPessoais` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idfuncionarios` , `dadospessoais_iddadosPessoais`),
    CONSTRAINT `fk_funcionarios_dadospessoais1` FOREIGN KEY (`dadospessoais_iddadosPessoais`)
        REFERENCES `fazenda_bd`.`dadospessoais` (`iddadosPessoais`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`ordenha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`ordenha` (
    `idordenha` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `dataOrdenha` DATE NOT NULL,
    `volume` DECIMAL(5 , 1 ) NULL DEFAULT NULL,
    `temperaturaLeite` VARCHAR(45) NULL DEFAULT NULL,
    `equipamento_idequipamento` INT(10) UNSIGNED NOT NULL,
    `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idordenha` , `vaca_idvaca`),
    CONSTRAINT `fk_ordenha_equipamento1` FOREIGN KEY (`equipamento_idequipamento`)
        REFERENCES `fazenda_bd`.`equipamento` (`idequipamento`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_ordenha_vaca1` FOREIGN KEY (`vaca_idvaca`)
        REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`producaodeleite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`producaodeleite` (
    `idproducaoDeLeite` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ordenha_idordenha` INT(10) UNSIGNED NOT NULL,
    `produto_idproduto` INT(10) UNSIGNED NOT NULL,
    `funcionarios_idfuncionarios` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idproducaoDeLeite` , `funcionarios_idfuncionarios`),
    CONSTRAINT `fk_producaoDeLeite_ordenha1` FOREIGN KEY (`ordenha_idordenha`)
        REFERENCES `fazenda_bd`.`ordenha` (`idordenha`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_producaoDeLeite_produto1` FOREIGN KEY (`produto_idproduto`)
        REFERENCES `fazenda_bd`.`produto` (`idproduto`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_producaodeleite_funcionarios1` FOREIGN KEY (`funcionarios_idfuncionarios`)
        REFERENCES `fazenda_bd`.`funcionarios` (`idfuncionarios`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`prole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`prole` (
    `idprole` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `inseminacao` DATE NOT NULL,
    `expectativaParto` DATE NOT NULL,
    `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idprole` , `vaca_idvaca`),
    CONSTRAINT `fk_prole_vaca1` FOREIGN KEY (`vaca_idvaca`)
        REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`ruminacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`ruminacao` (
    `idruminacao` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `data` DATE NOT NULL,
    `minutagem` TIME NOT NULL,
    `vaca_idvaca` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`idruminacao` , `vaca_idvaca`),
    CONSTRAINT `fk_ruminacao_vaca1` FOREIGN KEY (`vaca_idvaca`)
        REFERENCES `fazenda_bd`.`vaca` (`idvaca`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8;


-- -----------------------------------------------------
-- Table `fazenda_bd`.`verejistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`verejistas` (
    `idverejistas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NULL,
    `cnpj` VARCHAR(14) NULL,
    PRIMARY KEY (`idverejistas`)
)  ENGINE=INNODB;

-- -----------------------------------------------------
-- Table `fazenda_bd`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fazenda_bd`.`venda` (
    `idvenda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `dataVenda` DATE NOT NULL,
    `produto_idproduto` INT(10) UNSIGNED NOT NULL,
    `verejistas_idverejistas` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`idvenda`),
    CONSTRAINT `fk_venda_produto1` FOREIGN KEY (`produto_idproduto`)
        REFERENCES `fazenda_bd`.`produto` (`idproduto`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_venda_verejistas1` FOREIGN KEY (`verejistas_idverejistas`)
        REFERENCES `fazenda_bd`.`verejistas` (`idverejistas`)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;


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

INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('6');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`,`dadospessoais_iddadosPessoais`) VALUES ('Inativo','7');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('8');
INSERT INTO `fazenda_bd`.`funcionarios` (`dadospessoais_iddadosPessoais`) VALUES ('9');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`,`dadospessoais_iddadosPessoais`) VALUES ('Inativo','10');


-- INSERT DAS VACAS E PERTENCENTES, PROLE E EQUIPAMENTO
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `especie`) VALUES ('2010-01-12', '0', 'Produção', '2100.00', '42.000', 'Guzerá');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2002-02-20', '3', 'Prenha', '2900.00', '91000.00', '82000.00', 'Guzerá');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2017-01-01', '0', 'Produção', '1200.00', '40000.00', '120000.00', 'Guzerá');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2010-12-04', '0', 'Produção', '3300.00', '55000.00', '54000.00', 'Holandês');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2002-06-20', '4', 'Produção', '6000.00', '160000.00', '180000.00', 'Holandês');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2001-07-21', '10', 'Prenha', '1200.00', '11000.00', '10000.00', 'Holandês');
INSERT INTO `fazenda_bd`.`vaca` (`dataNascimento`, `quantidadeInseminacao`, `estado`, `custo`, `lucroEsperado`, `lucroReal`, `especie`) VALUES ('2002-06-20', '3', 'Produção', '2100.00', '90000.00', '110000.00', 'Guzerá');

INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2002-03-10', '2002-12-10', '2');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2004-02-12', '2004-11-12', '2');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2006-02-28', '2006-10-28', '2');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2003-01-10', '2003-10-10', '5');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2005-01-10', '2005-10-10', '5');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2007-02-10', '2007-11-10', '5');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2010-03-21', '2010-12-21', '5');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2002-02-20', '2002-02-20', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2004-02-19', '2004-11-19', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2006-02-04', '2006-11-04', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2008-02-09', '2008-11-09', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2010-03-07', '2010-12-07', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2012-05-10', '2013-02-10', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2015-01-23', '2015-10-23', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2016-10-17', '2017-07-21', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2018-01-10', '2018-10-12', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2019-01-19', '2019-10-19', '6');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2005-06-12', '2006-04-12', '7');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2007-02-20', '2007-11-20', '7');
INSERT INTO `fazenda_bd`.`prole` (`inseminacao`, `expectativaParto`, `vaca_idvaca`) VALUES ('2009-01-10', '2009-10-10', '7');

INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 1', 'Ordenhadeira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 2', 'Ordenhadeira', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 3', 'Ordenhadeira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 4', 'Ordenhadeira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 5', 'Ordenhadeira', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 6', 'Ordenhadeira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 7', 'Ordenhadeira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 8', 'Ordenhadeira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 9', 'Ordenhadeira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Implemis 10', 'Ordenhadeira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 1', 'Trator', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 2', 'Trator', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 3', 'Trator', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 4', 'Trator', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 5', 'Trator', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 6', 'Trator', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 7', 'Colheiteira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 8', 'Colheiteira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 9', 'Colheiteira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 10', 'Colheiteira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 11', 'Colheiteira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 12', 'Colheiteira', 'Ativo');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 13', 'Colheiteira', 'Em Uso');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 14', 'Colheiteira', 'Em Manutenção');
INSERT INTO `fazenda_bd`.`equipamento` (`nome`, `tipo`, `estado`) VALUES ('Trator 15', 'Colheiteira', 'Em Uso');

INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '4');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '2');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-11', '22', '39', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-12', '30', '37', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-13', '31', '39', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-14', '40', '34', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-15', '38', '39', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-16', '39', '40', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-17', '40', '31', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-18', '43', '40', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-19', '44', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-20', '42', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-21', '43', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-22', '49', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-23', '41', '39', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-24', '40', '37', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-25', '37', '39', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-26', '39', '39', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-27', '38', '38', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-28', '39', '39', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-29', '37', '38', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-30', '35', '31', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-21', '40', '37', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-22', '41', '38', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-23', '42', '39', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-24', '32', '39', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-25', '31', '38', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-26', '30', '39', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-27', '41', '37', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-28', '43', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-29', '44', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-30', '41', '40', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-01', '40', '37', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-02', '41', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-03', '42', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-04', '41', '37', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-05', '37', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-06', '39', '39', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-07', '38', '35', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-08', '40', '36', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-09', '41', '37', '26', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-10', '37', '38', '29', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-11', '39', '31', '29', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-12', '38', '36', '29', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-13', '37', '39', '29', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-14', '39', '38', '27', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-15', '38', '37', '28', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-16', '37', '39', '30', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-17', '38', '38', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-18', '35', '40', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-19', '40', '41', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-20', '41', '41', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-21', '43', '42', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-22', '41', '43', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-23', '30', '41', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-24', '31', '42', '31', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-25', '39', '41', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-26', '38', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-27', '37', '38', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-28', '35', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-29', '36', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-30', '39', '39', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-02-01', '38', '40', '24', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-02-02', '31', '41', '25', '5');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '20', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '40', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '43', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '37', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-14', '39', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-15', '40', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-16', '29', '45', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-17', '42', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-18', '40', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-10', '31', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-11', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-12', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2002-12-13', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-11', '22', '39', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-12', '30', '37', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-13', '31', '39', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-14', '40', '34', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-15', '38', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-16', '39', '40', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-17', '40', '31', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-18', '43', '40', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-19', '44', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-20', '42', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-21', '43', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-22', '49', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-23', '41', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-24', '40', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-25', '37', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-26', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-27', '38', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-28', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-29', '37', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2003-10-30', '35', '31', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-21', '40', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-22', '41', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-23', '42', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-24', '32', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-25', '31', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-26', '30', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-27', '41', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-28', '43', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-29', '44', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-12-30', '41', '40', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-01', '40', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-02', '41', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-03', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-04', '41', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-05', '37', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-06', '39', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-07', '38', '35', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-08', '40', '36', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-09', '41', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-10', '37', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-11', '39', '31', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-12', '38', '36', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-13', '37', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-14', '39', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-15', '38', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-16', '37', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-17', '38', '38', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-18', '35', '40', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-19', '40', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-20', '41', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-21', '43', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-22', '41', '43', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-23', '30', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-24', '31', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-25', '39', '41', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-26', '38', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-27', '37', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-28', '35', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-29', '36', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-01-30', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2011-02-01', '38', '40', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-13', '39', '41', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-14', '38', '42', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-15', '39', '41', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-16', '40', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-17', '41', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-18', '40', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-18', '41', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-19', '41', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-20', '39', '37', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-21', '38', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-22', '39', '37', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-22', '38', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-23', '37', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-24', '39', '41', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-25', '37', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-26', '39', '40', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-27', '38', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-28', '37', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-29', '39', '43', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-06-30', '38', '41', '32', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-01', '39', '42', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-02', '39', '41', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-03', '38', '41', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-04', '33', '43', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-05', '39', '43', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-06', '34', '31', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-07', '39', '45', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-08', '34', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-09', '40', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-10', '41', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-11', '42', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-12', '41', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-13', '43', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-14', '40', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-15', '40', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-16', '41', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-17', '42', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-18', '39', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-19', '31', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-20', '39', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-21', '32', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-22', '37', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-23', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-24', '39', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-25', '38', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-26', '37', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-27', '39', '37', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-28', '38', '37', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-29', '39', '40', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2005-07-30', '39', '41', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-11', '37', '42', '39', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-12', '39', '41', '38', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-13', '39', '41', '37', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-14', '38', '40', '39', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-15', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-16', '41', '39', '23', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-17', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-18', '42', '38', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-19', '22', '39', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-20', '30', '37', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-21', '31', '39', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-22', '40', '34', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-23', '38', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-24', '39', '40', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-25', '40', '31', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-26', '43', '40', '25', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-27', '44', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-28', '42', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-29', '43', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-30', '49', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-10-31', '41', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-01', '40', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-02', '37', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-03', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-04', '38', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-05', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-06', '37', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-07', '35', '31', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-08', '40', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-09', '41', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-10', '42', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-11', '32', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-12', '31', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-13', '30', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-14', '41', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-15', '43', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-16', '44', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-17', '41', '40', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-18', '40', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-19', '41', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-20', '42', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-21', '41', '37', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-22', '37', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-23', '39', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-24', '38', '35', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-25', '40', '36', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-26', '41', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-27', '37', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-28', '39', '31', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-29', '38', '36', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-11-30', '37', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-01', '39', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-02', '38', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-03', '37', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-04', '38', '38', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-05', '35', '40', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-06', '40', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-07', '41', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-08', '43', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-09', '41', '43', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-10', '30', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-11', '31', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-12', '39', '41', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-13', '38', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-14', '37', '38', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-15', '35', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-16', '36', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-17', '39', '39', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-18', '38', '40', '24', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-20', '39', '41', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-21', '38', '42', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-22', '39', '41', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-23', '40', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-24', '41', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-25', '40', '39', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-26', '41', '38', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-27', '41', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-28', '39', '37', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-29', '38', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2009-12-30', '39', '37', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-01', '38', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-02', '37', '39', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-03', '39', '41', '30', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-04', '37', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-05', '39', '40', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-06', '38', '42', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-07', '37', '41', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-08', '39', '43', '31', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-09', '38', '41', '32', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-10', '39', '42', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-11', '39', '41', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-12', '38', '41', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-13', '33', '43', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-14', '39', '43', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-15', '34', '31', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-16', '39', '45', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-17', '34', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-18', '40', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-19', '41', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-20', '42', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-21', '41', '37', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-22', '43', '39', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-23', '40', '38', '26', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-24', '40', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-25', '41', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-26', '42', '39', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-27', '39', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-28', '31', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-29', '39', '38', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-01-30', '32', '37', '28', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-01', '37', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-02', '39', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-03', '39', '37', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-04', '38', '39', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-05', '37', '38', '27', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-06', '39', '37', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-07', '38', '37', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-08', '39', '40', '29', '6');
INSERT INTO `fazenda_bd`.`ordenha` (`dataOrdenha`, `volume`, `temperaturaLeite`, `equipamento_idequipamento`, `vaca_idvaca`) VALUES ('2010-02-09', '39', '41', '29', '6');


-- -----------------------------------------------------
-- Consultas
-- -----------------------------------------------------

CREATE VIEW Consulta_Funcionarios AS
    SELECT 
        dp.nome AS 'Nome',
        dp.cpf AS 'CPF',
        dp.dataNAScimento AS 'Data de Nascimento',
        dp.salario AS 'Salário',
        dp.cargo AS 'Cargo'
    FROM
        dadospessoais AS dp
            JOIN
        funcionarios AS f ON dp.iddadosPessoais = f.dadospessoais_iddadosPessoais
    WHERE
        f.situacao = 'Ativo';

SELECT 
    *
FROM
    vaca;
    
CREATE VIEW Consulta_Lucro_Agro AS
    SELECT 
        especie AS 'Espécie',
        (lucroEsperado - lucroReal) AS 'Lucro Total',
        lucroReal AS 'Lucro Real',
        lucroEsperado AS 'Lucro Esperado',
        custo AS 'Valor',
        quantidadeInseminacao AS 'Quantidade de Inseminações'
    FROM
        vaca
    ORDER BY lucroReal DESC, custo;
    

SELECT v.especie as 'Espécia', SUM(o.volume) as 'Volume de Leite', o.temperaturaLeite as 'Temperatura', v.estado as 'Estado'
FROM ordenha o JOIN vaca v ON o.vaca_idvaca = v.idvaca
GROUP BY v.especie;
-- -----------------------------------------------------
-- VIEWS
-- -----------------------------------------------------

SELECT * FROM Consulta_Funcionarios;
    
SELECT * FROM Consulta_Lucro_Agro;