CREATE DATABASE  IF NOT EXISTS `fazenda_bd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fazenda_bd`;
-- MariaDB dump 10.17  Distrib 10.4.10-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: fazenda_bd
-- ------------------------------------------------------
-- Server version	10.4.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alimentacao`
--

DROP TABLE IF EXISTS `alimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alimentacao` (
  `idalimentacao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantidadeDiaria` int(11) NOT NULL,
  `estoque_idestoque` int(11) NOT NULL,
  PRIMARY KEY (`idalimentacao`),
  KEY `fk_alimentacao_estoque1` (`estoque_idestoque`),
  CONSTRAINT `fk_alimentacao_estoque1` FOREIGN KEY (`estoque_idestoque`) REFERENCES `estoque` (`idestoque`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alimentacao`
--

LOCK TABLES `alimentacao` WRITE;
/*!40000 ALTER TABLE `alimentacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `alimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dadosfuncionarios`
--

DROP TABLE IF EXISTS `dadosfuncionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dadosfuncionarios` (
  `iddadosFuncionarios` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salario` decimal(5,2) DEFAULT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddadosFuncionarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dadosfuncionarios`
--

LOCK TABLES `dadosfuncionarios` WRITE;
/*!40000 ALTER TABLE `dadosfuncionarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `dadosfuncionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dadospessoais`
--

DROP TABLE IF EXISTS `dadospessoais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dadospessoais` (
  `iddadosPessoais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cpf` int(11) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  PRIMARY KEY (`iddadosPessoais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dadospessoais`
--

LOCK TABLES `dadospessoais` WRITE;
/*!40000 ALTER TABLE `dadospessoais` DISABLE KEYS */;
/*!40000 ALTER TABLE `dadospessoais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamento`
--

DROP TABLE IF EXISTS `equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipamento` (
  `idequipamento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `estado` enum('Ativo','Em Uso','Em Manutenção') DEFAULT NULL,
  PRIMARY KEY (`idequipamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estoque` (
  `idestoque` int(11) NOT NULL,
  `produto_idproduto` int(10) unsigned NOT NULL,
  `dataEntrada` date NOT NULL,
  `dataValidade` date NOT NULL,
  `quantidadeProdutoLote` date NOT NULL,
  PRIMARY KEY (`idestoque`),
  KEY `fk_estoque_produto1` (`produto_idproduto`),
  CONSTRAINT `fk_estoque_produto1` FOREIGN KEY (`produto_idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionarios` (
  `idfuncionarios` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `situacao` enum('Ativo','Inativo') DEFAULT 'Inativo',
  `login` varchar(45) NOT NULL DEFAULT 'funcionario',
  `senha` varchar(45) DEFAULT 'senha',
  `dadosFuncionarios_iddadosFuncionarios` int(10) unsigned NOT NULL,
  `dadosPessoais_iddadosPessoais` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfuncionarios`),
  KEY `fk_funcionarios_dadosFuncionarios1` (`dadosFuncionarios_iddadosFuncionarios`),
  KEY `fk_funcionarios_dadosPessoais1` (`dadosPessoais_iddadosPessoais`),
  CONSTRAINT `fk_funcionarios_dadosFuncionarios1` FOREIGN KEY (`dadosFuncionarios_iddadosFuncionarios`) REFERENCES `dadosfuncionarios` (`iddadosFuncionarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionarios_dadosPessoais1` FOREIGN KEY (`dadosPessoais_iddadosPessoais`) REFERENCES `dadospessoais` (`iddadosPessoais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenha`
--

DROP TABLE IF EXISTS `ordenha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenha` (
  `idordenha` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataOrdenha` date NOT NULL,
  `volume` int(11) DEFAULT NULL,
  `ordenhacol` varchar(45) DEFAULT NULL,
  `temperaturaLeite` varchar(45) DEFAULT NULL,
  `vaca_idvaca` int(10) unsigned NOT NULL,
  `equipamento_idequipamento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idordenha`),
  KEY `fk_ordenha_vaca1` (`vaca_idvaca`),
  KEY `fk_ordenha_equipamento1` (`equipamento_idequipamento`),
  CONSTRAINT `fk_ordenha_equipamento1` FOREIGN KEY (`equipamento_idequipamento`) REFERENCES `equipamento` (`idequipamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenha_vaca1` FOREIGN KEY (`vaca_idvaca`) REFERENCES `vaca` (`idvaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenha`
--

LOCK TABLES `ordenha` WRITE;
/*!40000 ALTER TABLE `ordenha` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `populacaovacas`
--

DROP TABLE IF EXISTS `populacaovacas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `populacaovacas` (
  `idvaca` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `especie` varchar(45) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `vaca_idvaca` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idvaca`),
  KEY `fk_populacaoVacas_vaca1` (`vaca_idvaca`),
  CONSTRAINT `fk_populacaoVacas_vaca1` FOREIGN KEY (`vaca_idvaca`) REFERENCES `vaca` (`idvaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `populacaovacas`
--

LOCK TABLES `populacaovacas` WRITE;
/*!40000 ALTER TABLE `populacaovacas` DISABLE KEYS */;
/*!40000 ALTER TABLE `populacaovacas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producaodeleite`
--

DROP TABLE IF EXISTS `producaodeleite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producaodeleite` (
  `idproducaoDeLeite` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `funcionarios_idfuncionarios` int(10) unsigned NOT NULL,
  `ordenha_idordenha` int(10) unsigned NOT NULL,
  `produto_idproduto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idproducaoDeLeite`),
  KEY `fk_producaoDeLeite_funcionarios1` (`funcionarios_idfuncionarios`),
  KEY `fk_producaoDeLeite_ordenha1` (`ordenha_idordenha`),
  KEY `fk_producaoDeLeite_produto1` (`produto_idproduto`),
  CONSTRAINT `fk_producaoDeLeite_funcionarios1` FOREIGN KEY (`funcionarios_idfuncionarios`) REFERENCES `funcionarios` (`idfuncionarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producaoDeLeite_ordenha1` FOREIGN KEY (`ordenha_idordenha`) REFERENCES `ordenha` (`idordenha`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producaoDeLeite_produto1` FOREIGN KEY (`produto_idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producaodeleite`
--

LOCK TABLES `producaodeleite` WRITE;
/*!40000 ALTER TABLE `producaodeleite` DISABLE KEYS */;
/*!40000 ALTER TABLE `producaodeleite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produto` (
  `idproduto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `preco` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prole`
--

DROP TABLE IF EXISTS `prole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prole` (
  `idprole` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inseminacao` date NOT NULL,
  `expectativaParto` date NOT NULL,
  PRIMARY KEY (`idprole`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prole`
--

LOCK TABLES `prole` WRITE;
/*!40000 ALTER TABLE `prole` DISABLE KEYS */;
/*!40000 ALTER TABLE `prole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruminacao`
--

DROP TABLE IF EXISTS `ruminacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ruminacao` (
  `idruminacao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `minutagem` time NOT NULL,
  `vaca_idvaca` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idruminacao`),
  KEY `fk_ruminacao_vaca1` (`vaca_idvaca`),
  CONSTRAINT `fk_ruminacao_vaca1` FOREIGN KEY (`vaca_idvaca`) REFERENCES `vaca` (`idvaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruminacao`
--

LOCK TABLES `ruminacao` WRITE;
/*!40000 ALTER TABLE `ruminacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruminacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaca`
--

DROP TABLE IF EXISTS `vaca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaca` (
  `idvaca` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataNascimento` date DEFAULT NULL,
  `quantidadeInseminacao` int(11) DEFAULT NULL,
  `estado` enum('Prenha','Produção','Bezerro') NOT NULL,
  `prole_idprole` int(10) unsigned NOT NULL,
  `alimentacao_idalimentacao` int(10) unsigned NOT NULL,
  `custo` decimal(5,2) DEFAULT NULL,
  `lucro` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idvaca`),
  KEY `fk_vaca_prole1` (`prole_idprole`),
  KEY `fk_vaca_alimentacao1` (`alimentacao_idalimentacao`),
  CONSTRAINT `fk_vaca_alimentacao1` FOREIGN KEY (`alimentacao_idalimentacao`) REFERENCES `alimentacao` (`idalimentacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vaca_prole1` FOREIGN KEY (`prole_idprole`) REFERENCES `prole` (`idprole`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaca`
--

LOCK TABLES `vaca` WRITE;
/*!40000 ALTER TABLE `vaca` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaca` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-01 17:01:27

## Inserts ##



#Insert Dados Pessoais
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Matheus Cabral', '11122233344455', '09-22-1995');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Robson Oliveira', '22233344455566', '02-12-1986');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Adelaide Santos', '33344455566677', '01-30-2000');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Paulo Nogueira', '44455566677788', '12-17-1972');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Chico Duarte', '55566677788899', '12-10-1998');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('Laerton Dantas', '66677788899910', '02-03-1954');
INSERT INTO `fazenda_bd`.`dadospessoais` (`nome`, `cpf`, `dataNascimento`) VALUES ('João Vitor', '77788899911100', '06-10-1981');

INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('7200.00', 'Analista');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('1900.00', 'Operador');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('1500.00', 'Fazendeiro');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('1500.00', 'Fazendeiro');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('2200.00', 'Operador');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('1900.00', 'Operador');
INSERT INTO `fazenda_bd`.`dadosfuncionarios` (`salario`, `cargo`) VALUES ('3000.00', 'Contador');

INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '1', '1');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '2', '2');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '3', '3');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '4', '4');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '5', '5');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Ativo', '6', '6');
INSERT INTO `fazenda_bd`.`funcionarios` (`situacao`, `dadosFuncionarios_iddadosFuncionarios`, `dadosPessoais_iddadosPessoais`) VALUES ('Inativo', '7', '7');


## Selects

# Select com todos os funcionarios e dados da Fazenda

Select * from dadospessoais dp join dadosfuncionarios df, funcionarios f;


Select * from dadospessoais dp join dadosfuncionarios df on dp.dadosfuncionarios funcionarios f;
