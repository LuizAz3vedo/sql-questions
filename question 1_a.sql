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
