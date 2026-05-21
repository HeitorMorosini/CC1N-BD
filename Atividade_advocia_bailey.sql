--Questão 01 
--Casos com nome do cliente, o setor jurídico precisa gerar um relatório básico contendo todos os casos
--cadastrados no sistema e o respectivo cliente responsável por cada caso.
--Liste: número do caso, descrição, data de abertura, nome do cliente

SELECT 
	numero AS numero_caso,
	descricao,
	data_abertura,
	nome AS nome_cliente
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
	d.id AS id_documento,
	d.data AS data_documento,
	td.nome AS tipo_documento,
	d.conteudo
FROM documentos d

LEFT JOIN tipos_documentos td ON
	td.id = d.tipo_documento_id

--Questão 03) Pessoas envolvidas nos casos
--O departamento de investigação precisa consultar quais pessoas estão vinculadas 
--a cada caso e qual papel elas exercem dentro da investigação. 
--Liste: número do caso, nome da pessoa, papel desempenhado

SELECT 
	c.numero AS numero_caso,
	p.nome AS nome_pessoa,
	pp.nome AS papel_desempenhado
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
	d.caso_id caso, 
	COUNT(1) qtd_documentos 
FROM documentos d
	
INNER JOIN casos c ON
	c.numero = d.caso_id
	
GROUP BY d.caso_id

ORDER BY qtd_documentos DESC;

--Questão 05) Eventos e seus tipos
--O time operacional deseja acompanhar os eventos registrados em cada caso juntamente com sua classificação. 
--Liste: ID do evento, data, descrição, tipo do evento

SELECT 
	e.id AS id_evento,
	e.data,
	e.descricao AS descricao_evento,
	te.nome AS tipo_evento
FROM eventos e

LEFT JOIN tipos_eventos te ON
	te.id = e.tipo_evento_id

--Questão 06) Casos filhos e seus casos pais
--Alguns casos possuem relação hierárquica com outros processos já existentes. A gerência deseja visualizar
--essa estrutura de dependência entre casos. 
--Liste: número do caso filho, número do caso pai, descrição do caso pai.

SELECT 
	f.numero num_filho,
	p.numero num_pai, 
	p.descricao 
FROM casos p

INNER JOIN casos f ON 
	f.caso_pai = p.numero;

--Questão 07) Quantidade de pessoas por caso
--A equipe de análise investigativa quer descobrir quais casos possuem maior número de pessoas envolvidas.
--Exiba: número do caso, descrição, total de pessoas vinculadas. Ordene do maior para o menor número de envolvidos.

SELECT 
	c.numero AS numero_caso,
	c.descricao,
	COUNT (cp.pessoa_id) AS total_pessoas_vinculadas 
FROM casos c

INNER JOIN casos_pessoas cp ON
	cp.caso_id = c.numero
	
GROUP BY
	numero,
	descricao

ORDER BY
	total_pessoas_vinculadas DESC

--Questão 08) Clientes com total de casos
--A diretoria deseja analisar quais clientes possuem maior quantidade de casos registrados no sistema. 
--Liste: código do cliente, nome do cliente, quantidade total de casos. Ordene do cliente com mais casos 
--para o com menos.




--Questão 09) Pessoas que participam de múltiplos casos
--A área de inteligência deseja identificar pessoas que aparecem em vários 
--casos diferentes, pois isso pode indicar recorrência investigativa.
--Liste: código da pessoa, nome, quantidade de casos em que participa. Mostre apenas pessoas que participam de
--mais de um caso.





--Questão 10) Casos sem documentos
--O controle de qualidade identificou que alguns casos podem ter
--sido cadastrados sem documentação associada.
--Liste: número do caso, descrição. Mostre apenas os casos que não possuem documentos vinculados. 




--Questão 11) Top 10 clientes com mais eventos
--A diretoria operacional deseja identificar os clientes com maior atividade operacional registrada no sistema.
--Exiba: nome do cliente, quantidade total de eventos associados aos seus casos. Mostre apenas os 10 clientes
--com mais eventos.




--Questão 12) Média de documentos por caso para cada cliente
--A gestão documental deseja analisar o comportamento documental dos clientes para
--entender quais possuem processos mais complexos. 
--Calcule: nome do cliente, média de documentos por caso. Ordene da maior média para a menor.




--Questão 13) Pessoa com maior participação em casos
--A equipe investigativa deseja descobrir qual pessoa aparece com maior frequência nos casos registrados. 
--Exiba: código da pessoa, nome, total de participações em casos. Mostre apenas a pessoa com maior número de 
--participações.




--Questão 14) Ranking de casos por quantidade de eventos
--O setor de monitoramento deseja gerar um ranking dos casos mais 
--movimentados do sistema com base na quantidade de eventos registrados. 
--Liste: número do caso, descrição, quantidade total de eventos, posição no ranking. 

SELECT 
	ROW_NUMBER() OVER (ORDER BY qtd_total_eventos DESC), 
	numero_caso,
	descricao,
	qtd_total_eventos
FROM (SELECT 
		caso_id AS numero_caso, 
		c.descricao,
		COUNT(1) qtd_total_eventos
	  FROM eventos e
	  
		INNER JOIN casos c ON
			c.numero = e.caso_id
		GROUP BY caso_id, c.descricao
		ORDER BY qtd_total_eventos DESC, numero_caso);

--Questão 15) Tempo entre abertura do caso e primeiro evento
--A diretoria deseja medir o tempo de resposta operacional após a abertura de um caso.
--Calcule: número do caso, data de abertura, data do primeiro evento registrado, quantidade de dias 
--entre a abertura e o primeiro evento. Ordene do maior tempo de espera para o menor.




--Questão 16) Casos com maior movimentação geral
--O setor de infraestrutura deseja identificar os casos mais pesados do sistema considerando 
--simultaneamente: quantidade de documentos, quantidade de eventos. Liste os 100 casos com maior movimentação geral.




--Questão 17) Pessoas recorrentes em casos do mesmo cliente
--A equipe de inteligência deseja identificar pessoas que aparecem repetidamente em casos pertencentes ao mesmo cliente.
--Liste: nome da pessoa, nome do cliente, quantidade de participações. 
--Mostre apenas ocorrências com mais de uma participação.

