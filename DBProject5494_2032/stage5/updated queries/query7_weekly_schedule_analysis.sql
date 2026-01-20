-- Query 7: Weekly Schedule Analysis
-- Business Logic: Identify busiest days for staffing and resource allocation
SELECT 
    gd.day_of_week,
    EXTRACT(HOUR FROM gd.start_time) AS start_hour,
    COUNT(DISTINCT g.groupid) AS groups_at_time,
    COUNT(DISTINCT pi.studentid) AS total_students,
    STRING_AGG(DISTINCT sc.name, ', ') AS classes_offered
FROM group_details gd
INNER JOIN group_of_sports g ON gd.group_id = g.groupid
INNER JOIN participate_in pi ON g.groupid = pi.groupid
INNER JOIN sports_class sc ON g.sports_class_id = sc.id
WHERE g.status = 'ACTIVE'  
GROUP BY gd.day_of_week, EXTRACT(HOUR FROM gd.start_time)
ORDER BY day_of_week DESC, total_students DESC, groups_at_time DESC;