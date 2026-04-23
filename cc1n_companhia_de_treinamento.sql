create table enderecos(
	id serial,
	rua varchar(50),
	bairro varchar(50),
	cidade varchar(50),
	estado varchar(50),
	cep char(8),
	numero smallint,
	constraint pk_enderecos
		primary key (id)
);

create table professores(
	id serial,
	nome varchar(100) not null,
	endereco_id int,
	constraint pk_professores primary key (id),
	constraint fK_professores_enderecos
		foreign key (endereco_id)
			references enderecos(id)
);

create table telefones(
	id serial,
	ddd char(3),
	numero char(9),
	constraint pk_telefones primary key (id)
);

create table professores_telefones(
	professor_id int,
	telefone_id int,
	constraint pk_professores_telefones
		primary key (professor_id,telefone_id),
	constraint fk_professores_telefones_professores
		foreign key (professor_id) references professores(id),
	constraint fk_professores_telefones_telefones
		foreign key (telefone_id) references telefones(id)
);

create table cursos(
	id serial,
	nome varchar(100) not null,
	preco decimal(6,2) null,
	duracao smallint,
	professor_id int,
	constraint pk_cursos primary key (id),
	constraint fk_cursos_professores
		foreign key (professor_id) 
			references professores (id)
);

create table matriculas(
	curso_id int,
	aluno_id int,
	numero serial,
	data_inicio date,
	constraint pk_matriculas
		primary key (curso_id,aluno_id,numero)
);

create table alunos (
	id serial,
	nome varchar(100) not null,
	constraint pk_alunos primary key (id)
);

create table alunos_enderecos(
	aluno_id int,
	endereco_id int,
	constraint pk_alunos_enderecos
		primary key (aluno_id,endereco_id)
);

create table alunos_telefones(
	aluno_id int,
	telefone_id int,
	constraint pk_alunos_telefones
		primary key (aluno_id,telefone_id)
);

alter table matriculas 
	add constraint fk_matriculas_cursos
		foreign key (curso_id) 
			references cursos(id);

alter table matriculas
	add constraint fk_matriculas_alunos
		foreign key (aluno_id)
			references alunos(id);

alter table alunos_enderecos
	add constraint fk_alunos_enderecos_alunos
		foreign key (aluno_id)
			references alunos(id);

alter table alunos_enderecos
	add constraint fk_alunos_enderecos_endereco
		foreign key (endereco_id)
			references enderecos(id);

alter table alunos_telefones
	add constraint fk_alunos_telefones_alunos
		foreign key (aluno_id)
			references alunos (id);

alter table alunos_telefones
	add constraint fk_alunos_telefones_telefones
		foreign key (telefone_id)
			references telefones (id);
