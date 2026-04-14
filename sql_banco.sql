-- Database: cc1n_clinica

-- DROP DATABASE IF EXISTS cc1n_clinica;

CREATE DATABASE cc1n_clinica
    WITH
    OWNER = cc1n
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

	create table endereco(
	id_endereco serial NOT NULL,
	rua varchar(100) NOT NULL,
	numero smallint NULL,
	bairro varchar(50) NULL,
	cep varchar(10) NOT NULL,
	constraint pk_endereco
		primary key(id_endereco)
	);

	create table fabricante(
	id_fabricante serial NOT NULL,
	cnpj varchar(14) NOT NULL,
	nome varchar(100) NOT NULL,
	constraint pk_fabricante
		primary key (id_fabricante)
	);

	create table endereco_fabricante(
	id_endereco int NOT NULL,
	id_fabricante int NOT NULL,
	constraint pk_endereco_fabricante
		foreign key(id_fabricante)
		references fabricante(id_fabricante),
	constraint fk_endereco_fabricante
		foreign key (id_endereco)
		references endereco(id_endereco)
	);

	create table paciente (
	nome varchar (100) NOT NULL,
	id_paciente serial NOT NULL,
	cpf varchar(11) NOT NULL,
	rg varchar(10) NOT NULL,
	id_endereco int NOT NULL,
	constraint pk_paciente
		primary key(id_paciente),
	constraint fk_paciente
		foreign key (id_endereco)
		references endereco(id_endereco)
	);

	create table medicos (
	id_medico serial NOT NULL,
	crm varchar(10) NOT NULL,
	nome varchar(100) NOT NULL,
	id_endereco int NOT NULL,
	telefone varchar(17) NUll,
	constraint pk_medicos
		primary key(id_medico),
	constraint fk_medicos
		foreign key (id_endereco)
		references endereco(id_endereco)
	);

	create table consultas (
	id_consulta serial NOT NULL,
	data date NOT NULL,
	descricao varchar (100) NOT NULL,
	medico_id int NOT NULL,
	paciente_id int NOT NULL,
	constraint pk_consultas
		primary key(id_consulta),
	constraint fk_medicos
	)

	