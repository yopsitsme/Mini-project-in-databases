--Consolidates activity program information including group assignments, instructor details, grade levels, 
--and weekly schedules to provide complete visibility into program offerings.

CREATE VIEW activity_participation_summary AS
SELECT 
    a.activity_id,
    a.activity_name,                                       
    a.description,                                        
    a.min_age,                                            
    a.max_age,                                           
    g.group_id,
    g.group_name,                                          -- Group name (color-based)
    g.max_students,                                        -- Maximum capacity
    yg.grade_name,                                         -- Grade level
    i.first_name || ' ' || i.last_name AS instructor_name, -- Instructor full name
    i.specialty,                                           
    i.email AS instructor_email,                          
    ws.day_of_week,                                       
    ws.start_time,                                         
    ws.end_time,                                           
    ws.room                                                
FROM activities a
INNER JOIN grps g ON a.activity_id = g.activity_id         -- Join groups to activities
INNER JOIN yeargroups yg ON g.yeargroup_id = yg.yeargroup_id -- Join grade levels
INNER JOIN instructors i ON g.instructor_id = i.instructor_id -- Join instructor info
INNER JOIN weeklysessions ws ON g.group_id = ws.group_id;   -- Join session schedule