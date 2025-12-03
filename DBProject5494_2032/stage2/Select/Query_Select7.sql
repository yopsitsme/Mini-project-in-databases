-- Query 7: Weekly Schedule Analysis
-- Business Logic: Identify busiest days for staffing and resource allocation
SELECT 
    g.day_in_the_week,
    EXTRACT(HOUR FROM g.start_time) AS start_hour,
    COUNT(DISTINCT g.id) AS groups_at_time,
    COUNT(DISTINCT pi.student_id) AS total_students,
    STRING_AGG(DISTINCT sc.name, ', ') AS classes_offered
	FROM group_of_sports g
INNER JOIN participate_in pi ON g.id = pi.group_id
INNER JOIN sports_class sc ON g.sports_class_id = sc.id
WHERE g.status = 'ACTIVE'  
GROUP BY g.day_in_the_week, EXTRACT(HOUR FROM g.start_time)
ORDER BY day_in_the_week DESC, total_students DESC, groups_at_time DESC;