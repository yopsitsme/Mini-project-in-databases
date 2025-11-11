-- Script to delete all data from tables (empty the tables without dropping them)
-- Delete in reverse order of dependencies to avoid foreign key constraint violations

-- Delete from junction tables first
DELETE FROM needs;
DELETE FROM participate_in;

-- Delete from tables with foreign keys
DELETE FROM group_of_sports;
DELETE FROM sports_class;

-- Delete from subtype tables
DELETE FROM student;
DELETE FROM teacher;

-- Delete from independent tables
DELETE FROM person;
DELETE FROM location;
DELETE FROM equipment;

