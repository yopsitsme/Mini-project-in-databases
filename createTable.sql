-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS participate_in;
DROP TABLE IF EXISTS needs;
DROP TABLE IF EXISTS sports_class;
DROP TABLE IF EXISTS group_of_sports;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS equipment;

-- Create person table (supertype)
CREATE TABLE person (
    id INT PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Create student table (subtype of person)
CREATE TABLE student (
    id INT PRIMARY KEY UNIQUE,
    addres VARCHAR(200),
    FOREIGN KEY (id) REFERENCES person(id) ON DELETE CASCADE
);

-- Create teacher table (subtype of person)
CREATE TABLE teacher (
    id INT PRIMARY KEY UNIQUE,
    salary NUMERIC(10,2),
    hire_date DATE,
    FOREIGN KEY (id) REFERENCES person(id) ON DELETE CASCADE
);

-- Create location table
CREATE TABLE location (
    id INT PRIMARY KEY UNIQUE,
    location_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    capacity INT
);

-- Create equipment table
CREATE TABLE equipment (
    id INT PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    amount INT
);

-- Create sports_class table
CREATE TABLE sports_class (
    id INT PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    capacity INT CHECK (capacity BETWEEN 5 AND 20),
    cost NUMERIC(10,2),
    duration INT DEFAULT 45,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

-- Create group_of_sports table
CREATE TABLE group_of_sports (
    id INT PRIMARY KEY UNIQUE,
    level VARCHAR(50),
    day_in_the_week VARCHAR(20),
    start_time TIME,
    min_age INT DEFAULT 5,
    current_amount INT,
    teacher_id INT NOT NULL,
    sports_class_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id),
    FOREIGN KEY (sports_class_id) REFERENCES sports_class(id) ON DELETE CASCADE
);

-- Create participate_in relationship table (many-to-many between student and group_of_sports)
CREATE TABLE participate_in (
    student_id INT,
    group_id INT,
    PRIMARY KEY (student_id, group_id),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES group_of_sports(id) ON DELETE CASCADE
);

-- Create needs relationship table (many-to-many between equipment and sports_class)
CREATE TABLE needs (
    equipment_id INT,
    sports_class_id INT,
    quantity_required INT,
    PRIMARY KEY (equipment_id, sports_class_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(id),
    FOREIGN KEY (sports_class_id) REFERENCES sports_class(id) ON DELETE CASCADE
);

-- Add indexes for better query performance
CREATE INDEX idx_student_id ON student(id);
CREATE INDEX idx_teacher_id ON teacher(id);
CREATE INDEX idx_sports_class_location ON sports_class(location_id);
CREATE INDEX idx_group_teacher ON group_of_sports(teacher_id);
CREATE INDEX idx_group_sports_class ON group_of_sports(sports_class_id);
CREATE INDEX idx_participate_student ON participate_in(student_id);
CREATE INDEX idx_participate_group ON participate_in(group_id);
CREATE INDEX idx_needs_equipment ON needs(equipment_id);
CREATE INDEX idx_needs_sports_class ON needs(sports_class_id);