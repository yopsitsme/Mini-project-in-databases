-- Update Query 13: Increase equipment quantity based on high demand from active classes
-- Business Logic: Replenish equipment inventory when usage exceeds available stock
UPDATE equipment
SET amount = amount + (
    SELECT CEILING(SUM(n.quantity_required * 1.5))
    FROM needs n
    INNER JOIN sports_class sc ON n.sports_class_id = sc.id
    INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
    WHERE n.equipment_id = equipment.id
    AND g.status = 'ACTIVE'
    GROUP BY n.equipment_id
)
WHERE id IN (
    SELECT e.id
    FROM equipment e
    INNER JOIN needs n ON e.id = n.equipment_id
    INNER JOIN sports_class sc ON n.sports_class_id = sc.id
    INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
    WHERE g.status = 'ACTIVE'
    GROUP BY e.id
    HAVING SUM(n.quantity_required) > e.amount
);


-- -- Preview Query for Update 13: Show equipment that will be restocked
-- -- Shows current amount and what it will become after replenishment
SELECT 
    e.id AS equipment_id,
    e.name AS equipment_name,
    e.amount AS current_amount,
    SUM(n.quantity_required) AS total_required_by_active_classes,
    CEILING(SUM(n.quantity_required * 1.5)) AS quantity_to_add,
    e.amount + CEILING(SUM(n.quantity_required * 1.5)) AS new_amount_after_update,
    e.amount + CEILING(SUM(n.quantity_required * 1.5)) - e.amount AS increase_amount,
    COUNT(DISTINCT sc.id) AS classes_using_equipment,
    COUNT(DISTINCT g.id) AS active_groups_using_equipment,
    STRING_AGG(DISTINCT sc.name, ', ') AS class_names
FROM equipment e
INNER JOIN needs n ON e.id = n.equipment_id
INNER JOIN sports_class sc ON n.sports_class_id = sc.id
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id
WHERE g.status = 'ACTIVE'
GROUP BY e.id, e.name, e.amount
HAVING SUM(n.quantity_required) > e.amount
ORDER BY total_required_by_active_classes DESC, equipment_name;