-- Update Query 12: Increase salary for teachers managing more groups than average
-- Business Logic: Reward high-performing teachers with salary increases
UPDATE teacher
SET salary = salary * 1.15
WHERE id IN (
    SELECT t.id
    FROM teacher t
    INNER JOIN group_of_sports g ON t.id = g.teacher_id
    GROUP BY t.id
    HAVING COUNT(DISTINCT g.id) > (
        SELECT AVG(group_count)
        FROM (
            SELECT teacher_id, COUNT(DISTINCT id) AS group_count
            FROM group_of_sports
            GROUP BY teacher_id
        ) AS subquery
    )
)
AND EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hire_date) >= 2;


-- Preview Query for Update 12: Show teachers who will get salary increases
-- Shows current salary and what it will become after 15% increase
SELECT 
    p.id AS teacher_id,
    p.name AS teacher_name,
    t.salary AS current_salary,
    ROUND(t.salary * 1.15, 2) AS new_salary_after_increase,
    ROUND(t.salary * 0.15, 2) AS salary_increase_amount,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM t.hire_date) AS years_employed,
    COUNT(DISTINCT g.id) AS groups_managed,
    (
        SELECT AVG(group_count)
        FROM (
            SELECT teacher_id, COUNT(DISTINCT id) AS group_count
            FROM group_of_sports
            GROUP BY teacher_id
        ) AS subquery
    ) AS avg_groups_across_all_teachers
FROM person p
INNER JOIN teacher t ON p.id = t.id
INNER JOIN group_of_sports g ON t.id = g.teacher_id
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM t.hire_date) >= 2
GROUP BY p.id, p.name, t.salary, t.hire_date
HAVING COUNT(DISTINCT g.id) > (
    SELECT AVG(group_count)
    FROM (
        SELECT teacher_id, COUNT(DISTINCT id) AS group_count
        FROM group_of_sports
        GROUP BY teacher_id
    ) AS subquery
)
ORDER BY groups_managed DESC, current_salary DESC;
