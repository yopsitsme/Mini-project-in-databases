Submitters: Chana Perel Kats, Rachel Lea Izchaki


📘 Sports Class Management System


Stage 1 – System Specification and Implementation Files


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



 Stage 2 Documentation

🎯 Stage Overview

This stage focuses on data manipulation, business logic enforcement, and system intelligence. 

We moved beyond basic storage to create a dynamic system that actively maintains data quality and enforces business rules automatically.

Key Accomplishments:

✅ Implemented 8 comprehensive selection queries for business insights

✅ Created strategic update operations for automated adjustments

✅ Developed targeted delete operations for data cleanup

✅ Established automated trigger system for capacity management

✅ Demonstrated transaction management (commit/rollback)

✅ Enforced data integrity through comprehensive constraints

✅ Created second system backup for recovery support


📊 Selection Queries (8 Total)

🔹 Query 1: Total Class Revenue Analysis

Purpose: Calculate financial performance of each sports class

What it does:

Counts enrolled students per class

Multiplies student count by class cost

Provides both class-level and group-level revenue breakdown

Identifies most profitable classes and groups

Business Value: Essential for financial planning, pricing strategy, and understanding revenue sources

📸 Screenshots: Query execution and results available in project folder


🔹 Query 2: High-Performing Teachers Analysis

Purpose: Identify teachers with above-average student enrollment

What it does:

Compares each teacher's group sizes against system average

Shows total groups managed per teacher

Calculates cumulative students under each teacher's instruction

Includes teacher contact information

Business Value: Recognizes teaching talent, supports promotion decisions, and rewards excellence

📸 Screenshots: Query execution and results available in project folder


🔹 Query 3: Student Demographics & Enrollment Patterns

Purpose: Analyze enrollment across age groups, classes, and schedules

What it does:

Calculates current age for each student

Groups students by age demographics

Analyzes class preferences by age group

Reveals patterns in skill level and schedule preferences

Business Value: Enables targeted marketing, curriculum development, and strategic recruitment

📸 Screenshots: Query execution and results available in project folder


🔹 Query 4: Equipment Shortage Identification

Purpose: Flag situations where equipment demand exceeds supply

What it does:

Calculates total equipment needed across active groups

Compares requirements against current inventory

Identifies shortages and calculates deficit amounts

Prioritizes equipment procurement needs

Business Value: Prevents operational disruptions and guides purchasing decisions

📸 Screenshots: Query execution and results available in project folder


🔹 Query 5: Multi-Class Student Enrollment

Purpose: Identify students enrolled in multiple classes

What it does:

Tracks enrollment across different groups per student

Calculates total classes taken by each student

Sums combined fees per student

Highlights most engaged customers

Business Value: Supports loyalty programs, bundle discounts, and cross-selling opportunities

📸 Screenshots: Query execution and results available in project folder


🔹 Query 6: Location Capacity & Utilization

Purpose: Evaluate how effectively each facility is being used

What it does:

Analyzes student count, classes, and groups per location

Calculates utilization percentage against maximum capacity

Categorizes locations: "Near Capacity" (>80%), "Underutilized" (<40%), "Optimal"

Identifies over/underused facilities

Business Value: Guides facility expansion, class redistribution, and space optimization

📸 Screenshots: Query execution and results available in project folder


🔹 Query 7: Weekly Schedule Distribution

Purpose: Identify peak demand periods throughout the week

What it does:

Breaks down enrollment by day and hour

Counts concurrent groups and total students per time slot

Lists specific classes offered during each period

Reveals busiest and slowest times

Business Value: Optimizes staffing levels, balances workloads, identifies new class opportunities

📸 Screenshots: Query execution and results available in project folder


🔹 Query 8: Teacher Compensation vs Workload

Purpose: Evaluate if pay aligns with actual workload

What it does:

Calculates salary per group managed

Calculates salary per student taught

Shows years of employment (tenure)

Identifies compensation imbalances

Business Value: Ensures fair compensation, aids retention, supports budget planning

📸 Screenshots: Query execution and results available in project folder


🔄 Update Queries (3 Total)

🔸 Update 12: Teacher Salary Increase for High Performers

What it does:

Identifies teachers managing more groups than average

Requires minimum 2 years of employment

Applies 15% salary increase automatically

Rewards proven track records

Business Impact: Merit-based compensation, retention of talent, motivation for excellence

📸 Screenshots: Execution, before-state, and after-state available in project folder


🔸 Update 13: Equipment Inventory Replenishment

What it does:

Identifies equipment shortages across active classes

Calculates total demand from all active groups

Adds 150% of required quantity for buffer

Automatically increases inventory levels

Business Impact: Prevents operational disruptions, ensures adequate class materials, reduces manual tracking

📸 Screenshots: Execution, before-state, and after-state available in project folder


🔸 Update 14: Dynamic Pricing for Low-Enrollment Classes

What it does:

Identifies classes with consistently low enrollment (<50% capacity)

Requires multiple groups showing low enrollment

Applies 15% cost reduction

Makes underperforming classes more attractive

Business Impact: Boosts enrollment, maximizes facility use, prevents class cancellations

📸 Screenshots: Execution, before-state, and after-state available in project folder


🗑️ Delete Queries (3 Total)

🔸 Delete 9: Unused Equipment Removal

What it does:

Identifies equipment not required by any sports class

Verifies no direct requirements in needs table

Confirms no indirect usage through active groups

Removes obsolete inventory items

Business Impact: Maintains lean inventory, improves accuracy, simplifies management

📸 Screenshots: Execution, before-state, and after-state available in project folder


🔸 Delete 10: Inactive Student Record Cleanup

What it does:

Targets students only in pending groups (<5 students)

Ensures no enrollment in any active groups

Removes incomplete registrations

Cleans up failed group formations

Business Impact: Accurate student records, simplified database, cleaner reporting

📸 Screenshots: Execution, before-state, and after-state available in project folder


🔸 Delete 11: Invalid Person Record Removal

What it does:

Identifies records with missing/invalid email and phone

Ensures person is not a student or teacher

Removes data entry errors and incomplete registrations

Maintains only valid stakeholder records

Business Impact: Improved data quality, reduced confusion, ensured contact validity

📸 Screenshots: Execution, before-state, and after-state available in project folder

💾 Transaction Management: Commit & Rollback

What Are Transactions?

A transaction is a complete unit of work that either:

✅ Succeeds entirely (all changes applied) - COMMIT

❌ Fails entirely (all changes undone) - ROLLBACK

Why This Matters

Benefits:

🛡️ Provides safety mechanism before permanent changes

🔍 Allows review and verification of results

⏪ Enables complete undo if errors detected

🎯 Prevents data corruption and maintains integrity

💪 Provides confidence for complex operations

Real-World Use:

Begin transaction

Execute update/delete operation

Review results

If correct → COMMIT (make permanent)

If incorrect → ROLLBACK (undo completely)

📸 Screenshots: Database state during transaction execution available in project folder


🔒 Database Constraints

⚠️ Important Note

Constraints were implemented in Stage 1 within the createTable.sql file.

No separate constraints file exists for Stage 2 — but they're essential for all operations in this stage.


🔑 Primary Key Constraints
What they do:

Ensure unique identification for every record

Prevent duplicate entries

Enable reliable table relationships

Example: person.id is unique — no two people share the same ID

Why it matters: Foundation for all data retrieval and referencing


🔗 Foreign Key Constraints

What they do:

Establish relationships between tables

Enforce referential integrity

Prevent orphaned records

Handle cascading deletes automatically

Example: Every group must have a valid teacher and sports class

Why it matters: Maintains logical consistency across entire database


✓ Check Constraints

What they do:

Enforce business rules at database level

Prevent invalid data entry

Ensure realistic values

Example: Class capacity must be between 5 and 20 students

Why it matters: Protects business model from operational impossibilities


❗ NOT NULL Constraints

What they do:

Require critical information to be provided

Prevent incomplete records

Ensure essential data is never missing

Example: Every person must have a name, every class must have a location

Why it matters: Protects against data entry errors and incomplete information


🎯 Default Value Constraints

What they do:

Provide sensible initial values

Simplify data entry

Ensure consistent starting states

Examples:

New groups start with current_amount = 0

Class duration defaults to 45 minutes

Why it matters: Reduces explicit value requirements, ensures predictable behavior


⚙️ Capacity Management Trigger System - will be explained again in stage 4

🎯 Why the Trigger Was Necessary

The Problem:

Groups need minimum 5 students to officially open
Groups cannot exceed maximum capacity (20)
Status must update automatically with enrollment changes
Manual tracking would be error-prone and time-consuming

The Solution: Automated trigger system that enforces rules without human intervention


🔄 How the Trigger System Works

Trigger 1: Before Insert Validation

When: Student attempts to join a group

What it does:

✋ Checks if group is already FULL

🚫 Blocks enrollment if at capacity

⚠️ Returns clear error message

✅ Prevents overbooking before it happens


Trigger 2: After Insert Status Update

When: Student successfully joins a group

What it does:

➕ Increments current_amount by 1

🔄 Recalculates group status:

<5 students → PENDING

5-19 students → ACTIVE ✅

20 students → FULL 🔒

📢 Automatically opens groups when they reach 5

🔒 Automatically closes groups when they reach capacity


Trigger 3: After Delete Status Update

When: Student leaves a group

What it does:

➖ Decrements current_amount by 1

🔄 Recalculates group status:

If drops below 5 → Changes to PENDING

If no longer at capacity → Changes from FULL to ACTIVE

🔓 Reopens enrollment opportunities automatically


💡 Benefits & Design Rationale

Key Advantages:

🤖 Automatic Enforcement - Rules apply regardless of application or user

⚡ Real-Time Accuracy - Status always reflects current enrollment

🛡️ Data Integrity - Prevents impossible states

🎯 Simplified Logic - Applications just insert/delete; database handles validation

📊 Clear History - Status column shows group evolution over time


📝 Impact on Data Files

The trigger system required modifications to initial data:

participate.csv - Rewritten

Why: Original enrollments may have violated new capacity rules

Changes: Regenerated with valid enrollment patterns that properly test:

PENDING groups (<5 students)

ACTIVE groups (5-19 students)

FULL groups (20 students)

groupofsports.csv - Rewritten

Why: Needed to include new status column with proper initial values

Changes:

Added status column

Aligned enrollment counts with appropriate status

Ensured consistent starting states


🔧 Supporting Components

Views Created:

📋 active_groups - Shows only officially operational groups

📊 all_groups_with_status - Administrative view with complete status info

Function Created:

🎯 add_student_to_group() - Safe enrollment with validation and clear messages


💾 System Backup

Backup 2 Created ✅

📦 Complete database backup after Stage 2 implementation

🎯 Captures trigger system, updated data files, all constraints

🔄 Enables restoration to this specific milestone

📚 Documents database evolution across development phases


✨ Conclusion

Stage 2 Achievements:

📈 Transformed database from simple storage to intelligent system

🤖 Automated business rule enforcement

🔍 Comprehensive analytics and reporting capabilities

🛡️ Robust data protection and validation

📊 Self-maintaining operational database

📸 Complete documentation through screenshots

Result: A production-ready system that actively protects data quality and provides valuable business insights.







