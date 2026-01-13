-- Provides a comprehensive overview of sports class enrollments, 
-- combining group schedules, capacity tracking, teacher assignments, 
-- and location details to support enrollment management and revenue analysis.


CREATE VIEW sports_enrollment_analysis AS
SELECT 
    g.id AS group_id,
    sc.name AS class_name,                          -- Sports class name
    g.level,                                        -- Skill level
    g.day_in_the_week,                         
    g.start_time,                                   
    g.min_age,                                      
    g.status,                                       
    g.current_amount,                               
    sc.capacity,                                    
    sc.capacity - g.current_amount AS spots_left,  -- Available spots
    sc.cost,                                        -- Class cost
    p.name AS teacher_name,                         
    p.email AS teacher_email,                       
    l.location_name,                                
    l.city                                         
FROM group_of_sports g
INNER JOIN sports_class sc ON g.sports_class_id = sc.id    -- Join to get class details
INNER JOIN teacher t ON g.teacher_id = t.id                -- Join to get teacher reference
INNER JOIN person p ON t.id = p.id                         -- Join to get teacher info
INNER JOIN location l ON sc.location_id = l.id;            -- Join to get location info