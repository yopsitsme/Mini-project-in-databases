-- Query 8: Teacher Salary vs Workload Analysis
-- Business Logic: Evaluate if teacher compensation aligns with their workload
SELECT 
    p.name AS teacher_name,
    t.salary,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM t.hire_date) AS years_employed,
    COUNT(DISTINCT g.id) AS groups_managed,
    SUM(g.current_amount) AS total_students,
    t.salary / NULLIF(COUNT(DISTINCT g.id), 0) AS salary_per_group,
    t.salary / NULLIF(SUM(g.current_amount), 0) AS salary_per_student
FROM person p
INNER JOIN teacher t ON p.id = t.id
LEFT OUTER JOIN group_of_sports g ON t.id = g.teacher_id
GROUP BY p.id, p.name, t.salary, t.hire_date
HAVING COUNT(DISTINCT g.id) > 0
ORDER BY teacher_name , salary_per_student DESC;
