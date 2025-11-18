-- UPDATE QUERY 2: Rebalance Group Capacities Based on Demand and Age Requirements
-- Adjusts minimum age and updates status for underutilized groups
-- Used by: Operations manager for capacity optimization
UPDATE group_of_sports
SET 
    min_age = CASE 
        WHEN level = 'Beginner' THEN 5
        WHEN level = 'Intermediate' THEN 8
        ELSE 10
    END,
    status = CASE
        WHEN current_amount < 5 THEN 'PENDING'
        WHEN current_amount >= (SELECT capacity FROM sports_class WHERE id = sports_class_id) THEN 'FULL'
        ELSE 'ACTIVE'
    END
WHERE id IN (
    SELECT g.id
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    JOIN (
        SELECT 
            pi.group_id,
            AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date))) AS avg_student_age
        FROM participate_in pi
        JOIN student s ON pi.student_id = s.id
        JOIN person p ON s.id = p.id
        GROUP BY pi.group_id
    ) AS age_stats ON g.id = age_stats.group_id
    WHERE age_stats.avg_student_age < g.min_age + 2
    OR (g.current_amount < sc.capacity * 0.5 AND g.status != 'PENDING')
);