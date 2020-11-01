## Criação do Banco de dados ##

## DROP DATABASE fazenda_db;

CREATE DATABASE fazenda_db;

## Criação de Tabelas ##

CREATE TABLE funcionarios (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    salario FLOAT(5.2) NOT NULL,
    data_nascimento DATE,
    situacao ENUM('Ativa','Inativa')
)DEFAULT CHARSET = UTF8;
  
CREATE TABLE vaca (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	especie VARCHAR(50) NOT NULL,

CREATE TABLE ordenha (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	idVaca     # referencia animal

CREATE TABLE producao_de_leite (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	idVaca int unsigned not null
    foreign key (idVaca) references 