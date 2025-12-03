-- Query 1: Total Class Revenue Analysis by Sport Class
-- Business Logic: Management needs to track total current revenue to understand financial performance
SELECT 
    sc.name AS class_name,
    COUNT(DISTINCT pi.student_id) AS total_students,
    sc.cost AS class_cost,
    COUNT(DISTINCT pi.student_id) * sc.cost AS total_class_revenue
FROM sports_class sc
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
INNER JOIN participate_in pi ON g.id = pi.group_id
GROUP BY sc.id, sc.name, sc.cost
HAVING COUNT(DISTINCT pi.student_id) >= 1
ORDER BY total_class_revenue DESC;


-- Query 1: Total Class Revenue Analysis by Group Sport Class
-- Business Logic: Management needs to track total current revenue to understand financial performance

SELECT 
    sc.name AS class_name,
    g.id AS group_id,
    COUNT(DISTINCT pi.student_id) AS students_in_group,
    sc.cost AS class_cost,
    COUNT(DISTINCT pi.student_id) * sc.cost AS group_revenue
FROM sports_class sc
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
INNER JOIN participate_in pi ON g.id = pi.group_id
GROUP BY sc.id, sc.name, g.id, sc.cost
HAVING COUNT(DISTINCT pi.student_id) >= 1
ORDER BY sc.name, group_revenue DESC;
