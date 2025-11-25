-- QUERY 1: Active Classes with Student Participation Analysis
-- Shows detailed class information with enrollment statistics and date breakdowns
-- Used by: Academic coordinators to monitor class performance
SELECT 
    sc.id AS class_id,
    sc.name AS class_name,
    sc.capacity AS max_capacity,
    sc.cost AS class_fee,
    sc.duration AS duration_minutes,
    l.location_name,
    l.city,
    COUNT(DISTINCT g.id) AS number_of_groups,
    SUM(g.current_amount) AS total_students_enrolled,
    ROUND((SUM(g.current_amount)::NUMERIC / (COUNT(DISTINCT g.id) * sc.capacity)) * 100, 2) AS overall_occupancy_rate,
    STRING_AGG(DISTINCT g.day_in_the_week, ', ' ORDER BY g.day_in_the_week) AS days_offered,
    STRING_AGG(DISTINCT g.level, ', ' ORDER BY g.level) AS levels_available,
    ROUND(SUM(sc.cost * g.current_amount), 2) AS total_class_revenue
FROM sports_class sc
JOIN location l ON sc.location_id = l.id
JOIN group_of_sports g ON sc.id = g.sports_class_id
JOIN participate_in pi ON g.id = pi.group_id
JOIN student s ON pi.student_id = s.id
JOIN person p ON s.id = p.id
WHERE g.status = 'ACTIVE'
GROUP BY sc.id, sc.name, sc.capacity, sc.cost, sc.duration, l.location_name, l.city
HAVING COUNT(DISTINCT g.id) >= 2
ORDER BY total_students_enrolled DESC, total_class_revenue DESC;