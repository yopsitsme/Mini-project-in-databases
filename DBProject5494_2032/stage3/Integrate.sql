-- =====================================================
-- INTEGRATE.SQL - Complete Database Integration Script
-- Merging BD_Proj_5494_2032 (backup2) with full_backup data
-- Following the unified ERD design specifications
-- =====================================================

-- =====================================================
-- STAGE 1: PERSON HIERARCHY TRANSFORMATION
-- =====================================================

-- STEP 1.2: Transform Person entity - Decompose name attribute into first_name and last_name
-- =====================================================

-- Add first_name and last_name columns to Person table
ALTER TABLE Person 
ADD COLUMN IF NOT EXISTS first_name VARCHAR(50),
ADD COLUMN IF NOT EXISTS last_name VARCHAR(50);

-- Split existing 'name' into first_name and last_name using space as delimiter
UPDATE Person
SET 
    first_name = SPLIT_PART(name, ' ', 1),
    last_name = CASE 
        WHEN POSITION(' ' IN name) > 0 
        THEN SUBSTRING(name FROM POSITION(' ' IN name) + 1)
        ELSE ''
    END
WHERE first_name IS NULL;


-- Remove the original 'name' column after successful decomposition
ALTER TABLE Person DROP COLUMN IF EXISTS name;


-- STEP 1.3: Rename id columns to entity-specific naming convention
-- =====================================================

-- Rename Person.id to personId for consistency
ALTER TABLE Person RENAME COLUMN id TO personId;

-- Rename Student.id to studentId and update its foreign key constraint
ALTER TABLE Student RENAME COLUMN id TO studentId;

-- Drop old foreign key constraint and create new one referencing Person(personId)
ALTER TABLE Student DROP CONSTRAINT IF EXISTS student_id_fkey;
ALTER TABLE Student 
ADD CONSTRAINT student_personid_fkey 
FOREIGN KEY (studentId) REFERENCES Person(personId) ON DELETE CASCADE;


-- Rename Teacher.id to teacherId and update its foreign key constraint
ALTER TABLE Teacher RENAME COLUMN id TO teacherId;

-- Drop old foreign key constraint and create new one referencing Person(personId)
ALTER TABLE Teacher DROP CONSTRAINT IF EXISTS teacher_id_fkey;
ALTER TABLE Teacher 
ADD CONSTRAINT teacher_personid_fkey 
FOREIGN KEY (teacherId) REFERENCES Person(personId) ON DELETE CASCADE;

-- Add specialty column to Teacher table (populated later from instructors data)
ALTER TABLE Teacher 
ADD COLUMN IF NOT EXISTS specialty VARCHAR(50);


-- STEP 1.4: Parent entity transformation - migrate to Person hierarchy
-- =====================================================
-- Rename parents table to Parent and standardize column naming
ALTER TABLE IF EXISTS parents RENAME TO Parent;
ALTER TABLE Parent RENAME COLUMN parent_id TO parentId;

-- Migrate all parent records into Person table using offset 10000 to avoid ID conflicts
INSERT INTO Person (personId, first_name, last_name, birth_date, email, phone)
SELECT 
    parentId + 10000 as personId,
    first_name,
    last_name,
    NULL as birth_date,  -- Parents table doesn't have birth_date
    email,
    phone
FROM Parent
ON CONFLICT (personId) DO NOTHING;

-- Convert parentId to numeric type for consistency
ALTER TABLE Parent 
ALTER COLUMN parentId TYPE NUMERIC(6,0);


-- Import students from backup2 database
CREATE TEMP TABLE temp_students AS
SELECT * FROM students;

-- Insert student records into Person table using offset 20000 to avoid ID conflicts
INSERT INTO Person (personId, first_name, last_name, birth_date, email, phone)
SELECT 
    student_id + 20000 as personId,
    first_name,
    last_name,
    birth_date,
    NULL as email,
    NULL as phone
FROM temp_students
ON CONFLICT (personId) DO NOTHING;

-- STEP 1.5: Add parent relationship to Student table

-- Add parentId foreign key column to Student
ALTER TABLE Student 
ADD COLUMN IF NOT EXISTS parentId INTEGER;

-- Create foreign key constraint linking Student to Parent
ALTER TABLE Student 
ADD CONSTRAINT student_parent_fkey 
FOREIGN KEY (parentId) REFERENCES Parent(parentId) ON DELETE SET NULL;


-- Remove old parent_id column from students table
ALTER TABLE students DROP COLUMN parent_id

-- Apply offset to existing Parent IDs to align with Person table offsets
UPDATE Parent 
SET parentId = parentId + 10000
WHERE parentId < 10000;


-- Create backup of Parent data before modifications
CREATE TEMP TABLE temp_parent_backup AS
SELECT * FROM Parent;


-- Populate Student table with data from backup2, linking to parents via offset IDs
INSERT INTO Student (studentId, addres, parentId)
SELECT 
    student_id + 20000 as studentId,
    NULL as addres,
    parent_id + 10000 as parentId
FROM temp_students
ON CONFLICT (studentId) DO NOTHING;

-- Clean up temporary students table
DROP TABLE temp_students;

-- Remove redundant columns from Parent (data now stored in Person table)
ALTER TABLE Parent DROP COLUMN IF EXISTS first_name;
ALTER TABLE Parent DROP COLUMN IF EXISTS last_name;
ALTER TABLE Parent DROP COLUMN IF EXISTS email;
ALTER TABLE Parent DROP COLUMN IF EXISTS phone;

-- Recreate Parent primary key constraint with new column name
ALTER TABLE Parent DROP CONSTRAINT IF EXISTS parents_pkey;
ALTER TABLE Parent 
ADD CONSTRAINT parent_pkey PRIMARY KEY (parentId);

-- Convert parentId to INTEGER type
ALTER TABLE Parent 
ALTER COLUMN parentId TYPE INTEGER USING parentId::INTEGER;

-- Create foreign key linking Parent to Person (inheritance relationship)
ALTER TABLE Parent DROP CONSTRAINT IF EXISTS parent_personid_fkey;
ALTER TABLE Parent 
ADD CONSTRAINT parent_personid_fkey 
FOREIGN KEY (parentId) REFERENCES Person(personId) ON DELETE CASCADE;


 -- STEP 1.5: Ensure Student-Parent relationship is properly established
--=====================================================
-- Add parentId column if not already present
ALTER TABLE Student 
ADD COLUMN IF NOT EXISTS parentId INTEGER;

-- Create foreign key constraint for parent relationship
ALTER TABLE Student 
ADD CONSTRAINT student_parent_fkey 
FOREIGN KEY (parentId) REFERENCES Parent(parentId) ON DELETE SET NULL


-- =====================================================
-- STAGE 2: LOCATION AND SCHEDULING TRANSFORMATION
-- =====================================================

-- STEP 2.1: Rename Location column to reflect school-centric model
-- =====================================================
ALTER TABLE Location RENAME COLUMN location_name TO school_name;


-- Rename weeklysessions to Group_Details and update primary key
ALTER TABLE weeklysessions RENAME TO Group_Details;
ALTER TABLE Group_Details DROP CONSTRAINT IF EXISTS weeklysessions_pkey;
ALTER TABLE Group_Details RENAME COLUMN session_id TO timeId;
ALTER TABLE Group_Details ADD CONSTRAINT Group_Details_pkey PRIMARY KEY (timeId);

-- Standardize groupId naming in Group_Of_Sports
ALTER TABLE Group_Of_Sports RENAME COLUMN id TO groupId;


-- Convert group_id to INTEGER type in Group_Details
ALTER TABLE Group_Details
ALTER COLUMN group_id TYPE INTEGER USING group_id::INTEGER;

-- Update foreign key constraint to reference Group_Of_Sports(groupId)
ALTER TABLE Group_Details DROP CONSTRAINT IF EXISTS weeklysessions_group_id_fkey;
ALTER TABLE Group_Details 
ADD CONSTRAINT Group_Detail_group_id_fkey 
FOREIGN KEY (group_id) REFERENCES group_of_sports(groupid) ON DELETE CASCADE;



-- Import instructors from backup2 database
CREATE TEMP TABLE temp_instructors AS
SELECT * FROM instructors;

-- Insert instructor records into Person table using offset 30000
INSERT INTO Person (personId, first_name, last_name, birth_date, email, phone)
SELECT 
    instructor_id + 30000 as personId,
    first_name,
    last_name,
    NULL as birth_date,
    email,
    phone
FROM temp_instructors
ON CONFLICT (personId) DO NOTHING;

-- Insert instructors into Teacher table with their specialty
INSERT INTO Teacher (teacherId, salary, hire_date, specialty)
SELECT 
    instructor_id + 30000 as teacherId,
    NULL as salary,
    NULL as hire_date,
    specialty
FROM temp_instructors
ON CONFLICT (teacherId) DO NOTHING;

-- Clean up temporary instructors table
DROP TABLE temp_instructors;


-- STEP 5.6: Import groups from backup2 database (grps table)
-- =====================================================

-- Create temporary table for grps data
CREATE TEMP TABLE temp_grps AS
SELECT * FROM grps;

-- Import grps as Group_Of_Sports using offset 2000, mapping instructors to teachers
INSERT INTO Group_Of_Sports (groupId, level, min_age, current_amount, teacher_id, sports_class_id, status, yeargroup_id)
SELECT 
    group_id + 2000 as groupId,
    NULL as level,
    NULL as min_age,
    0 as current_amount,
    instructor_id + 30000 as teacher_id,
    activity_id as sports_class_id,  -- Direct mapping, no offset needed
    'PENDING' as status,
    yeargroup_id
FROM temp_grps
ON CONFLICT (groupId) DO NOTHING;

-- Clean up temporary grps table
DROP TABLE temp_grps;

-- Apply offset to existing Group_Details.group_id to align with imported groups
UPDATE Group_Details 
SET group_id = group_id + 2000
WHERE group_id < 2000;


-- Convert day_of_week to VARCHAR type for compatibility
ALTER TABLE group_details
ALTER COLUMN day_of_week TYPE CHARACTER VARYING(20);


-- Create sequence for auto-generating timeId values in Group_Details
CREATE SEQUENCE IF NOT EXISTS group_details_timeid_seq;

-- Set sequence to start from 36 (after existing records)
ALTER SEQUENCE group_details_timeid_seq RESTART WITH 36;

-- Set sequence as default value generator for timeId
ALTER TABLE Group_Details
ALTER COLUMN timeid
SET DEFAULT nextval('group_details_timeid_seq');

-- Migrate scheduling data from Group_Of_Sports to Group_Details
INSERT INTO Group_Details (group_id, day_of_week, start_time, end_time, room)
SELECT
    groupId,
    day_in_the_week,
    start_time,
    NULL,
    NULL
FROM Group_Of_Sports
WHERE day_in_the_week IS NOT NULL
   OR start_time IS NOT NULL;


-- STEP 3.4: Remove scheduling columns from Group_Of_Sports (now in Group_Details)
-- =====================================================
ALTER TABLE Group_Of_Sports DROP COLUMN IF EXISTS day_in_the_week;
ALTER TABLE Group_Of_Sports DROP COLUMN IF EXISTS start_time;



-- Create Takes_Place relationship table (many-to-many: Year_Groups ↔ Location)
CREATE TABLE IF NOT EXISTS Takes_Place (
    yeargroup_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    PRIMARY KEY (yeargroup_id, location_id),
    CONSTRAINT takes_place_yeargroup_fkey 
        FOREIGN KEY (yeargroup_id) REFERENCES yeargroups(yeargroup_id) ON DELETE CASCADE,
    CONSTRAINT takes_place_location_fkey 
        FOREIGN KEY (location_id) REFERENCES Location(id) ON DELETE CASCADE
);


-- STEP 2.3: Add yeargroup_id to Group_Of_Sports (groups belong to year groups, not students)
-- =====================================================
ALTER TABLE Group_Of_Sports 
ADD COLUMN IF NOT EXISTS yeargroup_id INTEGER;

-- Create foreign key constraint linking groups to year groups
ALTER TABLE Group_Of_Sports 
ADD CONSTRAINT group_yeargroup_fkey 
FOREIGN KEY (yeargroup_id) REFERENCES yeargroups(yeargroup_id) ON DELETE SET NULL;


-- STEP 2.4: Remove location_id from Sports_Class (location now managed via Year_Groups)
-- =====================================================
ALTER TABLE Sports_Class DROP CONSTRAINT IF EXISTS sports_class_location_id_fkey;
ALTER TABLE Sports_Class DROP COLUMN IF EXISTS location_id;



-- =====================================================
-- STAGE 4: UPDATE FOREIGN KEY REFERENCES IN PARTICIPATE_IN
-- =====================================================

-- STEP 4.1: Standardize Participate_In table column names and constraints
-- =====================================================
ALTER TABLE Participate_In RENAME COLUMN student_id TO studentId;
ALTER TABLE Participate_In RENAME COLUMN group_id TO groupId;

-- Drop old foreign key constraints
ALTER TABLE Participate_In DROP CONSTRAINT IF EXISTS participate_in_student_id_fkey;
ALTER TABLE Participate_In DROP CONSTRAINT IF EXISTS participate_in_group_id_fkey;

-- Create new foreign key constraints with standardized column names
ALTER TABLE Participate_In 
ADD CONSTRAINT participate_in_studentid_fkey 
FOREIGN KEY (studentId) REFERENCES Student(studentId) ON DELETE CASCADE;

ALTER TABLE Participate_In 
ADD CONSTRAINT participate_in_groupid_fkey 
FOREIGN KEY (groupId) REFERENCES Group_Of_Sports(groupId) ON DELETE CASCADE;

-- Add enrollment_date to track when students joined groups
ALTER TABLE Participate_In 
ADD COLUMN IF NOT EXISTS enrollment_date DATE DEFAULT CURRENT_DATE;


-- =====================================================
-- STAGE 6: UPDATE TRIGGERS AND FUNCTIONS FOR GROUP CAPACITY MANAGEMENT
-- =====================================================

-- Drop old triggers that use outdated column names
DROP TRIGGER IF EXISTS trg_check_capacity_before_insert ON Participate_In;
DROP TRIGGER IF EXISTS trg_insert_participate ON Participate_In;
DROP TRIGGER IF EXISTS trg_delete_participate ON Participate_In;

-- Function: Check if group has capacity before allowing new enrollment
CREATE OR REPLACE FUNCTION check_group_capacity_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    current_students INT;
BEGIN
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = NEW.groupId;
    
    SELECT current_amount INTO current_students
    FROM Group_Of_Sports
    WHERE groupId = NEW.groupId;
    
    IF current_students >= class_capacity THEN
        RAISE EXCEPTION 'Cannot add student to group %. Group is FULL', NEW.groupId;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Validate capacity before inserting enrollment
CREATE TRIGGER trg_check_capacity_before_insert
BEFORE INSERT ON Participate_In
FOR EACH ROW
EXECUTE FUNCTION check_group_capacity_before_insert();


-- Function: Update group status after student enrollment
CREATE OR REPLACE FUNCTION update_group_status_on_insert()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    new_amount INT;
BEGIN
    UPDATE Group_Of_Sports 
    SET current_amount = current_amount + 1 
    WHERE groupId = NEW.groupId
    RETURNING current_amount INTO new_amount;
    
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = NEW.groupId;
    
    UPDATE Group_Of_Sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE groupId = NEW.groupId;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Update group count and status after enrollment
CREATE TRIGGER trg_insert_participate
AFTER INSERT ON Participate_In
FOR EACH ROW
EXECUTE FUNCTION update_group_status_on_insert();


-- Function: Update group status after student withdrawal
CREATE OR REPLACE FUNCTION update_group_status_on_delete()
RETURNS TRIGGER AS $$
DECLARE
    class_capacity INT;
    new_amount INT;
BEGIN
    UPDATE Group_Of_Sports 
    SET current_amount = current_amount - 1 
    WHERE groupId = OLD.groupId
    RETURNING current_amount INTO new_amount;
    
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = OLD.groupId;
    
    UPDATE Group_Of_Sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE groupId = OLD.groupId;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Update group count and status after withdrawal
CREATE TRIGGER trg_delete_participate
AFTER DELETE ON Participate_In
FOR EACH ROW
EXECUTE FUNCTION update_group_status_on_delete();

-- STEP 5.8: Import student enrollments from backup2 (studentgroups table)
-- =====================================================

-- PART A: Set NULL enrollment_date for existing Participate_In records (from main DB)
UPDATE Participate_In 
SET enrollment_date = NULL 
WHERE enrollment_date IS NULL;


-- Convert studentgroups columns to INTEGER for consistency
ALTER TABLE studentgroups 
ALTER COLUMN group_id TYPE INTEGER USING group_id::INTEGER;

ALTER TABLE studentgroups
ALTER COLUMN student_id TYPE INTEGER USING student_id::INTEGER;


-- PART B: Import enrollments from backup2 with enrollment dates
CREATE TEMP TABLE temp_studentgroups AS
SELECT * FROM studentgroups;

-- Insert enrollments with offsets applied and enrollment_date preserved
INSERT INTO Participate_In (studentId, groupId, enrollment_date)
SELECT 
    student_id + 20000 as studentId,
    group_id + 2000 as groupId,
    enrollment_date
FROM temp_studentgroups
ON CONFLICT (studentId, groupId) DO NOTHING;

-- Clean up temporary studentgroups table
DROP TABLE temp_studentgroups;






-- Populate Takes_Place with all combinations of year groups and locations
CREATE TEMP TABLE temp_yeargroups AS
SELECT * FROM yeargroups;

-- Create many-to-many relationships: all year groups available at all locations
INSERT INTO Takes_Place (yeargroup_id, location_id)
SELECT 
    yg.yeargroup_id,
    l.id
FROM temp_yeargroups yg
CROSS JOIN Location l
ON CONFLICT (yeargroup_id, location_id) DO NOTHING;

-- Clean up temporary yeargroups table
DROP TABLE temp_yeargroups;

-- =====================================================
-- STAGE 7: CREATE PERFORMANCE INDEXES
-- =====================================================

-- Indexes for Group_Of_Sports foreign keys
CREATE INDEX IF NOT EXISTS idx_group_teacher ON Group_Of_Sports(teacher_id);
CREATE INDEX IF NOT EXISTS idx_group_sports_class ON Group_Of_Sports(sports_class_id);
CREATE INDEX IF NOT EXISTS idx_group_yeargroup ON Group_Of_Sports(yeargroup_id);

-- Indexes for Participate_In foreign keys
CREATE INDEX IF NOT EXISTS idx_participate_student ON Participate_In(studentId);
CREATE INDEX IF NOT EXISTS idx_participate_group ON Participate_In(groupId);

-- Index for Student-Parent relationship
CREATE INDEX IF NOT EXISTS idx_student_parent ON Student(parentId);

-- Indexes for Takes_Place foreign keys
CREATE INDEX IF NOT EXISTS idx_takes_place_yeargroup ON Takes_Place(yeargroup_id);
CREATE INDEX IF NOT EXISTS idx_takes_place_location ON Takes_Place(location_id);

-- Index for Group_Details foreign key
CREATE INDEX IF NOT EXISTS idx_group_details_group ON Group_Details(group_id);


-- =====================================================
-- STAGE 8: ADD TABLE DOCUMENTATION COMMENTS
-- =====================================================

COMMENT ON TABLE Person IS 'Base entity for inheritance hierarchy - stores common attributes for Student, Teacher, and Parent';
COMMENT ON TABLE Student IS 'Student entity - inherits from Person, linked to Parent';
COMMENT ON TABLE Teacher IS 'Teacher/Instructor entity - inherits from Person, includes specialty';
COMMENT ON TABLE Parent IS 'Parent entity - inherits from Person, linked to Student via parentId';
COMMENT ON TABLE Location IS 'School locations where year groups take place';
COMMENT ON TABLE Year_Groups IS 'Year/grade levels (1-8) offered across locations';
COMMENT ON TABLE Takes_Place IS 'Many-to-many relationship: which year groups are offered at which locations';
COMMENT ON TABLE Sports_Class IS 'Types of sports activities offered (e.g., swimming, basketball)';
COMMENT ON TABLE Group_Of_Sports IS 'Specific groups/sections of sports classes with teacher assignments and year group';
COMMENT ON TABLE Group_Details IS 'Scheduling information for groups (day, time, room)';
COMMENT ON TABLE Participate_In IS 'Student enrollments in sports groups with enrollment dates';

-- Clean up imported tables that have been fully integrated
DROP TABLE IF EXISTS studentgroups;
DROP TABLE IF EXISTS grps;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS students;