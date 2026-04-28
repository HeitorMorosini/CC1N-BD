


ALTER TABLE casos
RENAME COLUMN numero TO id;

alter table tipos_eventos
drop column descricao;

ALTER TABLE clientes 
ADD primeiro_nome VARCHAR(50);
ADD sobrenome VARCHAR(50);


UPDATE clientes
	SET primeiro_nome = split_part(nome, ' ', 1),
    sobrenome = substring(nome FROM position(' ' IN nome) + 1);



create table estados(
	id serial NOT NULL,
	sigla varchar(2) UNIQUE NOT NULL,
	constraint estados_pk primary key (id)
);

insert into estados(sigla)
select distinct estado
from pessoas
where estado is not null;

ALTER TABLE pessoas
ADD COLUMN estado_id INTEGER;

UPDATE pessoas p
SET estado_id = e.id
FROM estados e 
WHERE p.estado = e.sigla;

ALTER TABLE pessoas
ADD CONSTRAINT fk_pessoas_estado
FOREIGN KEY (estado_id)
REFERENCES estados(id);

ALTER TABLE pessoas DROP COLUMN estado;


select * from documentos

	