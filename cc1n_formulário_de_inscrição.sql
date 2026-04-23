create table cursos(
	id serial,
	nome varchar(100) not null,
	constraint pk_cursos primary key(id)
);

create table funcionarios(
	ra serial, 
	nome varchar(100) not null,
	sexo char not null,
	nacionalidade varchar(100) 
		default 'Brasileiro',
	data_nascimento date not null,
	constraint pk_funcionarios primary key (ra)
);

create table maticulas(
	ra int,
	curso_id int,
	inscricao timestamp not null,
	termino timestamp,
	constraint pk_matriculas primary key(ra,curso_id),
	constraint fk_matriculas_funcionarios
		foreign key (ra) references funcionarios(ra),
	constraint fk_matriculas_cursos
		foreign key (curso_id) references cursos(id)
);

create table telefones(
	id serial,
	ra integer,
	ddi char(5),
	ddd char(3),
	numero char(9) not null,
	constraint pk_telefones primary key (id, ra),
	constraint fk_telefones_funcionarios
		foreign key (ra) references funcionarios(ra)
);

create table funcionarios_enderecos(
	ra int,
	endereco_id int,
	constraint pk_funcionarios_enderecos
		primary key(ra,endereco_id)
);

create table enderecos(
	id serial,
	rua varchar(100),
	numero smallint,
	bairro varchar(50),
	cidade varchar(100),
	cep char(8) not null,
	constraint pk_enderecos primary key (id)
);

alter table funcionarios_enderecos
  add constraint fk_funcionarios_enderecos_funcionarios
  	foreign key (ra) references funcionarios (ra);

alter table funcionarios_enderecos
	add constraint fk_funcionarios_enderecos_enderecos
		foreign key (endereco_id)
			references enderecos (id);