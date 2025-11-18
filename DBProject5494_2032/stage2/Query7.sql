
-- QUERY 7: Teacher Workload and Salary Efficiency Analysis
-- Complex analysis of teacher efficiency with date-based metrics
-- Used by: HR and management for compensation reviews
SELECT 
    p.id AS teacher_id,
    p.name AS teacher_name,
    t.salary AS monthly_salary,
    EXTRACT(YEAR FROM t.hire_date) AS hire_year,
    DATE_PART('year', AGE(CURRENT_DATE, t.hire_date)) AS years_employed,
    COUNT(DISTINCT g.id) AS groups_teaching,
    SUM(g.current_amount) AS total_students,
    ROUND(SUM(sc.cost * g.current_amount), 2) AS revenue_generated,
    ROUND(SUM(sc.cost * g.current_amount) / t.salary, 2) AS revenue_to_salary_ratio,
    ROUND(t.salary / NULLIF(SUM(g.current_amount), 0), 2) AS cost_per_student,
    STRING_AGG(DISTINCT g.day_in_the_week, ', ' ORDER BY g.day_in_the_week) AS teaching_days
FROM teacher t
JOIN person p ON t.id = p.id
JOIN group_of_sports g ON t.id = g.teacher_id
JOIN sports_class sc ON g.sports_class_id = sc.id
WHERE g.current_amount > 0
GROUP BY p.id, p.name, t.salary, t.hire_date
HAVING COUNT(DISTINCT g.id) >= 1
ORDER BY revenue_to_salary_ratio DESC, years_employed DESC;