-- selectAll.sql
-- Retrieve data from all tables in the sports class management system

-- =====================================================
-- BASIC TABLE QUERIES
-- =====================================================

-- Select all persons
SELECT * FROM person
ORDER BY id;


-- Select all students with their addresses
SELECT * FROM student
ORDER BY id;

-- Select all teachers with their employment details
SELECT * FROM teacher
ORDER BY id;

-- Select all locations
SELECT * FROM location
ORDER BY id;

-- Select all equipment
SELECT * FROM equipment
ORDER BY id;

-- Select all sports classes
SELECT * FROM sports_class
ORDER BY id;

-- Select all sports groups
SELECT * FROM group_of_sports
ORDER BY id;

-- Select all student-group participations
SELECT * FROM participate_in
ORDER BY student_id, group_id;

-- Select all equipment-class needs
SELECT * FROM needs
ORDER BY equipment_id, sports_class_id;

-- =====================================================
-- JOINED QUERIES - DETAILED VIEWS
-- =====================================================

-- Complete student information (person + student details)
SELECT 
    p.id,
    p.name,
    p.birth_date,
    p.email,
    p.phone,
    s.addres
FROM person p
JOIN student s ON p.id = s.id
ORDER BY p.id;

-- Complete teacher information (person + teacher details)
SELECT 
    p.id,
    p.name,
    p.birth_date,
    p.email,
    p.phone,
    t.salary,
    t.hire_date
FROM person p
JOIN teacher t ON p.id = t.id
ORDER BY p.id;

-- Sports classes with their locations
SELECT 
    sc.id,
    sc.name AS class_name,
    sc.capacity,
    sc.cost,
    sc.duration,
    l.location_name,
    l.city,
    l.capacity AS location_capacity
FROM sports_class sc
JOIN location l ON sc.location_id = l.id
ORDER BY sc.id;

-- Sports groups with class and teacher information
SELECT 
    g.id,
    sc.name AS class_name,
    g.level,
    g.day_in_the_week,
    g.start_time,
    g.min_age,
    g.current_amount,
    sc.capacity AS max_capacity,
    p.name AS teacher_name
FROM group_of_sports g
JOIN sports_class sc ON g.sports_class_id = sc.id
JOIN teacher t ON g.teacher_id = t.id
JOIN person p ON t.id = p.id
ORDER BY g.id;

-- Student participation in groups (detailed view)
SELECT 
    p.name AS student_name,
    p.email,
    sc.name AS class_name,
    g.level,
    g.day_in_the_week,
    g.start_time,
    sc.cost,
    sc.duration
FROM participate_in pi
JOIN student s ON pi.student_id = s.id
JOIN person p ON s.id = p.id
JOIN group_of_sports g ON pi.group_id = g.id
JOIN sports_class sc ON g.sports_class_id = sc.id
ORDER BY p.name, g.day_in_the_week;

-- Equipment needs for each sports class
SELECT 
    sc.name AS class_name,
    e.name AS equipment_name,
    n.quantity_required,
    e.amount AS total_available
FROM needs n
JOIN sports_class sc ON n.sports_class_id = sc.id
JOIN equipment e ON n.equipment_id = e.id
ORDER BY sc.name, e.name;

-- =====================================================
-- SUMMARY QUERIES
-- =====================================================

-- Count of students per sports group
SELECT 
    g.id AS group_id,
    sc.name AS class_name,
    g.level,
    g.day_in_the_week,
    g.current_amount AS enrolled_students,
    sc.capacity AS max_capacity
FROM group_of_sports g
JOIN sports_class sc ON g.sports_class_id = sc.id
ORDER BY g.id;

-- Students enrolled in multiple classes
SELECT 
    p.name AS student_name,
    COUNT(pi.group_id) AS number_of_classes
FROM person p
JOIN student s ON p.id = s.id
LEFT JOIN participate_in pi ON s.id = pi.student_id
GROUP BY p.id, p.name
ORDER BY number_of_classes DESC, p.name;

-- Teacher workload (number of groups per teacher)
SELECT 
    p.name AS teacher_name,
    COUNT(g.id) AS number_of_groups
FROM person p
JOIN teacher t ON p.id = t.id
LEFT JOIN group_of_sports g ON t.id = g.teacher_id
GROUP BY p.id, p.name
ORDER BY number_of_groups DESC, p.name;

-- Equipment usage across all classes
SELECT 
    e.name AS equipment_name,
    e.amount AS total_available,
    COALESCE(SUM(n.quantity_required), 0) AS total_required,
    e.amount - COALESCE(SUM(n.quantity_required), 0) AS remaining
FROM equipment e
LEFT JOIN needs n ON e.id = n.equipment_id
GROUP BY e.id, e.name, e.amount
ORDER BY e.name;
