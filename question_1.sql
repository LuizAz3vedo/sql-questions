-- a. Consulta para obter, por nome da escola e por dia, a quantidade de alunos matriculados
-- e o valor total das matrículas, para cursos que começam com "data".
-- Ordenado do dia mais recente para o mais antigo.

SELECT 
    s.name AS school_name,
    stu.enrolled_at AS day,
    COUNT(stu.id) AS students_count,
    SUM(c.price) AS total_revenue
FROM 
    students stu
JOIN 
    courses c ON stu.course_id = c.id
JOIN 
    schools s ON c.school_id = s.id
WHERE 
    c.name LIKE 'data%'
GROUP BY 
    s.name, stu.enrolled_at
ORDER BY 
    stu.enrolled_at DESC;



---------------------------------------------------

-- b. Consulta para obter, por escola e por dia, a soma acumulada, a média móvel 7 dias
-- e a média móvel 30 dias da quantidade de alunos.

WITH daily_enrollments AS (
    SELECT 
        s.name AS school_name,
        stu.enrolled_at AS day,
        COUNT(stu.id) AS students_count
    FROM 
        students stu
    JOIN 
        courses c ON stu.course_id = c.id
    JOIN 
        schools s ON c.school_id = s.id
    WHERE 
        c.name LIKE 'data%'
    GROUP BY 
        s.name, stu.enrolled_at
    ORDER BY 
        s.name, stu.enrolled_at
)
SELECT 
    school_name,
    day,
    students_count,
    SUM(students_count) OVER (
        PARTITION BY school_name 
        ORDER BY day
    ) AS cumulative_sum,
    AVG(students_count) OVER (
        PARTITION BY school_name 
        ORDER BY day 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_days,
    AVG(students_count) OVER (
        PARTITION BY school_name 
        ORDER BY day 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS moving_avg_30_days
FROM 
    daily_enrollments
ORDER BY 
    school_name, day DESC;
