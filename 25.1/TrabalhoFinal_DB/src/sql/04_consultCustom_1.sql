
-- Objetivo: Mostrar quanto foi arrecadado por tipo de plano, para análise financeira e decisão de quais planos são mais rentáveis

SELECT
    p.nome_plano AS nome_plano,
    SUM(pg.valor_pago) AS receita_total
FROM
    plano AS p
JOIN
    assinatura AS a ON p.cod_plano = a.cod_plano
JOIN
    pagamento AS pg ON a.cod_assinatura = pg.cod_assinatura
WHERE
    pg.status_pagamento = 'Pago' 
GROUP BY
    p.nome_plano
ORDER BY
    receita_total DESC;