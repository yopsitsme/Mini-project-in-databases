-- =====================================================
-- UPDATE QUERY 1: Teacher Salary Adjustment Based on Performance Metrics
-- =====================================================
-- Adjusts teacher salaries based on tenure, student load, and revenue generation
-- Includes date-based calculations for years of service and seasonal performance
-- Used by: HR department for annual salary reviews and performance-based compensation

UPDATE teacher
SET salary = CASE
    WHEN performance_data.years_employed >= 4 AND performance_data.total_students >= 15 
        THEN teacher.salary * 1.15  -- 15% raise for experienced teachers with good load
    WHEN performance_data.years_employed >= 2 AND performance_data.active_groups >= 2 
        THEN teacher.salary * 1.10  -- 10% raise for established teachers with multiple groups
    WHEN performance_data.years_employed >= 1 AND performance_data.total_students >= 10 
        THEN teacher.salary * 1.08  -- 8% raise for newer teachers with decent enrollment
    WHEN performance_data.active_groups >= 1 AND performance_data.total_students >= 5
        THEN teacher.salary * 1.05  -- 5% raise for any teacher with active classes
    ELSE teacher.salary * 1.03      -- 3% cost of living adjustment for all others
END
FROM (
    SELECT 
        t.id AS teacher_id,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) AS years_employed,
        EXTRACT(MONTH FROM t.hire_date) AS hire_month,
        EXTRACT(DAY FROM t.hire_date) AS hire_day,
        COUNT(DISTINCT g.id) AS active_groups,
        SUM(g.current_amount) AS total_students,
        ROUND(AVG(sc.cost), 2) AS avg_class_cost,
        ROUND(SUM(sc.cost * g.current_amount) / NULLIF(SUM(g.current_amount), 0), 2) AS revenue_per_student,
        ROUND(SUM(sc.cost * g.current_amount), 2) AS total_revenue_generated,
        -- Calculate months employed for finer granularity
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) * 12 + 
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, t.hire_date)) AS months_employed,
        -- Seasonal performance: check if teacher works in peak months (Sept-Dec, Jan-Mar)
        CASE 
            WHEN COUNT(DISTINCT CASE 
                WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (9, 10, 11, 12, 1, 2, 3) 
                THEN g.id END) >= 1 THEN 'Peak Season'
            ELSE 'Regular Season'
        END AS season_status
    FROM teacher t
    LEFT JOIN group_of_sports g ON t.id = g.teacher_id
    LEFT JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.id IS NOT NULL  -- Teacher must have at least one group
        AND (g.status IN ('ACTIVE', 'FULL', 'PENDING') OR g.current_amount >= 1)
    GROUP BY t.id, t.hire_date
    HAVING COUNT(DISTINCT g.id) >= 1  -- At least 1 group (very loose)
) AS performance_data
WHERE teacher.id = performance_data.teacher_id
    AND (
        performance_data.years_employed >= 0  -- All teachers eligible, regardless of tenure
        OR performance_data.months_employed >= 0  -- Alternative: even brand new teachers
    );