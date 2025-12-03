-- Query 3: Student Age Distribution and Class Enrollment Patterns
-- Business Logic: Analyze which age groups enroll in which classes for marketing targeting
SELECT 
    sc.name AS class_name,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.birth_date) AS student_age,
    COUNT(DISTINCT s.id) AS students_in_age_group,
    g.level,
    g.day_in_the_week,
    sc.cost
FROM person p
INNER JOIN student s ON p.id = s.id
INNER JOIN participate_in pi ON s.id = pi.student_id
INNER JOIN group_of_sports g ON pi.group_id = g.id
INNER JOIN sports_class sc ON g.sports_class_id = sc.id
GROUP BY sc.name, EXTRACT(YEAR FROM p.birth_date), g.level, 
         g.day_in_the_week, sc.cost
ORDER BY student_age, students_in_age_group DESC;