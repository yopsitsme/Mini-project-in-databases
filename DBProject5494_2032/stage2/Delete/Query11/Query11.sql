-- =====================================================
-- DELETE QUERY 3: Remove Long-Standing Underperforming Sports Groups
-- =====================================================
-- Complex logic: Delete groups that meet BOTH of the following criteria:
-- 1. Have been running for more than 6 months (based on teacher's hire date as proxy for group age)
-- 2. Never reached ACTIVE status (remained PENDING - less than 5 students)
--
-- Used by: Program Director during quarterly program review
-- Business value: Free up teacher resources for new, more viable groups
-- GUI Display: Shows group details, teacher name, location, current enrollment before deletion

DELETE FROM group_of_sports
WHERE id IN (
    SELECT g.id
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    JOIN location l ON sc.location_id = l.id
    JOIN teacher t ON g.teacher_id = t.id
    JOIN person p_teacher ON t.id = p_teacher.id
    WHERE 
        -- Criterion 1: Group has existed for more than 6 months
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, t.hire_date)) + 
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) * 12) > 6
        
        -- Criterion 2: Group never became ACTIVE (still PENDING)
        AND g.status = 'PENDING'
        AND g.current_amount < 5
    
    -- Order by priority: worst performers first (lowest enrollment, oldest groups)
    ORDER BY 
        g.current_amount ASC,
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, t.hire_date)) + 
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) * 12) DESC,
        g.id ASC
);