-- Query 6: Location Utilization and Capacity Analysis
-- Business Logic: Determine which locations are underutilized or overbooked
SELECT 
    l.location_name,
    l.city,
    l.capacity AS location_capacity,
    COUNT(DISTINCT sc.id) AS classes_offered,
    COUNT(DISTINCT g.id) AS total_groups,
    SUM(g.current_amount) AS total_students,
    CASE 
        WHEN SUM(g.current_amount) > l.capacity * 0.8 THEN 'Near Capacity'
        WHEN SUM(g.current_amount) < l.capacity * 0.4 THEN 'Underutilized'
        ELSE 'Optimal'
    END AS utilization_status
FROM location l
LEFT OUTER JOIN sports_class sc ON l.id = sc.location_id
INNER JOIN group_of_sports g ON sc.id = g.sports_class_id  
GROUP BY l.id, l.location_name, l.city, l.capacity
ORDER BY total_students DESC;