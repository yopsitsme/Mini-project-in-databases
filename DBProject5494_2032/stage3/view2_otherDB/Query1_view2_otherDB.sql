--Query 2.1: Find all groups for "Dance" and "Piano" activities with their schedules
--Lists all Dance and Piano activity groups with their complete schedules, 
--instructor assignments, and capacity information, organized chronologically.

SELECT 
    activity_name,        
    group_name,           -- Group identifier
    grade_name,           -- Grade level
    max_students,         -- Capacity
    instructor_name,      
    specialty,            
    day_of_week,          
    start_time,          
    end_time,             
    room                
FROM activity_participation_summary
WHERE activity_name IN ('Dance', 'Piano')     -- Only Dance and Piano
ORDER BY activity_name, day_of_week, start_time; -- Organized by schedule