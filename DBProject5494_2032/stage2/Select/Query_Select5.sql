-- Query 5: Students Enrolled in Multiple Classes - Cross-Selling Opportunities
-- Business Logic: Identify students taking multiple classes for loyalty programs
SELECT 
    p.name AS student_name,
    p.email,
    p.phone,
    s.addres,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.birth_date) AS age,
    COUNT(DISTINCT pi.group_id) AS classes_enrolled,
    SUM(sc.cost) AS total_fees
FROM person p
INNER JOIN student s ON p.id = s.id
INNER JOIN participate_in pi ON s.id = pi.student_id
INNER JOIN group_of_sports g ON pi.group_id = g.id
INNER JOIN sports_class sc ON g.sports_class_id = sc.id
GROUP BY p.id, p.name, p.email, p.phone, s.addres, p.birth_date
HAVING COUNT(DISTINCT pi.group_id) >= 2  --Single-class students are excluded.
ORDER BY classes_enrolled DESC, total_fees DESC;
