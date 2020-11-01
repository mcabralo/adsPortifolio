CREATE TABLE `alimentacao` (
  `idalimentacao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantidadeDiaria` int(11) NOT NULL,
  `estoque_idestoque` int(11) NOT NULL,
  PRIMARY KEY (`idalimentacao`),
  KEY `fk_alimentacao_estoque1` (`estoque_idestoque`),
  CONSTRAINT `fk_alimentacao_estoque1` FOREIGN KEY (`estoque_idestoque`) REFERENCES `estoque` (`idestoque`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `dadosfuncionarios` (
  `iddadosFuncionarios` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salario` decimal(5,2) DEFAULT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddadosFuncionarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `dadospessoais` (
  `iddadosPessoais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cpf` int(11) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  PRIMARY KEY (`iddadosPessoais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `equipamento` (
  `idequipamento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `estado` enum('Ativo','Em Uso','Em Manutenção') DEFAULT NULL,
  PRIMARY KEY (`idequipamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `populacaovacas` (
  `idvaca` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `especie` varchar(45) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `vaca_idvaca` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idvaca`),
  KEY `fk_populacaoVacas_vaca1` (`vaca_idvaca`),
  CONSTRAINT `fk_populacaoVacas_vaca1` FOREIGN KEY (`vaca_idvaca`) REFERENCES `vaca` (`idvaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `produto` (
  `idproduto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `preco` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `prole` (
  `idprole` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inseminacao` date NOT NULL,
  `expectativaParto` date NOT NULL,
  PRIMARY KEY (`idprole`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ruminacao` (
  `idruminacao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `minutagem` time NOT NULL,
  `vaca_idvaca` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idruminacao`),
  KEY `fk_ruminacao_vaca1` (`vaca_idvaca`),
  CONSTRAINT `fk_ruminacao_vaca1` FOREIGN KEY (`vaca_idvaca`) REFERENCES `vaca` (`idvaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
