
# API SISPET_V6

Desenvolvido por: Rafael Alencar Pedro

Documentação disponível no documento: Documentação Sispet

Projeto criada com apoio dos professores da faculdade Senac Maringá

Projeto consiste no sistema de petshop SISPET, onde até o momento deste commit é possivel realizar cadastro de usuario do sistema, dentro do sistema é possivel cadastrar, edita, listar e excluir os clientes que são os PETs, também esta disponível as mesmas funcionalidades para os produtos usados no petshop e os fornecedores destes produtos. 


Para rodar o projeto é preciso atentar-se a alguns detalhes: 

1 - Subir o banco de dados localmente conforme o script descrito aqui no Readme. 

2 - Verificar a conexão com a porta 3307

3 - Colocar o windows em modo desenvolvedor







Segue script para criação do banco de dados:

create database sispet_v7;

use sispet_v7

create table usuario (
	id int primary key auto_increment not null,
	nome varchar(100) not null,
	email varchar(150) not null,
	senha varchar(50) not null,
	logado int(11),
	image varchar(200)
);

create table produto (
	id int primary key auto_increment not null,
	nome varchar(100) not null,
	preco double (19,3) not null,
	data_cadastro datetime not null,
	setor varchar(100) not null
);

create table fornecedor (
	id int primary key auto_increment not null,
	nome varchar(100) not null,
	email varchar(100) not null,
	telefone varchar(100) not null,
	cnpj varchar(100) not null
);

create table cliente (
	id int primary key auto_increment not null,
	nome varchar(100) not null,
	cpf varchar(100) not null, 
	telefone varchar(100) not null,
	email varchar(100) not null
);




