--Questão 01 
--Casos com nome do cliente, o setor jurídico precisa gerar um relatório básico contendo todos os casos
--cadastrados no sistema e o respectivo cliente responsável por cada caso.
--Liste: número do caso, descrição, data de abertura, nome do cliente

SELECT 
	numero as numero_caso,
	descricao,
	data_abertura,
	nome as nome_cliente
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
	d.id as id_documento,
	d.data as data_documento,
	td.nome as tipo_documento,
	d.conteudo
FROM documentos d

LEFT JOIN tipos_documentos td ON
	td.id = d.tipo_documento_id

--Questão 03) Pessoas envolvidas nos casos
--O departamento de investigação precisa consultar quais pessoas estão vinculadas 
--a cada caso e qual papel elas exercem dentro da investigação. 
--Liste: número do caso, nome da pessoa, papel desempenhado

SELECT 
	c.numero as numero_caso,
	p.nome as nome_pessoa,
	pp.nome as papel_desempenhado
FROM casos_pessoas cp

LEFT JOIN casos c ON
	c.numero = cp.caso_id 

LEFT JOIN pessoas p ON
	p.id = cp.pessoa_id

LEFT JOIN papeis pp ON
	pp.id = cp.papel_id 

--Questão 04) Quantidade de documentos por caso
--A coordenação jurídica deseja identificar os casos com maior volume documental para priorizar processos mais complexos.
--Exiba: o número do caso e a quantidade total de documentos vinculados.
--Ordene do maior para o menor volume documental

SELECT 
	numero as numero_caso,
	count(descricao) as quantidade_total_documentos_vinculados
	
FROM documentos d

LEFT JOIN casos c ON
	c.numero = d.caso_id

GROUP BY
	numero

ORDER BY numero

--Questão 05) Eventos e seus tipos
--O time operacional deseja acompanhar os eventos registrados em cada caso juntamente com sua classificação. 
--Liste: ID do evento, data, descrição, tipo do evento

SELECT 
	e.id as id_evento,
	e.data,
	e.descricao as descricao_evento,
	te.nome as tipo_evento
FROM eventos e

LEFT JOIN tipos_eventos te ON
	te.id = e.tipo_evento_id
