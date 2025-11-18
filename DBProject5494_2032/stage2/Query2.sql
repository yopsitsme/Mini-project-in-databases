-- QUERY 2: Monthly Revenue Analysis by Location and Sport Type
-- Breaks down revenue by month, location city, and sport type
-- Used by: Financial team for budgeting and forecasting
SELECT 
    l.city,
    SUBSTRING(sc.name FROM '^[A-Za-z ]+') AS sport_type,
    EXTRACT(MONTH FROM t.hire_date) AS enrollment_month,
    CASE 
        WHEN EXTRACT(MONTH FROM t.hire_date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN EXTRACT(MONTH FROM t.hire_date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN EXTRACT(MONTH FROM t.hire_date) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS quarter,
    COUNT(DISTINCT g.id) AS active_groups,
    SUM(g.current_amount) AS total_enrollments,
    ROUND(AVG(sc.cost), 2) AS avg_class_cost,
    ROUND(SUM(sc.cost * g.current_amount), 2) AS projected_revenue
FROM location l
JOIN sports_class sc ON l.id = sc.location_id
JOIN group_of_sports g ON sc.id = g.sports_class_id
JOIN teacher t ON g.teacher_id = t.id
WHERE g.current_amount >= 5
GROUP BY l.city, sport_type, enrollment_month, quarter
HAVING SUM(g.current_amount) > 10
ORDER BY projected_revenue DESC, l.city, enrollment_month;