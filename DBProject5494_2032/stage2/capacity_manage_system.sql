
-- =====================================================
-- CAPACITY MANAGEMENT SYSTEM
-- =====================================================
-- This script adds business rules for group capacity management:
-- 1. Groups with < 5 students are "pending" (not officially open)
-- 2. Groups cannot exceed their class capacity (max 20)
-- 3. Students cannot join full groups
-- =====================================================

-- Add a status column to group_of_sports to track if group is officially open
ALTER TABLE group_of_sports 
ADD COLUMN status VARCHAR(20) DEFAULT 'PENDING' 
CHECK (status IN ('PENDING', 'ACTIVE', 'FULL'));

-- =====================================================
-- TRIGGER 1: Prevent students from joining FULL groups
-- =====================================================
CREATE OR REPLACE FUNCTION check_group_capacity_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    current_students INT;
BEGIN
    -- Get the capacity from sports_class table
    SELECT sc.capacity INTO class_capacity
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.id = NEW.group_id;
    
    -- Get current number of students in this group
    SELECT current_amount INTO current_students
    FROM group_of_sports
    WHERE id = NEW.group_id;
    
    -- Check if adding this student would exceed capacity
    IF current_students >= class_capacity THEN
        RAISE EXCEPTION 'Cannot add student to group %. Group is FULL (capacity: %, current: %)', 
            NEW.group_id, class_capacity, current_students;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_capacity_before_insert
BEFORE INSERT ON participate_in
FOR EACH ROW
EXECUTE FUNCTION check_group_capacity_before_insert();


-- =====================================================
-- TRIGGER 2: Update group status after student joins
-- =====================================================
CREATE OR REPLACE FUNCTION update_group_status_on_insert()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    new_amount INT;
BEGIN
    -- Update current_amount
    UPDATE group_of_sports 
    SET current_amount = current_amount + 1 
    WHERE id = NEW.group_id
    RETURNING current_amount INTO new_amount;
    
    -- Get the capacity from sports_class
    SELECT sc.capacity INTO class_capacity
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.id = NEW.group_id;
    
    -- Update status based on current_amount
    UPDATE group_of_sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE id = NEW.group_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop old trigger and create new one
DROP TRIGGER IF EXISTS trg_insert_participate ON participate_in;
CREATE TRIGGER trg_insert_participate
AFTER INSERT ON participate_in
FOR EACH ROW
EXECUTE FUNCTION update_group_status_on_insert();


-- =====================================================
-- TRIGGER 3: Update group status after student leaves
-- =====================================================
CREATE OR REPLACE FUNCTION update_group_status_on_delete()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    new_amount INT;
BEGIN
    -- Update current_amount
    UPDATE group_of_sports 
    SET current_amount = current_amount - 1 
    WHERE id = OLD.group_id
    RETURNING current_amount INTO new_amount;
    
    -- Get the capacity from sports_class
    SELECT sc.capacity INTO class_capacity
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.id = OLD.group_id;
    
    -- Update status based on current_amount
    UPDATE group_of_sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE id = OLD.group_id;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Drop old trigger and create new one
DROP TRIGGER IF EXISTS trg_delete_participate ON participate_in;
CREATE TRIGGER trg_delete_participate
AFTER DELETE ON participate_in
FOR EACH ROW
EXECUTE FUNCTION update_group_status_on_delete();


-- =====================================================
-- VIEW: Active Groups Only (for queries)
-- =====================================================
-- Use this view to show only officially open groups (status = 'ACTIVE')
CREATE OR REPLACE VIEW active_groups AS
SELECT 
    g.id,
    g.level,
    g.day_in_the_week,
    g.start_time,
    g.min_age,
    g.current_amount,
    g.status,
    g.teacher_id,
    g.sports_class_id,
    sc.name AS class_name,
    sc.capacity,
    sc.cost,
    sc.duration,
    p.name AS teacher_name
FROM group_of_sports g
JOIN sports_class sc ON g.sports_class_id = sc.id
JOIN teacher t ON g.teacher_id = t.id
JOIN person p ON t.id = p.id
WHERE g.status = 'ACTIVE';


-- =====================================================
-- VIEW: All Groups with Status Info (for admin)
-- =====================================================
CREATE OR REPLACE VIEW all_groups_with_status AS
SELECT 
    g.id,
    g.level,
    g.day_in_the_week,
    g.start_time,
    g.min_age,
    g.current_amount,
    g.status,
    sc.capacity,
    sc.capacity - g.current_amount AS available_spots,
    CASE 
        WHEN g.status = 'PENDING' THEN CONCAT('Need ', 5 - g.current_amount, ' more students to open')
        WHEN g.status = 'ACTIVE' THEN CONCAT(sc.capacity - g.current_amount, ' spots available')
        WHEN g.status = 'FULL' THEN 'Group is full'
    END AS status_message,
    g.teacher_id,
    g.sports_class_id,
    sc.name AS class_name,
    sc.cost,
    p.name AS teacher_name
FROM group_of_sports g
JOIN sports_class sc ON g.sports_class_id = sc.id
JOIN teacher t ON g.teacher_id = t.id
JOIN person p ON t.id = p.id;


-- =====================================================
-- FUNCTION: Try to add student to group (with validation)
-- =====================================================
CREATE OR REPLACE FUNCTION add_student_to_group(
    p_student_id INT,
    p_group_id INT
) RETURNS TEXT AS $$
DECLARE
    v_status VARCHAR(20);
    v_current_amount INT;
    v_capacity INT;
    v_class_name VARCHAR(100);
BEGIN
    -- Get group information
    SELECT g.status, g.current_amount, sc.capacity, sc.name
    INTO v_status, v_current_amount, v_capacity, v_class_name
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.id = p_group_id;
    
    -- Check if group exists
    IF NOT FOUND THEN
        RETURN 'ERROR: Group does not exist';
    END IF;
    
    -- Check if group is full
    IF v_status = 'FULL' OR v_current_amount >= v_capacity THEN
        RETURN 'ERROR: Group is FULL. Cannot add more students.';
    END IF;
    
    -- Check if student already enrolled
    IF EXISTS (SELECT 1 FROM participate_in WHERE student_id = p_student_id AND group_id = p_group_id) THEN
        RETURN 'ERROR: Student is already enrolled in this group';
    END IF;
    
    -- Add student to group (triggers will handle the rest)
    INSERT INTO participate_in (student_id, group_id) 
    VALUES (p_student_id, p_group_id);
    
    -- Return success message with new status
    SELECT status INTO v_status FROM group_of_sports WHERE id = p_group_id;
    
    RETURN 'SUCCESS: Student added to ' || v_class_name || '. Group status: ' || v_status;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'ERROR: ' || SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- =====================================================
-- UPDATE EXISTING GROUPS: Set initial status
-- =====================================================
-- Run this once to set the status for existing groups
UPDATE group_of_sports g
SET status = CASE
    WHEN g.current_amount < 5 THEN 'PENDING'
    WHEN g.current_amount >= (SELECT capacity FROM sports_class WHERE id = g.sports_class_id) THEN 'FULL'
    ELSE 'ACTIVE'
END;