-- Update Query 4: Decrease sports class cost for classes with low enrollment to attract more students
-- Business Logic: Reduce pricing for underperforming classes to increase competitiveness
UPDATE sports_class
SET cost = ROUND(cost * 0.85, 2)
WHERE id IN (
    SELECT sc.id
    FROM sports_class sc
    INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
    WHERE g.current_amount > 0
    GROUP BY sc.id, sc.capacity
    HAVING AVG(g.current_amount) < sc.capacity * 0.5
    AND COUNT(DISTINCT g.id) >= 2
);



-- Preview Query for Update 4: Show classes whose cost will be reduced to boost enrollment
SELECT 
    sc.id AS class_id,
    sc.name AS class_name,
    sc.cost AS current_cost,
    ROUND(sc.cost * 0.85, 2) AS new_cost_after_update,
    ROUND(sc.cost * 0.15, 2) AS discount_amount,
    ROUND(((sc.cost * 0.85 - sc.cost) / sc.cost) * 100, 2) AS discount_percentage,
    sc.capacity AS max_capacity,
    COUNT(DISTINCT g.id) AS number_of_groups,
    SUM(g.current_amount) AS total_enrolled_students,
    ROUND((AVG(g.current_amount) / sc.capacity) * 100, 2) AS avg_capacity_percentage,
    l.location_name,
    l.city
FROM sports_class sc
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
INNER JOIN location l ON sc.location_id = l.id
WHERE g.current_amount > 0
GROUP BY sc.id, sc.name, sc.cost, sc.capacity, l.location_name, l.city
HAVING AVG(g.current_amount) < sc.capacity * 0.5
AND COUNT(DISTINCT g.id) >= 2
ORDER BY avg_capacity_percentage ASC, total_enrolled_students ASC;
