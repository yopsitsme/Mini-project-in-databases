--Query 1.2: Calculate revenue and utilization statistics by location
-- Aggregates enrollment and revenue statistics by location, calculating total students, 
-- potential revenue, and capacity utilization metrics for business analysis.

SELECT 
    location_name,                                        
    city,                                                   
    COUNT(group_id) AS total_groups,                       -- Number of groups
    SUM(current_amount) AS total_enrolled,                 -- Total students
    SUM(current_amount * cost) AS potential_revenue,       -- Total revenue
    AVG(current_amount) AS avg_enrollment,                 -- Avg students per group
    MIN(spots_left) AS min_spots_available,                -- Least available
    MAX(spots_left) AS max_spots_available                 -- Most available
FROM sports_enrollment_analysis
GROUP BY location_name, city          -- Group by location
HAVING SUM(current_amount) > 0        -- Only locations with students
ORDER BY potential_revenue DESC;      -- Highest revenue first