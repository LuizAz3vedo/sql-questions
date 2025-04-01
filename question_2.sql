-- Consulta para mostrar estatísticas do departamento: nome, contagem de funcionários, salários médios/máximos/mínimos
-- Ordenado pelo maior salário médio

SELECT 
    d.nome AS "Department",
    COUNT(DISTINCT e.matr) AS "Number of Employees",
    ROUND(COALESCE(AVG(v.valor), 0), 2) AS "Average Salary",
    COALESCE(MAX(v.valor), 0) AS "Maximum Salary",
    COALESCE(MIN(v.valor), 0) AS "Minimum Salary"
FROM 
    departamento d
LEFT JOIN 
    empregado e ON e.lotacao = d.cod_dep
LEFT JOIN 
    emp_venc ev ON e.matr = ev.matr
LEFT JOIN 
    vencimento v ON ev.cod_venc = v.cod_venc
GROUP BY 
    d.nome
ORDER BY 
    "Average Salary" DESC;
