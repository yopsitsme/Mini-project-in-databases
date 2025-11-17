Submitters: Chana Perel Kats, Rachel Lea Izchaki


📘 Sports Class Management System


Stage A – System Specification and Implementation Files


🏁 Introduction

The Sports Class Management System is designed to manage all information related to sports classes efficiently.

It supports handling of students, teachers, class groups, equipment, and locations — enabling structured data management and easy tracking of participants, class schedules, costs, and resource allocation.

The main functionalities include:

Registration management for students.

Scheduling and management of sports classes.

Tracking and assigning teachers and equipment to specific groups.

Managing locations and capacity for different activities.

Maintaining data consistency and supporting data backup and recovery.

🧩 System Description

Main Entities

Person (super-type)

Student – ID, name, address, email, phone, date of birth.

Teacher – ID, name, date of birth, email, phone, hire date, salary.

Sports Class – ID, name, cost, duration, number of participants.

Group of Sports Classes – ID, level, day, start time, min age, current participants.

Location – ID, location name, city, capacity.

Equipment – ID, name, quantity.

Main Relationships

Students participate in sports class groups (many-to-many).

Teachers teach specific groups (one-to-many).

A sports class takes place at one location (many-to-one).

A sports class needs certain equipment (many-to-many).

Each sports class belongs to a sports class group (many-to-one).

🧠 Design Decisions

The Person entity was defined as a super-type to prevent data duplication and ensure scalability.

Many-to-Many relationships (e.g., Students ↔ Groups, Classes ↔ Equipment) were resolved using junction tables.

Primary keys are numeric and auto-incremented for simplicity and data integrity.

The foreign keys ensure referential integrity between related entities.

The DSD diagram was built based on the final normalized structure (up to 3NF).

📊 ERD and DSD Diagrams

The following diagrams are included in the submission:

ERD Diagram: Logical model showing all entities and relationships.

DSD Diagram: Physical database structure including table names, attributes, and key constraints.


💾 Data Insertion Methods
The system implements three comprehensive data-insertion methods, each fully documented and tested to ensure reproducibility and flexibility. 

All methods have been executed successfully and organized into dedicated folders with complete supporting files.

1️⃣ CSV-Based Data Import

This method leverages CSV files as the primary data source, enabling efficient bulk loading into the database.

Process:

Dedicated CSV files were created for each table in the database.
Each file includes realistic sample data
Using PostgreSQL's built-in Import tool, each CSV file is loaded directly into its corresponding table
PostgreSQL internally converts imported rows into INSERT operations, efficiently populating the database

Documentation:

All CSV files are located in the DataImportFiles folder

Best Use Case: Ideal for loading structured bulk data from external sources or existing datasets.

2️⃣ Automated SQL Generation Using Python

A Python program was developed to automatically generate realistic SQL INSERT statements, streamlining the creation of large test datasets.

Process:

The script generates realistic random data including names, addresses, phone numbers, emails, and birthdates
SQL statements are created for multiple tables: person, student, and participate_in
The program outputs a complete .sql file containing hundreds of ready-to-execute INSERT commands
This SQL file can be directly executed in PostgreSQL to populate the database

Documentation:

All Python source code is located in the Programming folder
The generated SQL file (with all insert statements) is included for reference

Best Use Case: Perfect for creating large, realistic datasets for testing, demonstration, or development purposes.

3️⃣ Manual SQL INSERT File

A traditional SQL insert file provides a straightforward method for baseline data population.

Process:

The file insertTables.sql contains manually written INSERT commands
Includes comprehensive sample data for all major entities:

Students

Teachers

Sports classes

Class groups

Equipment

Locations


Can be executed directly in any SQL environment without additional tools

Documentation:

Located in the SQL_Inserts folder (or root project directory)

Best Use Case: Ideal for clear examples, controlled baseline data, and scenarios where automation tools are unavailable.


🗄️ Backup and Restore

Data Backup Process – Exporting the full database schema and data.

Data Restore Process – Importing the backup file and verifying the restored database.















