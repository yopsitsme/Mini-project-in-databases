--Query 1.1: Find all ACTIVE sports groups with available spots, ordered by spots remaining
--Retrieves all active sports groups with open enrollment spots, sorted by availability 
--and cost to help identify classes accepting new students.

SELECT 
    class_name,           
    level,                
    day_in_the_week,     
    start_time,        
    current_amount,      
    spots_left,           -- Remaining capacity
    cost,                
    teacher_name,         
    location_name,        
    city                 
FROM sports_enrollment_analysis
WHERE status = 'ACTIVE'               -- Only active groups
    AND spots_left > 0                -- Must have openings
ORDER BY spots_left DESC, cost;       -- Most available first, then by price