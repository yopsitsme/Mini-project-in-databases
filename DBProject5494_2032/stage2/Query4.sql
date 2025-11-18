-- QUERY 4: Equipment Utilization and Needs Assessment
-- Complex query joining equipment needs across classes
-- Used by: Operations team for inventory management
SELECT 
    e.id AS equipment_id,
    e.name AS equipment_name,
    e.amount AS current_stock,
    COUNT(DISTINCT n.sports_class_id) AS classes_requiring,
    SUM(n.quantity_required) AS total_quantity_needed,
    e.amount - SUM(n.quantity_required) AS surplus_or_deficit,
    CASE 
        WHEN e.amount < SUM(n.quantity_required) THEN 'URGENT: Order Needed'
        WHEN e.amount < SUM(n.quantity_required) * 1.2 THEN 'WARNING: Low Stock'
        ELSE 'Sufficient Stock'
    END AS stock_status,
    STRING_AGG(DISTINCT sc.name, ', ' ORDER BY sc.name) AS classes_using
FROM equipment e
JOIN needs n ON e.id = n.equipment_id
JOIN sports_class sc ON n.sports_class_id = sc.id
GROUP BY e.id, e.name, e.amount
HAVING SUM(n.quantity_required) > 20
ORDER BY (e.amount - SUM(n.quantity_required)) ASC, total_quantity_needed DESC;