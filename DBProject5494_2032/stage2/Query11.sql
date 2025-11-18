-- DELETE QUERY 3: Remove Duplicate Participations and Old Equipment Needs
-- Complex cleanup of orphaned records across multiple tables
-- Used by: System administrator during data integrity checks
DELETE FROM needs
WHERE (equipment_id, sports_class_id) IN (
    SELECT n.equipment_id, n.sports_class_id
    FROM needs n
    JOIN equipment e ON n.equipment_id = e.id
    JOIN sports_class sc ON n.sports_class_id = sc.id
    WHERE n.quantity_required > e.amount * 2
    AND NOT EXISTS (
        SELECT 1
        FROM group_of_sports g
        WHERE g.sports_class_id = sc.id
        AND g.current_amount >= 5
    )
    AND sc.capacity < 10
);
