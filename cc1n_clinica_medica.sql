create table endereco(
	id_endereco serial,
	rua varchar(100) NOT NULL,
	numero smallint,
	bairro varchar(50),
	cep varchar(10) NOT NULL,
	constraint pk_endereco
		primary key(id_endereco)
	);

create table fabricante(
	id serial,
	cnpj varchar(14) NOT NULL,
	nome varchar(100) NOT NULL,
	constraint pk_fabricante
		primary key (id)
	);

create table endereco_fabricante(
	id_endereco int,
	id_fabricante int,
	constraint pk_endereco_fabricante primary key (id_endereco,id_fabricante),
	constraint fk_endereco_fabricante_fabricante
		foreign key(id_fabricante)
			references fabricante(id),
	constraint fk_endereco_fabricante_endereco
		foreign key (id_endereco)
			references endereco(id_endereco)
	);

create table paciente (
	nome varchar (100) NOT NULL,
	id_paciente serial,
	cpf varchar(11) NOT NULL,
	rg varchar(10) NOT NULL,
	id_endereco int,
	constraint pk_paciente
		primary key(id_paciente),
	constraint fk_paciente
		foreign key (id_endereco)
			references endereco(id_endereco)
	);

create table medicos (
	id_medico serial,
	crm varchar(10) NOT NULL,
	nome varchar(100) NOT NULL,
	id_endereco int,
	telefone varchar(17),
	constraint pk_medicos
		primary key(id_medico),
	constraint fk_medicos
		foreign key (id_endereco)
			references endereco(id_endereco)
	);

create table consultas (
	id_consulta serial,
	data_consulta date NOT NULL,
	descricao varchar (100) NOT NULL,
	medico_id int,
	paciente_id int,
	constraint pk_consultas
		primary key(id_consulta),
	constraint fk_consultas_medicos
		foreign key (medico_id)
			references medicos(id_medico),
	constraint fk_consultas_pacientes
		foreign key (paciente_id)
			references paciente (id_paciente)
	);

create table tipos_medicamentos(
	id serial,
	nome varchar(50),
	constraint pk_tipos_medicamentos primary key (id)
);


create table medicamentos (
	id serial,
	rf varchar(10),
	preco decimal(8,2) not null,
	nome varchar (50) not null,
	fabricante_id int,
	tipo_medicamento_id int,
	constraint pk_medicamentos primary key (id),
	constraint fk_medicamentos_fabricante
		foreign key (fabricante_id)
			references fabricante(id),
	constraint fk_medicamentos_tipo_medicamento
		foreign key (tipo_medicamento_id)
			references tipos_medicamentos(id)
);

create table receitas (
	id serial,
	consulta_id int,
	descricao text not null,
	data_receita date not null,
	custo decimal(8,2) not null,
	constraint pk_receitas primary key (id),
	constraint fk_receitas_consulta
		foreign key (consulta_id)
			references consultas (id_consulta)
);

create table receita_medicamentos(
	receita_id int,
	medicamento_id int,
	posologia varchar(60) not null,
	modo_uso varchar(500) not null,
	quantidade smallint not null,
	constraint pk_receita_medicamentos primary key(receita_id, medicamento_id),
	constraint fk_receita_medicamentos_receita
		foreign key (receita_id)
			references receitas(id),
	constraint fk_receitas_medicamentos_medicamento
		foreign key (medicamento_id)
			references medicamentos(id)

);
