-- =====================================================
-- DELETE QUERY 9: Remove Equipment Not Required by Any Sports Class
-- =====================================================
-- Complex logic: Delete equipment that has NO class requesting it in the needs table
-- Analyzes equipment across all active classes and their groups to determine
-- if the equipment is truly unused in the current program offerings
-- 
-- Used by: Inventory manager during equipment audit
-- Business value: Clean up unused equipment inventory regardless of quantity or value

DELETE FROM equipment
WHERE id IN (
    SELECT e.id
    FROM equipment e
    WHERE 
        -- Equipment is not linked to any sports class in the needs table
        NOT EXISTS (
            SELECT 1
            FROM needs n
            WHERE n.equipment_id = e.id
        )
        -- Additional verification: ensure no indirect usage through active groups
        AND e.id NOT IN (
            SELECT DISTINCT n2.equipment_id
            FROM needs n2
            JOIN sports_class sc ON n2.sports_class_id = sc.id
            JOIN group_of_sports g ON g.sports_class_id = sc.id
            WHERE g.current_amount > 0  -- At least one active group uses this equipment
        )
    ORDER BY e.id
);