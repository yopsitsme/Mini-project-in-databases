-- =====================================================
-- DELETE QUERIES (3 queries)
-- =====================================================

-- DELETE QUERY 1: Remove Empty Pending Groups Older Than 6 Months
-- Cleans up groups that never reached minimum capacity
-- Used by: System maintenance/data cleanup process
DELETE FROM group_of_sports
WHERE id IN (
    SELECT g.id
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    JOIN teacher t ON g.teacher_id = t.id
    WHERE g.status = 'PENDING'
    AND g.current_amount < 5
    AND EXTRACT(MONTH FROM AGE(CURRENT_DATE, t.hire_date)) > 6
    AND NOT EXISTS (
        SELECT 1 
        FROM participate_in pi 
        WHERE pi.group_id = g.id
    )
);