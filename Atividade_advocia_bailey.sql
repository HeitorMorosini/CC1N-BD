--Questão 01 
--Casos com nome do cliente, o setor jurídico precisa gerar um relatório básico contendo todos os casos
--cadastrados no sistema e o respectivo cliente responsável por cada caso.
--Liste: número do caso, descrição, data de abertura, nome do cliente

SELECT 
	numero,
	descricao,
	data_abertura,
	nome
FROM casos c

LEFT JOIN casos_pessoas cp ON
	cp.caso_id = c.numero

LEFT JOIN pessoas p ON
	p.id = cp.pessoa_id


--Questão 02) Documentos com seus tipos
--A equipe de auditoria documental deseja visualizar todos os documentos registrados
-- no sistema juntamente com seus respectivos tipos documentais. 
--Liste: ID do documento,data do documento,tipo do documento,conteúdo

SELECT 
	d.id,
	d.data,
	td.nome as tipo_documento,
	d.conteudo
FROM documentos d

LEFT JOIN tipos_documentos td ON
	td.id = d.tipo_documento_id

--Questão 03) Pessoas envolvidas nos casos
--O departamento de investigação precisa consultar quais pessoas estão vinculadas 
--a cada caso e qual papel elas exercem dentro da investigação. 
--Liste: número do caso, nome da pessoa, papel desempenhado

SELECT * 
FROM casos c

LEFT JOIN casos_pessoas cp ON
	cp.caso_id = c.numero

LEFT JOIN pessoas p ON
	p.id = cp.pessoa_id