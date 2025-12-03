-- Query 2: Teachers Managing Groups Above Average Student Capacity
-- Business Logic: Identify high-performing teachers who manage groups with more students than average
SELECT 
    p.name AS teacher_name,
    p.email AS teacher_email,
    COUNT(DISTINCT g.id) AS total_groups,
    SUM(g.current_amount) AS total_students_managed
FROM person p
INNER JOIN teacher t ON p.id = t.id
INNER JOIN group_of_sports g ON t.id = g.teacher_id
WHERE g.current_amount > (
    SELECT AVG(current_amount) 
    FROM group_of_sports
)
GROUP BY p.id, p.name, p.email
HAVING COUNT(DISTINCT g.id) >= 1
ORDER BY total_students_managed DESC;