-- Update Query 4: Decrease sports class cost for classes with low enrollment to attract more students
-- Business Logic: Reduce pricing for underperforming classes to increase competitiveness
-- ROLLBACK & COMMIT

BEGIN;

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


 -- ROLLBACK;
COMMIT;