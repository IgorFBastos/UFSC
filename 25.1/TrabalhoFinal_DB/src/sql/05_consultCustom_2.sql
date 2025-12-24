SELECT
    i.nome_instrutor AS nome_instrutor,
    COUNT(DISTINCT a.cod_aula) AS total_aulas
FROM
    instrutor AS i
JOIN
    aula AS a ON i.cod_instrutor = a.cod_instrutor
JOIN
    inscricao_aula AS ia ON a.cod_aula = ia.cod_aula
GROUP BY
    i.nome_instrutor
ORDER BY
    total_aulas DESC;