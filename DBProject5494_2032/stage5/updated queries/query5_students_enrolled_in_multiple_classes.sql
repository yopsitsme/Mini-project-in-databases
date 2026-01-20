-- Query 5: Students Enrolled in Multiple Classes - Cross-Selling Opportunities
-- Business Logic: Identify students taking multiple classes for loyalty programs
SELECT 
    (p.first_name || ' ' || p.last_name) AS student_name,
    p.email,
    p.phone,
    s.addres,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.birth_date) AS age,
    COUNT(DISTINCT pi.groupid) AS classes_enrolled,
    SUM(sc.cost) AS total_fees
FROM person p
INNER JOIN student s ON p.personid = s.studentid
INNER JOIN participate_in pi ON s.studentid = pi.studentid
INNER JOIN group_of_sports g ON pi.groupid = g.groupid
INNER JOIN sports_class sc ON g.sports_class_id = sc.id
GROUP BY p.personid, p.first_name, p.last_name, p.email, p.phone, s.addres, p.birth_date
HAVING COUNT(DISTINCT pi.groupid) >= 2  -- Single-class students are excluded
ORDER BY classes_enrolled DESC, total_fees DESC;