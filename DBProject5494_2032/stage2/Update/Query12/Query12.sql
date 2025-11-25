-- =====================================================
-- UPDATE QUERY 2: Dynamic Class Pricing Based on Demand and Demographics
-- =====================================================
-- Adjusts sports class costs based on enrollment patterns, age demographics, and location demand
-- Includes complex date analysis for seasonal adjustments and student age calculations
-- Used by: Finance team and pricing strategists for revenue optimization

UPDATE sports_class
SET cost = CASE
    WHEN demand_metrics.avg_occupancy_rate >= 90 AND demand_metrics.waitlist_indicator = 'High Demand'
        THEN sports_class.cost * 1.20  -- 20% increase for consistently full classes
    WHEN demand_metrics.avg_occupancy_rate >= 75 AND demand_metrics.young_student_ratio > 0.6
        THEN sports_class.cost * 1.12  -- 12% increase for popular kids programs
    WHEN demand_metrics.avg_occupancy_rate < 50 AND demand_metrics.months_since_launch > 3
        THEN sports_class.cost * 0.90  -- 10% discount to boost struggling classes
    WHEN demand_metrics.location_competition > 2
        THEN sports_class.cost * 0.95  -- 5% competitive pricing adjustment
    ELSE sports_class.cost * 1.03      -- 3% standard inflation adjustment
END,
duration = CASE
    WHEN demand_metrics.avg_student_age < 10 THEN 45  -- Shorter sessions for younger kids
    WHEN demand_metrics.avg_student_age >= 15 THEN 60 -- Longer sessions for teens/adults
    ELSE sports_class.duration
END
FROM (
    SELECT
        sc.id AS class_id,
        sc.location_id,
        COUNT(DISTINCT g.id) AS total_groups,
        COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') AS full_groups,
        ROUND(AVG((g.current_amount::NUMERIC / NULLIF(sc.capacity, 0)) * 100), 2) AS avg_occupancy_rate,
        ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date))), 1) AS avg_student_age,
        -- Calculate ratio of students under 12
        ROUND(
            COUNT(DISTINCT CASE
                WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) < 12
                THEN s.id END)::NUMERIC / NULLIF(COUNT(DISTINCT s.id), 0),
            2
        ) AS young_student_ratio,
        -- Months since class was established (using earliest teacher hire date as proxy)
        COALESCE(EXTRACT(MONTH FROM AGE(CURRENT_DATE, MIN(t.hire_date))), 12) AS months_since_launch,
        -- Demand indicator based on full groups
        CASE
            WHEN COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') >= 2
                THEN 'High Demand'
            WHEN COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') >= 1
                THEN 'Moderate Demand'
            ELSE 'Low Demand'
        END AS waitlist_indicator,
        -- Count competing classes at same location
        (SELECT COUNT(DISTINCT sc2.id)
         FROM sports_class sc2
         WHERE sc2.location_id = sc.location_id
         AND sc2.id != sc.id) AS location_competition
    FROM sports_class sc
    JOIN group_of_sports g ON sc.id = g.sports_class_id
    JOIN participate_in pi ON g.id = pi.group_id
    JOIN student s ON pi.student_id = s.id
    JOIN person p ON s.id = p.id
    LEFT JOIN teacher t ON g.teacher_id = t.id
    WHERE g.current_amount >= 1  -- Only need at least 1 student
    GROUP BY sc.id, sc.location_id, sc.capacity
    HAVING COUNT(DISTINCT g.id) >= 1  -- Class must have at least 1 group
) AS demand_metrics
WHERE sports_class.id = demand_metrics.class_id;