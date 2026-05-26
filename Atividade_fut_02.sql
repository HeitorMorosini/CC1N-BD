--Questão 01

SELECT 
	e.clube,
	SUM(e.cartao_amarelo + e.cartao_vermelho) AS total_cartoes,
	COUNT(*) AS quantidade_vitorias
FROM estatisticas e 
LEFT JOIN jogos j ON
	e.partida_id = j.id
WHERE e.clube = j.vencedor
AND j.vencedor != '-'
GROUP BY e.clube
ORDER BY total_cartoes DESC;


--Questão 02 



--Questão 03

SELECT 
	atleta,
	clube,
	COUNT(*) AS quantidade_gols_contra
FROM gols
WHERE tipo_de_gol = 'Gol Contra'
GROUP BY 
	atleta,
	clube
HAVING COUNT (*) = (
	SELECT MAX(total)
	FROM (SELECT COUNT (*) AS total
	FROM gols 
	WHERE tipo_de_gol = 'Gol Contra' 
	GROUP BY atleta) AS sub);


--Questão 04 

WITH mandantes_vencedores AS (
	SELECT 
	e.clube,
	e.escanteios
	FROM estatisticas e
	JOIN jogos j ON
		e.partida_id = j.id
	WHERE j.mandante = j.vencedor
	AND e.clube = j.mandante
)
SELECT 
	clube,
	ROUND(AVG(escanteios), 2) AS media_escanteio,
	COUNT(*) AS quantidade_vitoria
FROM mandantes_vencedores
GROUP BY 
	clube
HAVING AVG(escanteios) > (SELECT AVG(escanteios)
	FROM mandantes_vencedores)
ORDER BY 
	media_escanteio DESC;


--Questão 05

SELECT 
	tecnico, 
	SUM(vitorias) AS total_vitorias
FROM (
    SELECT 
		tecnico_mandante AS tecnico, 
		COUNT(*) AS vitorias
    FROM jogos
    WHERE vencedor = mandante 
	AND tecnico_mandante != ''
    GROUP BY tecnico_mandante
    UNION ALL
    
    SELECT 
		tecnico_visitante AS tecnico, 
		COUNT(*) AS vitorias
    FROM jogos
    WHERE vencedor = visitante 
	AND tecnico_visitante != ''
    GROUP BY tecnico_visitante
) AS consolidado
GROUP BY tecnico
ORDER BY total_vitorias DESC;


--Questão 06

SELECT 
    j.mandante, 
    j.visitante, 
    em.posse_de_bola AS posse_mandante, 
    ev.posse_de_bola AS posse_visitante, 
    j.vencedor,
    ABS(CAST(REPLACE(em.posse_de_bola, '%', '') AS INT) - CAST(REPLACE(ev.posse_de_bola, '%', '') AS INT)) AS diferenca_percentual
FROM jogos j
LEFT JOIN estatisticas em ON 
	j.id = em.partida_id 
	AND j.mandante = em.clube
LEFT JOIN estatisticas ev ON 
	j.id = ev.partida_id 
	AND j.visitante = ev.clube
WHERE 
    em.posse_de_bola NOT IN ('None', '') 
	AND ev.posse_de_bola NOT IN ('None', '')
    AND (
        (CAST(REPLACE(em.posse_de_bola, '%', '') AS INT) > CAST(REPLACE(ev.posse_de_bola, '%', '') AS INT) AND j.vencedor = j.visitante)
        OR 
        (CAST(REPLACE(ev.posse_de_bola, '%', '') AS INT) > CAST(REPLACE(em.posse_de_bola, '%', '') AS INT) AND j.vencedor = j.mandante)
    )
ORDER BY diferenca_percentual DESC;


--Questão 07

WITH TotalCartoesPartida AS (
    SELECT 
        partida_id, 
        COUNT(*) as total_cartoes,
        RANK() OVER (ORDER BY COUNT(*) DESC) as ranking
    FROM cartoes
    GROUP BY partida_id
)
SELECT 
    j.mandante, 
    j.visitante, 
    tcp.total_cartoes, 
    j.vencedor, 
    j.rodada
FROM jogos j
LEFT JOIN TotalCartoesPartida tcp ON 
	j.id = tcp.partida_id
WHERE tcp.ranking <= 5
ORDER BY 
	tcp.total_cartoes DESC;


--Questão 08

SELECT 
    j.vencedor AS clube_vencedor, 
    CASE WHEN j.vencedor = j.mandante THEN j.visitante ELSE j.mandante END AS adversario,
    j.mandante_placar || ' x ' || j.visitante_placar AS placar,
    COUNT(c.id) AS total_vermelhos_vencedor,
    j.rodada
FROM jogos j
LEFT JOIN cartoes c ON 
	j.id = c.partida_id 
	AND j.vencedor = c.clube
WHERE c.cartao = 'Vermelho' 
AND j.vencedor != '-'
GROUP BY 
	j.id, 
	j.vencedor, 
	j.mandante, 
	j.visitante, 
	j.mandante_placar, 
	j.visitante_placar, 
	j.rodada
ORDER BY 
	total_vermelhos_vencedor DESC;