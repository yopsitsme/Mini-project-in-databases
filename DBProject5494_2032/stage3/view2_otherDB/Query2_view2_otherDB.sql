--Query 2.2: Count groups and capacity by activity, showing instructor coverage
--Summarizes program metrics by activity type, including group counts, total capacity, 
--average sizes, instructor coverage, and age ranges for program planning.

SELECT 
    activity_name,                              
    COUNT(DISTINCT group_id) AS number_groups,  -- How many groups
    SUM(max_students) AS total_capacity,        -- Total capacity across groups
    AVG(max_students) AS avg_group_size,        -- Average group size
    COUNT(DISTINCT instructor_name) AS num_instructors, -- Different instructors
    MIN(min_age) AS youngest_age,               -- Minimum age allowed
    MAX(max_age) AS oldest_age                  -- Maximum age allowed
FROM activity_participation_summary
GROUP BY activity_name, min_age, max_age       -- Group by activity
HAVING COUNT(DISTINCT group_id) > 0            -- Only activities with groups
ORDER BY number_groups DESC, activity_name;    -- Most popular first