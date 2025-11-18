-- QUERY 3: Student Enrollment History with Age Analysis
-- Shows students, their age groups, and participation patterns
-- Used by: Student services and marketing teams
SELECT 
    s.id AS student_id,
    p.name AS student_name,
    s.addres AS address,
    p.phone,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) AS current_age,
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, p.birth_date)) AS age_months,
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) < 8 THEN 'Young Kids (5-7)'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) < 13 THEN 'Pre-Teen (8-12)'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) < 18 THEN 'Teen (13-17)'
        ELSE 'Adult (18+)'
    END AS age_group,
    COUNT(DISTINCT pi.group_id) AS classes_enrolled,
    STRING_AGG(DISTINCT sc.name, ', ' ORDER BY sc.name) AS enrolled_classes,
    ROUND(SUM(sc.cost), 2) AS total_fees
FROM student s
JOIN person p ON s.id = p.id
JOIN participate_in pi ON s.id = pi.student_id
JOIN group_of_sports g ON pi.group_id = g.id
JOIN sports_class sc ON g.sports_class_id = sc.id
GROUP BY s.id, p.name, s.addres, p.phone, p.birth_date
HAVING COUNT(DISTINCT pi.group_id) >= 2
ORDER BY classes_enrolled DESC, current_age;
