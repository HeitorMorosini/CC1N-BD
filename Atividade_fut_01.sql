--QUESTÃO 1
--Quantos Clubes Brasileiros diferentes participaram da primeira divisão do campeonato brasileiro?

SELECT DISTINCT "Posicao", "Time"
FROM data_camp_brasileiro
WHERE "Posicao" = '1'

	
	
--QUESTÃO 2
--Quais clubes brasileiros participaram em todas as 10 últimas edições do campeonato brasileiro?
	
SELECT DISTINCT "Time"
FROM data_camp_brasileiro


	
--QUESTÃO 3
--Qual clube brasileiro foi mais vezes vice-campeão brasileiro neste período de 2009 a 2018?
	
SELECT "Time", COUNT(*) AS vezes_vice
FROM data_camp_brasileiro
WHERE "Posicao" = 2
GROUP BY "Time"
ORDER BY vezes_vice DESC
LIMIT 1;



--QUESTÃO 4
--Qual/quais time(s) ficaram entre os 4 primeiros colocados, tendo 65 pontos, contabilizando 18 vitórias e apenas 9 derrotas?

SELECT * 
FROM data_camp_brasileiro
WHERE "Posicao" <= 4
AND "Pontos" = 65
AND "Vitoria" = 18
AND "Derrotas" = 9



--QUESTÃO 5 
--Qual clube brasileiro teve aproveitamento de 50% e ficou com melhor colocado em uma edição do campeonato brasileiro.

SELECT *
FROM data_camp_brasileiro
WHERE "Aproveitamento" = 50
ORDER BY "Posicao" ASC
LIMIT 1;



--QUESTÃO 6
--Quantos gols o VASCÃO fez em todas as edições do campeonato que participou?

SELECT "Time", SUM("Gols pro") AS saldo_total
FROM data_camp_brasileiro
WHERE "Time" = 'Vasco'
GROUP BY "Time";


--QUESTÃO 7 e 8
--Qual clube brasileiro foi campeão com o maior saldo de gols tomados de todas as 10 edições do campeonato.

SELECT "Time", "ANO", "Saldo Gols"
FROM data_camp_brasileiro
WHERE "Posicao" = 1
ORDER BY
	CAST(REPLACE("Saldo Gols", '-', '-') AS int) DESC
LIMIT 1;



--QUESTÃO 9 
--Quantos gols o Cruzeiro sofreu em todas as edições do campeonato que participou?

SELECT "Time", SUM("Gols Contra") AS total_gols_sofridos
FROM data_camp_brasileiro
WHERE "Time" = 'Cruzeiro'
group by 
	"Time"


	
--QUESTÃO 10
--Qual é a média de gols feitos dos times do estado do Rio Grande do Sul no ano de 2014?

SELECT ROUND(AVG("Gols pro"), 1) AS media_gols_feitos
FROM  data_camp_brasileiro
WHERE "ANO" = 2014
  AND "Time" IN ('Grêmio', 'Internacional');



----QUESTÃO 11
--Qual é a média de gols feitos dos times do estado do Rio de Janeiro no ano de 2012?

SELECT ROUND(AVG("Gols pro"), 1) AS media_gols_feitos
FROM  data_camp_brasileiro
WHERE "ANO" = 2012
  AND "Time" IN ('Flamengo', 'Fluminense', 'Botafogo', 'Vasco');



--QUESTÃO 12
--Qual é o recorde de derrotas de um time em uma das edições do campeonato brasileiro. Informe o time, ano e a quantidade de derrotas?

SELECT "Time",  "ANO", "Derrotas"
FROM  data_camp_brasileiro
ORDER BY "Derrotas" DESC
LIMIT 1

select * from data_camp_brasileiro
