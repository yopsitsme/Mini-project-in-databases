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

Three different data insertion methods were implemented as required:

Manual SQL Inserts:

Implemented in insertTables.sql.

Inserts sample data into all relevant tables.

Programming-Based Insertion:

Implemented via code in the Programming folder.

The program generates and executes SQL INSERT statements automatically.

Includes both source code and output examples.

Data Import from Files:

Implemented via the DataImportFiles folder.

Includes configuration files and CSV data sources used for import.

Each folder contains the files relevant to the chosen insertion method.

🗄️ Backup and Restore

Data Backup Process – Exporting the full database schema and data.

Data Restore Process – Importing the backup file and verifying the restored database.















