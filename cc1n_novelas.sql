create table emissoras(
	id serial,
	nome varchar(100) not null,
	constraint pk_emissoras primary key(id),
	cnpj char(14) not null,
	constraint un_emissoras_cnpj unique (cnpj),
	telefone varchar (14)
);

create table novelas(
	id serial, 
	nome varchar(100) not null,
	resumo text not null, 
	emissora_id int not null,
	constraint pk_novelas primary key(id),
	constraint fk_novelas_emissoras
		foreign key (emissora_id)
			references emissoras (id)
);

create table atores (
	id serial,
	cpf char(11) not null,
	nome varchar(100) not null, 
	novela_id int not null,
	data_atuacao date,
	constraint pk_atores primary key(id),
	constraint fk_atores_novelas 
		foreign key (novela_id)
			references novelas(id)
);

alter table atores
	add constraint un_atores_cpf unique (cpf);
	
alter table emissoras
	add column emissora_matriz int null,
	add constraint fk_emissoras_filiais	
		foreign key (emissora_matriz)
			references emissoras (id);

alter table emissoras
	rename constraint fk_emissoras_filiais 
		to fk_emissoras_matriz;

alter table atores
	add column telefone varchar(14) null;

