SELECT
    al.nome_aluno AS nome_aluno,
    COUNT(f.cod_frequencia) AS frequencia_total
FROM
    aluno AS al
JOIN
    frequencia AS f ON al.matricula_aluno = f.matricula_aluno
JOIN
    assinatura AS a ON al.matricula_aluno = a.matricula_aluno
WHERE
    a.status_assinatura = 'Ativa'
GROUP BY
    al.nome_aluno
ORDER BY
    frequencia_total DESC
LIMIT 10;