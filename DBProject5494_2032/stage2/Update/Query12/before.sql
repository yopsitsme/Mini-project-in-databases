SELECT
    sc.id AS class_id,
    sc.name AS class_name,
    l.city AS location,
    sc.cost AS current_cost,
    sc.duration AS current_duration,
    
    -- Show what the NEW cost will be
    CASE
        WHEN demand_metrics.avg_occupancy_rate >= 90 AND demand_metrics.waitlist_indicator = 'High Demand'
            THEN ROUND(sc.cost * 1.20, 2)
        WHEN demand_metrics.avg_occupancy_rate >= 75 AND demand_metrics.young_student_ratio > 0.6
            THEN ROUND(sc.cost * 1.12, 2)
        WHEN demand_metrics.avg_occupancy_rate < 50 AND demand_metrics.months_since_launch > 3
            THEN ROUND(sc.cost * 0.90, 2)
        WHEN demand_metrics.location_competition > 2
            THEN ROUND(sc.cost * 0.95, 2)
        ELSE ROUND(sc.cost * 1.03, 2)
    END AS new_cost,
    
    -- Show cost change amount
    CASE
        WHEN demand_metrics.avg_occupancy_rate >= 90 AND demand_metrics.waitlist_indicator = 'High Demand'
            THEN ROUND(sc.cost * 0.20, 2)
        WHEN demand_metrics.avg_occupancy_rate >= 75 AND demand_metrics.young_student_ratio > 0.6
            THEN ROUND(sc.cost * 0.12, 2)
        WHEN demand_metrics.avg_occupancy_rate < 50 AND demand_metrics.months_since_launch > 3
            THEN ROUND(sc.cost * -0.10, 2)
        WHEN demand_metrics.location_competition > 2
            THEN ROUND(sc.cost * -0.05, 2)
        ELSE ROUND(sc.cost * 0.03, 2)
    END AS cost_change,
    
    -- Show pricing adjustment reason
    CASE
        WHEN demand_metrics.avg_occupancy_rate >= 90 AND demand_metrics.waitlist_indicator = 'High Demand'
            THEN '+20% (High Demand)'
        WHEN demand_metrics.avg_occupancy_rate >= 75 AND demand_metrics.young_student_ratio > 0.6
            THEN '+12% (Popular Kids Program)'
        WHEN demand_metrics.avg_occupancy_rate < 50 AND demand_metrics.months_since_launch > 3
            THEN '-10% (Boost Struggling)'
        WHEN demand_metrics.location_competition > 2
            THEN '-5% (Competitive Pricing)'
        ELSE '+3% (Standard Inflation)'
    END AS pricing_reason,
    
    -- Show what the NEW duration will be
    CASE
        WHEN demand_metrics.avg_student_age < 10 THEN 45
        WHEN demand_metrics.avg_student_age >= 15 THEN 60
        ELSE sc.duration
    END AS new_duration,
    
    -- Key metrics
    demand_metrics.total_groups,
    demand_metrics.full_groups,
    demand_metrics.avg_occupancy_rate,
    demand_metrics.avg_student_age,
    demand_metrics.young_student_ratio,
    demand_metrics.months_since_launch,
    demand_metrics.waitlist_indicator,
    demand_metrics.location_competition
    
FROM sports_class sc
JOIN location l ON sc.location_id = l.id
JOIN (
    SELECT
        sc.id AS class_id,
        sc.location_id,
        COUNT(DISTINCT g.id) AS total_groups,
        COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') AS full_groups,
        ROUND(AVG((g.current_amount::NUMERIC / NULLIF(sc.capacity, 0)) * 100), 2) AS avg_occupancy_rate,
        ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date))), 1) AS avg_student_age,
        ROUND(
            COUNT(DISTINCT CASE
                WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) < 12
                THEN s.id END)::NUMERIC / NULLIF(COUNT(DISTINCT s.id), 0),
            2
        ) AS young_student_ratio,
        COALESCE(EXTRACT(MONTH FROM AGE(CURRENT_DATE, MIN(t.hire_date))), 12) AS months_since_launch,
        CASE
            WHEN COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') >= 2
                THEN 'High Demand'
            WHEN COUNT(DISTINCT g.id) FILTER (WHERE g.status = 'FULL') >= 1
                THEN 'Moderate Demand'
            ELSE 'Low Demand'
        END AS waitlist_indicator,
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
    WHERE g.current_amount >= 1
    GROUP BY sc.id, sc.location_id, sc.capacity
    HAVING COUNT(DISTINCT g.id) >= 1
) AS demand_metrics ON sc.id = demand_metrics.class_id
ORDER BY cost_change DESC;
