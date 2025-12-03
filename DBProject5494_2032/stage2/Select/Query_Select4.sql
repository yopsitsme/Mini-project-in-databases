-- Query 4: Equipment Shortage Analysis for Active Classes
-- Business Logic: Identify equipment shortages to prioritize purchasing decisions
SELECT 
    e.name AS equipment_name,
    sc.name AS class_name,
    n.quantity_required,
    e.amount AS total_available,
    COUNT(DISTINCT g.id) AS active_groups,
    n.quantity_required * COUNT(DISTINCT g.id) AS total_needed,
    e.amount - (n.quantity_required * COUNT(DISTINCT g.id)) AS shortage
FROM equipment e
INNER JOIN needs n ON e.id = n.equipment_id
INNER JOIN sports_class sc ON n.sports_class_id = sc.id
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
WHERE g.status = 'ACTIVE'  -- Use the status attribute instead
GROUP BY e.id, e.name, sc.name, n.quantity_required, e.amount
HAVING e.amount - (n.quantity_required * COUNT(DISTINCT g.id)) < 0
ORDER BY shortage ASC;
