-- QUERY 5: Weekly Schedule Optimizer with Capacity Analysis
-- Shows class distribution across week with occupancy rates
-- Used by: Scheduling team and facility managers
SELECT 
    g.day_in_the_week,
    CASE 
        WHEN g.day_in_the_week IN ('Sunday', 'Monday') THEN 1
        WHEN g.day_in_the_week IN ('Tuesday', 'Wednesday') THEN 2
        ELSE 3
    END AS week_segment,
    g.start_time,
    sc.name AS class_name,
    g.level,
    g.current_amount AS enrolled_students,
    ROUND((g.current_amount::NUMERIC / sc.capacity) * 100, 2) AS occupancy_percentage,
    g.status,
    p.name AS teacher_name,
    l.location_name,
    l.city,
    sc.duration AS duration_minutes
FROM group_of_sports g
JOIN sports_class sc ON g.sports_class_id = sc.id
JOIN teacher t ON g.teacher_id = t.id
JOIN person p ON t.id = p.id
JOIN location l ON sc.location_id = l.id
WHERE g.current_amount >= 5
ORDER BY 
    CASE g.day_in_the_week
        WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
    END,
    g.start_time;