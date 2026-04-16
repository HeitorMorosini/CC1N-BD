create table projetos(
	id serial,
	duracao smallint not null,
	descricao text not null,
	constraint pk_projetos primary key(id)
);

create table enderecos(
	id serial,
	rua varchar(100),
	bairro varchar(50),
	numero smallint,
	constraint pk_enderecos primary key (id)
);

create table enderecos_projetos(
	endereco_id int,
	projeto_id int,
	constraint pk_enderecos_projetos primary key (endereco_id, projeto_id),
	constraint fk_enderecos_endereco
		foreign key (endereco_id)
			references enderecos(id),
	constraint fk_enderecos_projetos
		foreign key (projeto_id)
			references projetos(id)
);

create table equipamentos(
	id serial,
	descricao text not null,
	projeto_id int null,
	constraint pk_equipamentos primary key (id),
	constraint fk_equipamentos_projeto
		foreign key (projeto_id)
			references projetos(id)
);

create table enderecos_engenheiros(
	engenheiro_id varchar(10),
	endereco_id int,
	constraint pk_enderecos_engenheiros 
		primary key (engenheiro_id, endereco_id)
);

create table engenheiros(
	crea varchar(10),
	nome varchar(100) not null,
	salario decimal(10,2) not null,
	constraint pk_engenheiros
		primary key (crea)
);

alter table enderecos_engenheiros
	add constraint fk_enderecos_engenheiros_engenheiros
		foreign key (engenheiro_id)
			references engenheiros(crea),
	add constraint fk_enderecos_engenheiros_enderecos
		foreign key (endereco_id)
			references enderecos(id)
;

create table telefone(
	id serial,
	ddd char(3) not null,
	numero char(11) not null,
	engenheiro_id varchar(10),
	constraint pk_telefone primary key (id),
	constraint fk_telefone_engenheiros
		foreign key (engenheiro_id)
			references engenheiros (crea)
);

create table atuacoes(
	engenheiro_id varchar(10),
	projeto_id int,
	funcao varchar(50) not null,
	qtd_horas smallint,
	constraint pk_atuacoes primary key (engenheiro_id, projeto_id),
	constraint fk_atuacoes_engenheiros
		foreign key (engenheiro_id)
			references engenheiros(crea),
	constraint fk_atuacoes_projetos
		foreign key (projeto_id)
			references projetos (id)
);