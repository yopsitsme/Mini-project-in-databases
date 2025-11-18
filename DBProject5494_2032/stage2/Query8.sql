-- QUERY 8: Comprehensive Location Performance Report with Nested Subqueries
-- Multi-level analysis of location performance with capacity and revenue metrics
-- Used by: Executive team for strategic planning
SELECT 
    l.id AS location_id,
    l.location_name,
    l.city,
    l.capacity AS facility_capacity,
    location_stats.total_classes,
    location_stats.total_active_groups,
    location_stats.total_students_enrolled,
    location_stats.avg_class_cost,
    location_stats.total_revenue,
    location_stats.avg_occupancy_rate,
    teacher_stats.unique_teachers,
    ROUND(location_stats.total_revenue / NULLIF(location_stats.total_classes, 0), 2) AS revenue_per_class,
    ROUND(location_stats.total_students_enrolled::NUMERIC / NULLIF(location_stats.total_active_groups, 0), 2) AS avg_students_per_group
FROM location l
JOIN (
    SELECT 
        sc.location_id,
        COUNT(DISTINCT sc.id) AS total_classes,
        COUNT(DISTINCT g.id) AS total_active_groups,
        SUM(g.current_amount) AS total_students_enrolled,
        ROUND(AVG(sc.cost), 2) AS avg_class_cost,
        ROUND(SUM(sc.cost * g.current_amount), 2) AS total_revenue,
        ROUND(AVG((g.current_amount::NUMERIC / sc.capacity) * 100), 2) AS avg_occupancy_rate
    FROM sports_class sc
    JOIN group_of_sports g ON sc.id = g.sports_class_id
    WHERE g.current_amount >= 5
    GROUP BY sc.location_id
) AS location_stats ON l.id = location_stats.location_id
JOIN (
    SELECT 
        sc.location_id,
        COUNT(DISTINCT g.teacher_id) AS unique_teachers
    FROM sports_class sc
    JOIN group_of_sports g ON sc.id = g.sports_class_id
    GROUP BY sc.location_id
) AS teacher_stats ON l.id = teacher_stats.location_id
WHERE location_stats.total_students_enrolled > 20
ORDER BY location_stats.total_revenue DESC, location_stats.total_students_enrolled DESC;
