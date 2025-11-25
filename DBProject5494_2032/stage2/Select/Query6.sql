-- QUERY 6: Student Engagement and Cross-Class Participation Analysis
-- Advanced analysis of student behavior patterns with temporal and demographic insights
-- Used by: Marketing team and student services for retention strategies and personalized recommendations
SELECT 
    age_segment.age_category,
    age_segment.enrollment_level,
    COUNT(DISTINCT age_segment.student_id) AS students_in_category,
    ROUND(SUM(age_segment.total_investment), 2) AS total_category_revenue,
    STRING_AGG(DISTINCT age_segment.most_popular_class, ', ' ORDER BY age_segment.most_popular_class) AS popular_classes,
    COUNT(DISTINCT age_segment.student_city) AS cities_represented,
    ROUND(
        (COUNT(DISTINCT CASE WHEN age_segment.classes_enrolled >= 2 THEN age_segment.student_id END)::NUMERIC 
        / NULLIF(COUNT(DISTINCT age_segment.student_id), 0)) * 100, 
        2
    ) AS multi_class_engagement_rate
FROM (
    SELECT 
        s.id AS student_id,
        p.name AS student_name,
        SUBSTRING(s.addres FROM '([^,]+)$') AS student_city,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) AS age_in_years,
        EXTRACT(MONTH FROM p.birth_date) AS birth_month,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) BETWEEN 5 AND 9 THEN 'Elementary (5-9)'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) BETWEEN 10 AND 13 THEN 'Middle School (10-13)'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) BETWEEN 14 AND 17 THEN 'High School (14-17)'
            ELSE 'Young Adult (18+)'
        END AS age_category,
        CASE 
            WHEN COUNT(DISTINCT pi.group_id) = 1 THEN 'Single Class'
            WHEN COUNT(DISTINCT pi.group_id) = 2 THEN 'Dual Enrollment'
            ELSE 'Multi-Class Champion'
        END AS enrollment_level,
        COUNT(DISTINCT pi.group_id) AS classes_enrolled,
        COUNT(DISTINCT sc.id) AS unique_sports,
        SUM(sc.cost) AS total_investment,
        (
            SELECT sc2.name 
            FROM participate_in pi2
            JOIN group_of_sports g2 ON pi2.group_id = g2.id
            JOIN sports_class sc2 ON g2.sports_class_id = sc2.id
            WHERE pi2.student_id = s.id
            GROUP BY sc2.name
            ORDER BY COUNT(*) DESC
            LIMIT 1
        ) AS most_popular_class,
        STRING_AGG(DISTINCT g.day_in_the_week, ',' ORDER BY g.day_in_the_week) AS attendance_days
    FROM student s
    JOIN person p ON s.id = p.id
    JOIN participate_in pi ON s.id = pi.student_id
    JOIN group_of_sports g ON pi.group_id = g.id
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.status IN ('ACTIVE', 'FULL')
    GROUP BY s.id, p.name, s.addres, p.birth_date
) AS age_segment
GROUP BY age_segment.age_category, age_segment.enrollment_level
HAVING COUNT(DISTINCT age_segment.student_id) >= 3
ORDER BY 
    CASE age_segment.age_category
        WHEN 'Elementary (5-9)' THEN 1
        WHEN 'Middle School (10-13)' THEN 2
        WHEN 'High School (14-17)' THEN 3
        ELSE 4
    END,
    total_category_revenue DESC;