--QUESTÃO 2

SELECT DISTINCT
	"Posicao",
	"Time"

FROM data_camp_brasileiro
WHERE "Posicao" = '1'

--QUESTÃO 3

SELECT DISTINCT
	"Time"

FROM data_camp_brasileiro


--QUESTÃO 4

SELECT "Time", COUNT(*) AS vezes_vice
FROM data_camp_brasileiro
WHERE "Posicao" = 2
GROUP BY "Time"
ORDER BY vezes_vice DESC
LIMIT 1;



--QUESTÃO 5

SELECT * 
FROM data_camp_brasileiro
WHERE "Posicao" <= 4
AND "Pontos" = 65
AND "Vitoria" = 18
AND "Derrotas" = 9


Qual clube brasileiro teve aproveitamento de 50%
e ficou com melhor colocado em uma edição do campeonato brasileiro.

--QUESTÃO 6 

SELECT DISTINCT
	"ANO",
	"Time",
	"Posicao",
	"Aproveitamento"
FROM data_camp_brasileiro
WHERE "Aproveitamento" >= 50
AND "Posicao"
ORDER BY "ANO"

select * from data_camp_brasileiro