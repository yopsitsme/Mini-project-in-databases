-- insertTables.sql
-- Insert sample data into all tables (3 records per table)

-- Insert into person table
INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (1, 'David Cohen', '2005-03-15', 'david.cohen@email.com', '050-1234567');

INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (2, 'Sarah Levi', '2008-07-22', 'sarah.levi@email.com', '052-9876543');

INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (3, 'Michael Ben-Ami', '1985-11-30', 'michael.benami@email.com', '054-5551234');

INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (4, 'Yael Mizrahi', '2010-01-12', 'yael.mizrahi@email.com', '053-7778899');

INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (5, 'Rachel Stern', '1980-05-18', 'rachel.stern@email.com', '050-3334455');

INSERT INTO person (id, name, birth_date, email, phone) 
VALUES (6, 'Avi Goldstein', '1978-09-25', 'avi.goldstein@email.com', '052-6667788');

-- Insert into student table
INSERT INTO student (id, addres) 
VALUES (1, 'Rothschild 25, Tel Aviv');

INSERT INTO student (id, addres) 
VALUES (2, 'Herzl 18, Jerusalem');

INSERT INTO student (id, addres) 
VALUES (4, 'HaNassi 42, Haifa');

-- Insert into teacher table
INSERT INTO teacher (id, salary, hire_date) 
VALUES (3, 12000.00, '2020-09-01');

INSERT INTO teacher (id, salary, hire_date) 
VALUES (5, 15000.00, '2018-03-15');

INSERT INTO teacher (id, salary, hire_date) 
VALUES (6, 13500.00, '2019-06-20');

-- Insert into location table
INSERT INTO location (id, location_name, city, capacity) 
VALUES (1, 'Sports Center North', 'Tel Aviv', 200);

INSERT INTO location (id, location_name, city, capacity) 
VALUES (2, 'Community Hall South', 'Jerusalem', 150);

INSERT INTO location (id, location_name, city, capacity) 
VALUES (3, 'Athletic Complex East', 'Haifa', 300);

-- Insert into equipment table
INSERT INTO equipment (id, name, amount) 
VALUES (1, 'Soccer Ball', 25);

INSERT INTO equipment (id, name, amount) 
VALUES (2, 'Basketball', 20);

INSERT INTO equipment (id, name, amount) 
VALUES (3, 'Yoga Mat', 30);

-- Insert into sports_class table
INSERT INTO sports_class (id, name, capacity, cost, duration, location_id) 
VALUES (1, 'Soccer Training', 15, 250.00, 60, 1);

INSERT INTO sports_class (id, name, capacity, cost, duration, location_id) 
VALUES (2, 'Basketball Basics', 12, 200.00, 45, 2);

INSERT INTO sports_class (id, name, capacity, cost, duration, location_id) 
VALUES (3, 'Yoga for Kids', 10, 180.00, 50, 3);

-- Insert into group_of_sports table
INSERT INTO group_of_sports (id, level, day_in_the_week, start_time, min_age, current_amount, teacher_id, sports_class_id) 
VALUES (1, 'Beginner', 'Sunday', '16:00:00', 8, 0, 3, 1);

INSERT INTO group_of_sports (id, level, day_in_the_week, start_time, min_age, current_amount, teacher_id, sports_class_id) 
VALUES (2, 'Intermediate', 'Tuesday', '17:00:00', 10, 0, 5, 2);

INSERT INTO group_of_sports (id, level, day_in_the_week, start_time, min_age, current_amount, teacher_id, sports_class_id) 
VALUES (3, 'Beginner', 'Thursday', '15:30:00', 5, 0, 6, 3);

-- Insert into participate_in table (junction table)
INSERT INTO participate_in (student_id, group_id) 
VALUES (1, 1);

INSERT INTO participate_in (student_id, group_id) 
VALUES (1, 2);

INSERT INTO participate_in (student_id, group_id) 
VALUES (2, 2);

INSERT INTO participate_in (student_id, group_id) 
VALUES (4, 3);

-- Insert into needs table (junction table)
INSERT INTO needs (equipment_id, sports_class_id, quantity_required) 
VALUES (1, 1, 15);

INSERT INTO needs (equipment_id, sports_class_id, quantity_required) 
VALUES (2, 2, 12);

INSERT INTO needs (equipment_id, sports_class_id, quantity_required) 
VALUES (3, 3, 10);