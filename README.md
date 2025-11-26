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





Stage B - Query Development and Data Integrity Management

📋 Overview

This stage is focusing on implementing comprehensive query operations, enforcing data integrity through constraints and triggers, and establishing robust transaction management practices.

What This Stage Represents
Stage 2 represents the operational layer of our database system. 

While Stage 1 established the foundational structure (tables, relationships, and initial data), Stage 2 brings the database to life by implementing the queries and logic that will be used in real-world scenarios. This stage transforms our static database structure into a dynamic, intelligent system capable of handling complex business operations while maintaining data consistency and integrity.

✔️Goals and Purpose:

The primary goals of Stage 2 are:

Query Implementation: Develop a comprehensive suite of selection queries that extract meaningful insights from the database, supporting various stakeholders including teachers, students, and management.

Data Manipulation Operations: Implement update and delete operations that modify data while respecting business rules and maintaining referential integrity.

Business Logic Enforcement: Add intelligent triggers that automatically enforce business rules, particularly around class capacity management and group status tracking.

Transaction Management: Demonstrate proper use of commit and rollback operations to ensure data consistency during complex operations.

Data Integrity: Document and validate all constraints that protect the database from invalid data states.

What Was Implemented During this stage:

8 comprehensive selection queries that provide detailed insights into various aspects of the sports class system

3 delete operations that safely remove outdated or invalid data

3 update operations that modify data based on complex business logic

Capacity management triggers that automatically track and enforce group enrollment limits

Transaction control demonstrations showing commit and rollback functionality

Complete constraint documentation explaining all data integrity rules

Updated CSV files reflecting the new trigger-based logic

A second database backup preserving the system state after Stage 2 completion


🔍 Selection Queries

This stage includes 8 carefully designed selection queries that serve different stakeholders and provide various insights into the sports class management system. 

Each query has been tested and documented with execution and result screenshots.

Query 1: 

Active Classes with Student Participation Analysis

Purpose: This query provides a comprehensive overview of all active sports classes in the system, focusing on enrollment statistics and financial performance.

What It Retrieves: The query gathers detailed information about each active sports class, including its name, capacity, cost, duration, and location. It calculates important metrics such as the total number of groups offering the class, total students enrolled across all groups, overall occupancy rate, the days when the class is offered, available skill levels, and total revenue generated by the class.

Business Logic: This query is essential for academic coordinators who need to monitor class performance. By filtering for classes with at least 2 groups and focusing on active status, it ensures we're looking at established, viable classes. The occupancy rate calculation helps identify which classes are most popular and which might need marketing attention. The revenue calculation provides immediate insight into each class's financial contribution to the organization.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 2: Monthly Revenue Analysis by Location and Sport Type

Purpose: This query breaks down revenue generation by location, sport type, and time period to support financial planning and budgeting.

What It Retrieves: The query extracts the city location, sport type (extracted from class names), enrollment month, quarter designation, number of active groups, total enrollments, average class cost, and projected revenue. It focuses on groups with at least 5 students to ensure meaningful data.

Business Logic: By organizing data by geographic location and time period, this query helps the financial team identify seasonal trends, understand which locations are most profitable, and determine which types of sports generate the most revenue. The quarter classification (Q1, Q2, Q3, Q4) makes it easy to compare performance across different periods of the year. The sport type extraction allows for category-level analysis even when individual classes have detailed names.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 3: Student Enrollment History with Age Analysis

Purpose: This query provides detailed information about student demographics, participation patterns, and spending behavior.

What It Retrieves: The query gathers student identification details, contact information, current age (in years and months), age group classification, number of classes enrolled, list of all enrolled classes, and total fees paid. It focuses on students enrolled in at least 2 classes to identify highly engaged students.

Business Logic: Understanding student demographics is critical for marketing and student services. By calculating exact ages and categorizing students into age groups (Young Kids, Pre-Teen, Teen, Adult), the system can identify which age demographics are most engaged. The multi-class enrollment filter helps identify "super users" who are highly invested in the program and might be good candidates for loyalty programs or testimonials.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 4: Equipment Utilization and Needs Assessment

Purpose: This query analyzes equipment inventory levels against actual requirements to support inventory management and procurement decisions.

What It Retrieves: The query provides equipment ID and name, current stock levels, number of classes requiring the equipment, total quantity needed across all classes, surplus or deficit calculation, stock status indicator (Urgent, Warning, or Sufficient), and a list of classes using the equipment.

Business Logic: Effective inventory management requires understanding not just how much equipment exists, but how it's being used across the entire system. By joining equipment data with class requirements and calculating the gap between supply and demand, this query identifies critical shortages that need immediate attention. The stock status classification provides a quick visual indicator for inventory managers to prioritize their purchasing decisions.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 5: Weekly Schedule Optimizer with Capacity Analysis

Purpose: This query provides a detailed view of the weekly class schedule with occupancy metrics to optimize facility usage and class timing.

What It Retrieves: The query displays day of the week, week segment classification, start time, class name, skill level, enrolled students, occupancy percentage, group status, teacher name, location name and city, and class duration. It organizes this information in chronological order by day and time.

Business Logic: Efficient scheduling maximizes facility utilization and teacher time while meeting student demand. By showing occupancy percentages alongside schedule information, this query helps identify time slots that are underutilized or overly crowded. The week segment classification groups days together to identify patterns (e.g., weekends vs. weekdays). This information is invaluable for facility managers who need to balance room availability with class demand.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 6: Student Engagement and Cross-Class Participation Analysis
Purpose: This advanced query analyzes student behavior patterns, engagement levels, and cross-class participation to support retention and marketing strategies.

What It Retrieves: The query segments students by age category and enrollment level, then calculates metrics including number of students in each category, total revenue generated by the category, popular classes within the category, number of cities represented, and multi-class engagement rate (percentage of students taking 2+ classes).

Business Logic: This query employs sophisticated segmentation to understand student behavior at a granular level. By combining demographic information (age) with behavioral data (enrollment patterns), it identifies which student segments are most valuable and engaged. The multi-class engagement rate is particularly important because students who take multiple classes typically have higher lifetime value and retention rates. The popular classes field helps identify which programs resonate with each demographic.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 7: Teacher Workload and Salary Efficiency Analysis

Purpose: This query analyzes teacher performance metrics to support human resources decisions, compensation reviews, and workload balancing.

What It Retrieves: The query provides teacher identification and name, monthly salary, hire year, years employed, number of groups teaching, total students taught, revenue generated, revenue-to-salary ratio, cost per student, and teaching days. It includes all teachers with at least one active group.

Business Logic: Teacher compensation should reflect both tenure and performance. This query calculates multiple efficiency metrics that help HR and management make informed decisions. The revenue-to-salary ratio indicates how much value each teacher generates relative to their cost. The cost-per-student metric helps understand the economics of different class sizes. Years employed provides context for salary levels and can inform retention strategies.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

Query 8: Comprehensive Location Performance Report

Purpose: This executive-level query provides a complete performance overview for each facility location, combining multiple metrics to support strategic planning.

What It Retrieves: The query aggregates location ID and name, city, facility capacity, total classes offered, total active groups, total students enrolled, average class cost, total revenue, average occupancy rate, number of unique teachers, revenue per class, and average students per group. It focuses on locations with significant enrollment (20+ students).

Business Logic: Location performance is a critical factor in expansion decisions, resource allocation, and strategic planning. This query uses nested subqueries to aggregate data from multiple sources and calculate high-level metrics. The revenue per class metric helps identify which locations are most profitable. The average occupancy rate indicates whether facilities are underutilized or overcrowded. The number of unique teachers shows staffing levels at each location.

📸 Documentation: Query execution screenshot and result output screenshot are available in the stage folder.

🗑️ Delete Operations

This stage implements 3 delete queries that safely remove outdated, unused, or underperforming data from the system while respecting referential integrity constraints.

Delete Query 1: Remove Equipment Not Required by Any Sports Class

Purpose: This delete operation removes equipment items that are no longer needed by any sports class in the current program offerings.

What It Does: The query identifies equipment that has no entries in the needs table (meaning no sports class requires it) and additionally verifies that no active groups are indirectly using this equipment. It then safely removes these unused equipment records from the database.

Why It's Necessary: Over time, as sports programs evolve, certain equipment may become obsolete or unnecessary. Keeping unused equipment in the database creates clutter, makes inventory management more difficult, and can lead to confusion during equipment ordering or audits. This delete operation ensures the equipment table accurately reflects only items that are actually part of the current program offerings.

Data Affected: Only equipment records that meet both criteria (not in the needs table AND not used by any active groups) are removed. This conservative approach ensures we never accidentally delete equipment that's still in use, even if the needs table isn't perfectly maintained.

Expected Change: The equipment table will be cleaned of obsolete items, making inventory reports more accurate and inventory management more efficient. The database size will be slightly reduced, and future queries on equipment will run faster without unused records.

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.

Delete Query 2: Remove Inactive Students with No Enrollments in Past Year

Purpose: This delete operation removes student records for individuals who have been inactive for an extended period, helping maintain a clean and current database.

What It Does: The query identifies students who have no enrollment activity in the past year (verified by checking teacher hire dates as a proxy for recent activity), are adults (18+ years old, to avoid removing minors who might return), and have been inactive for more than 6 months beyond turning 18. These student records are then removed from the system.

Why It's Necessary: Student databases can accumulate "dead" records over time—students who have graduated, moved away, or simply stopped participating. Maintaining records for inactive students serves no operational purpose and can skew analytics, complicate marketing efforts, and create privacy concerns. This operation archives outdated student data while being extremely conservative to avoid removing anyone who might return.

Data Affected: Only adult student records with zero recent participation are removed. The age and activity requirements ensure we never accidentally remove a child's record (who might return after a break) or an active student's record.

Expected Change: The student and person tables will be smaller and more manageable. Marketing lists will be more accurate, containing only active or recently active students. Database queries will perform slightly better without the overhead of inactive records.

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.

Delete Query 3: Remove Long-Standing Underperforming Sports Groups

Purpose: This delete operation removes groups that have existed for more than 6 months but never achieved active status (5+ students), freeing up teacher resources for more viable programs.

What It Does: The query identifies groups that meet two criteria: they've been running for over 6 months (calculated using teacher hire dates as a proxy for group age) AND they remain in PENDING status with fewer than 5 students. These consistently underperforming groups are then removed from the system.

Why It's Necessary: Some sports groups simply don't attract enough interest to be viable. Keeping these underperforming groups active ties up teacher time, occupies facility space, and creates false expectations for potential students who might see them listed. After 6 months, if a group hasn't reached the minimum 5-student threshold, it's unlikely to become viable without significant intervention. Removing these groups allows the organization to reallocate teacher effort to more successful programs or develop new offerings that might have better market fit.

Data Affected: Only groups that are both long-standing (6+ months) and underperforming (PENDING status, <5 students) are removed. This dual criteria ensures we're not removing new groups that just need time to grow, nor are we removing temporarily struggling groups that previously had good enrollment.

Expected Change: The group_of_sports table will reflect only viable, active programs. Teachers will have their schedules freed up to take on new groups with better prospects. The program catalog shown to prospective students will contain only classes that are truly available and running.

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.

🔄 Update Operations

This stage implements 3 update queries that modify data based on complex business logic, performance metrics, and operational requirements.

Update Query 1: Teacher Salary Adjustment Based on Performance Metrics

Purpose: This update operation adjusts teacher salaries based on a comprehensive set of performance metrics including tenure, student load, revenue generation, and engagement levels.

What It Does: The query analyzes each teacher's performance across multiple dimensions—years of employment, number of groups taught, total students, revenue generated, and seasonal activity patterns. Based on these metrics, it applies differential salary increases ranging from 3% (cost of living adjustment) to 15% (high performers with significant experience and student load).

Why It's Necessary: Fair, performance-based compensation is essential for teacher retention and motivation. Teachers who consistently perform well, take on larger student loads, and generate more revenue should be rewarded accordingly. This systematic approach ensures salary adjustments are based on objective data rather than subjective impressions, promoting fairness and transparency in compensation decisions.

Data Affected: The salary field in the teacher table is updated for all teachers who have at least one active group. Teachers receive different percentage increases based on their performance tier, calculated using date-based tenure calculations and enrollment metrics.

Expected Change: Teacher salaries will reflect their contributions more accurately. High performers will receive larger increases, incentivizing continued excellence. Even teachers with minimal activity receive a cost-of-living adjustment, ensuring no one's compensation falls behind inflation. The total salary expense will increase, but in a targeted way that rewards value creation.

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.

Update Query 2: Dynamic Class Pricing Based on Demand and Demographics

Purpose: This update operation adjusts sports class costs and durations based on market demand, student demographics, location competition, and enrollment patterns.

What It Does: The query analyzes each sports class across multiple factors—average occupancy rate, demand indicators (waitlist presence), student age demographics, time since class launch, and location competition. Based on these factors, it applies differential pricing adjustments ranging from a 10% discount (for struggling classes) to a 20% increase (for high-demand classes). It also adjusts session durations based on average student age.

Why It's Necessary: Static pricing doesn't reflect market realities. High-demand classes with waiting lists should be priced higher to optimize revenue, while struggling classes may need lower prices to attract students. The demographics-based pricing (higher for popular kids programs) reflects parents' willingness to pay premium prices for quality children's programming. Competition-based adjustments ensure the organization remains price-competitive in multi-provider locations.

Data Affected: The cost and duration fields in the sports_class table are updated based on complex calculations involving enrollment patterns, age demographics, and seasonal factors. Classes with different performance profiles receive different pricing adjustments.

Expected Change: Class pricing will better reflect market demand and value. High-demand classes will generate more revenue per student, while struggling classes will become more competitive. Session durations will be better matched to age group attention spans (shorter for young kids, longer for teens/adults). Overall revenue should increase as pricing better matches willingness to pay.

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.

Update Query 3: Equipment Inventory Replenishment and Reallocation

Purpose: This comprehensive update operation manages equipment inventory by calculating required quantities based on actual usage patterns, seasonal demand, and class requirements.

What It Does: The query performs a sophisticated analysis of equipment needs by examining the relationship between equipment, sports classes, active groups, and current student enrollment. It calculates shortages, identifies critical priorities, accounts for seasonal variations (peak months need more inventory), and considers class longevity. Based on this analysis, it adjusts equipment quantities through multiple rules covering critical shortages, high demand periods, moderate shortages, seasonal adjustments, and overstocking situations.

Why It's Necessary: Equipment availability directly impacts class operations—insufficient equipment can force enrollment caps or class cancellations, while overstocking ties up capital unnecessarily. Manual inventory management is time-consuming and error-prone. This automated approach ensures equipment quantities stay aligned with actual program needs, accounting for factors humans might overlook like seasonal variations and usage intensity.

Data Affected: The amount field in the equipment table is updated based on complex calculations involving usage data from the needs table, student enrollment from group_of_sports, and temporal factors like class age and current month. Different adjustment rules apply based on shortage severity and seasonal timing.

Expected Change: Equipment inventory will be optimally balanced—sufficient to meet all class needs without excessive overstocking. Critical shortages will be addressed with priority (150% of required quantity ordered), while overstocked items will be reduced to reasonable levels. The system will be prepared for seasonal demand spikes (fall and spring terms).

📸 Documentation: Execution screenshot and before/after database state screenshots are available in the stage folder.


✅ Commit and Rollback Examples

What Are Commit and Rollback?

In database systems, transactions are groups of operations that should be executed together as a single unit of work. 

Transaction control commands ensure that either all operations in a transaction complete successfully (maintaining data consistency), or none of them do (preventing partial updates that could corrupt data).

COMMIT: This command makes all changes in the current transaction permanent. Once committed, the changes are saved to the database and cannot be undone. It's like clicking "Save" in a document—the changes are now part of the permanent record.

ROLLBACK: This command undoes all changes made in the current transaction, returning the database to the state it was in before the transaction began. It's like clicking "Undo" or "Discard changes"—the database reverts to its previous state as if the attempted changes never happened.

Why Transaction Control Matters

Imagine you're transferring money between two bank accounts. The system needs to:

Subtract money from Account A

Add money to Account B

If the system crashes after step 1 but before step 2, money would disappear! Transaction control prevents this by ensuring both steps complete together (COMMIT) or both are cancelled (ROLLBACK) if anything goes wrong.

When Were They Demonstrated?

In this project stage, we demonstrated transaction control using Update Query 2 (Dynamic Class Pricing). This was an ideal scenario because:

Complexity: The update affects multiple records and involves complex calculations, making it a good candidate for transaction protection.
Business Impact: Pricing changes directly affect revenue and customer satisfaction, so we need the ability to review changes before making them permanent.

Testing: During development, we wanted to test the update logic multiple times without permanently modifying the database each time.

How It Was Demonstrated

The rollbackCommit.sql file contains Update Query 2 wrapped in transaction control commands:

BEGIN; -- Start transaction

[Update Query 2 code]

--ROLLBACK; -- Undo changes (commented out)

--COMMIT; -- Make changes permanent (commented out)


Testing Process:

BEGIN: Starts a transaction, creating a temporary workspace for changes

Execute UPDATE: The pricing adjustments are calculated and applied

Review Results: We can query the database to see what would change

Decision Point:

If results look good → Execute COMMIT to make changes permanent

If results look wrong → Execute ROLLBACK to undo everything

📸 Documentation: Screenshots showing database state before the transaction, after the update but before commit, and after commit/rollback are available in the stage folder.

🔒 Constraints Explanation

Important Note About Constraints

All constraints required for this project stage were already implemented during Stage 1 as part of the initial database structure creation. They are defined in the createTable.sql file that establishes the table schemas. Therefore, there is no separate Constraints.sql file in this stage.

However, constraints are a critical component of database integrity, so we'll explain each one in detail below.

What Are Constraints?

Constraints are rules enforced by the database management system that restrict the type of data that can be entered into tables. They ensure accuracy, reliability, and consistency of data. Think of constraints as "guardrails" that prevent the database from entering invalid states.

Constraints in Our System

1. PRIMARY KEY Constraints

What It Enforces: Every table has a PRIMARY KEY constraint on its id column, ensuring each record has a unique identifier and cannot be NULL.

Why It's Important: Primary keys are the foundation of database organization. They provide:

A guaranteed unique identifier for each record

A reliable way to reference specific records in relationships

Automatic indexing for fast lookups

Prevention of duplicate records

Examples in Our System:

person(id) - Uniquely identifies each person
sports_class(id) - Uniquely identifies each sports class
group_of_sports(id) - Uniquely identifies each group

Contribution to Data Integrity: Without primary keys, we couldn't reliably distinguish between two people named "John Smith" or two swimming classes. Primary keys guarantee that relationships (foreign keys) always point to exactly one record.

2. FOREIGN KEY Constraints

What They Enforce: Foreign keys ensure that references between tables always point to existing records. They maintain referential integrity by preventing "orphaned" records.

Why They're Important: Foreign keys create the relationships that make a relational database "relational." They ensure:

Child records always have valid parent records

Deletions cascade appropriately (or are prevented when inappropriate)
Data consistency across related tables

Meaningful join operations

Examples in Our System:

student(id) → person(id) with ON DELETE CASCADE

Ensures every student is also a valid person

When a person is deleted, their student record automatically deletes


teacher(id) → person(id) with ON DELETE CASCADE

Ensures every teacher is also a valid person

Maintains the supertype-subtype relationship


sports_class(location_id) → location(id)

Ensures every class has a valid location

Prevents classes from referencing non-existent facilities


group_of_sports(teacher_id) → teacher(id)

Ensures every group has a valid teacher assigned
Prevents orphaned groups with no instructor


group_of_sports(sports_class_id) → sports_class(id) with ON DELETE CASCADE

Ensures every group belongs to a valid sports class

When a class is deleted, its groups automatically delete


participate_in(student_id) → student(id) with ON DELETE CASCADE

Ensures participation records reference valid students

When a student leaves the system, their enrollments automatically delete


participate_in(group_id) → group_of_sports(id) with ON DELETE CASCADE

Ensures enrollments reference valid groups

When a group is cancelled, student enrollments automatically delete


needs(equipment_id) → equipment(id)

Ensures equipment requirements reference valid equipment

Prevents classes from requiring non-existent equipment


needs(sports_class_id) → sports_class(id) with ON DELETE CASCADE

Ensures equipment needs belong to valid classes

When a class is deleted, its equipment requirements automatically delete



Contribution to Data Integrity: Foreign keys prevent impossible situations like a student enrolled in a non-existent class, a group taught by a non-existent teacher, or a class located at a non-existent facility. The CASCADE options ensure cleanup happens automatically—when you delete a sports class, you don't have to manually delete all its groups, equipment needs, and enrollments.

3. CHECK Constraints

What They Enforce: Check constraints validate that data values meet specific logical conditions before being inserted or updated.

Why They're Important: Check constraints enforce business rules at the database level, providing:

Automatic validation without application code

Guaranteed rule enforcement regardless of which application accesses the database

Clear error messages when invalid data is attempted

Prevention of logically invalid states

Examples in Our System:

sports_class.capacity CHECK (capacity BETWEEN 5 AND 20)

Enforces: Class sizes must be between 5 and 20 students

Why: Classes with fewer than 5 students aren't economically viable; classes with more than 20 students are too large for effective instruction

Contribution: Prevents creation of classes that would be operationally impractical


group_of_sports.status CHECK (status IN ('PENDING', 'ACTIVE', 'FULL'))

Enforces: Group status must be one of three valid values

Why: These three states represent the complete lifecycle of a group

Contribution: Prevents typos or invalid status values that would break business logic



Contribution to Data Integrity: Check constraints encode business rules directly in the database structure. Even if someone writes custom application code or accesses the database directly, they cannot violate these fundamental rules. This provides defense-in-depth protection against data corruption.

4. NOT NULL Constraints

What They Enforce: NOT NULL constraints require that certain fields must have a value—they cannot be left empty.

Why They're Important: Some data is essential for a record to have meaning. NOT NULL constraints ensure:

Critical information is always provided

Queries and reports can rely on data being present

Business logic doesn't have to handle missing data in essential fields

Examples in Our System:

person.name NOT NULL

Enforces: Every person must have a name

Why: A person record without a name is meaningless

Contribution: Ensures all user interfaces can display a person's name without error handling


location.location_name NOT NULL

Enforces: Every location must have a name

Why: Locations need names for identification and display

Contribution: Ensures scheduling and reporting can always display where a class is held


sports_class.name NOT NULL

Enforces: Every class must have a name

Why: Classes need names for student registration and marketing

Contribution: Ensures all class listings are meaningful and displayable


sports_class.location_id NOT NULL

Enforces: Every class must have a location

Why: Classes must be held somewhere—a class without a location is impossible

Contribution: Ensures students always know where to go for class


group_of_sports.teacher_id NOT NULL

Enforces: Every group must have an assigned teacher

Why: Someone must instruct the class

Contribution: Prevents orphaned groups that couldn't actually operate


group_of_sports.sports_class_id NOT NULL

Enforces: Every group must belong to a sports class

Why: Groups are instantiations of classes—they must reference what they're an instance of

Contribution: Maintains the class-to-group relationship integrity


equipment.name NOT NULL

Enforces: Every piece of equipment must have a name

Why: Equipment needs identification for inventory management

Contribution: Ensures inventory reports are meaningful and complete



Contribution to Data Integrity: NOT NULL constraints prevent incomplete records that would be useless or confusing. They ensure that essential information is captured at creation time, rather than discovered to be missing later when it's needed.

5. UNIQUE Constraints

What They Enforce: UNIQUE constraints (often combined with PRIMARY KEY) ensure that no two records can have the same value in specific fields.

Why They're Important: Uniqueness prevents duplicate records and ensures identifiers actually identify. They provide:

Prevention of accidental duplicate data entry

Guarantee that identifier fields truly identify uniquely

Automatic indexing for fast lookups

Clear error messages when duplicates are attempted

Examples in Our System:

All primary key fields have implicit UNIQUE constraints (PRIMARY KEY = NOT NULL + UNIQUE):

person.id UNIQUE

student.id UNIQUE

teacher.id UNIQUE

location.id UNIQUE

equipment.id UNIQUE

sports_class.id UNIQUE

group_of_sports.id UNIQUE

Contribution to Data Integrity: UNIQUE constraints ensure that identifiers truly identify. Without them, two different people could have the same ID, making it impossible to know which person a student enrollment refers to. The combination of UNIQUE with PRIMARY KEY creates guaranteed, reliable identifiers throughout the system.

6. DEFAULT Constraints

What They Enforce: DEFAULT constraints provide automatic values when no value is specified during insertion.

Why They're Important: Defaults reduce data entry burden and ensure consistency by:

Providing sensible standard values automatically

Reducing the chance of forgetting to set important fields

Ensuring consistency in common scenarios

Simplifying insert operations

Examples in Our System:

sports_class.duration INT DEFAULT 45

Enforces: If no duration is specified, classes default to 45 minutes

Why: 45 minutes is the standard class length; this saves time during class creation

Contribution: Ensures classes have a duration even if not explicitly set


group_of_sports.min_age INT DEFAULT 5

Enforces: If no minimum age is specified, groups default to age 5

Why: Age 5 is the minimum age for most sports programs

Contribution: Provides a safe default that prevents very young children from being registered inappropriately


group_of_sports.current_amount INT DEFAULT 0

Enforces: New groups start with 0 students enrolled

Why: Groups are empty when first created

Contribution: Ensures accurate enrollment tracking from group creation


group_of_sports.status VARCHAR(20) DEFAULT 'PENDING'

Enforces: New groups start in PENDING status

Why: New groups haven't reached the 5-student minimum yet

Contribution: Ensures proper status tracking from group

Contribution to Data Integrity: DEFAULT constraints ensure fields have meaningful values even when not explicitly provided. They encode standard practices and common values, reducing errors and simplifying data entry.

Summary: How Constraints Protect Our Database

All these constraints work together to create a robust, self-protecting database that:

Prevents Invalid Data: Can't insert a student without a name, can't create a class with capacity of 100 students, can't assign a group to a non-existent teacher

Maintains Relationships: Foreign keys ensure child records always have valid parents, cascade deletes clean up related records automatically

Enforces Business Rules: Check constraints encode business logic directly in the database structure (class sizes, valid statuses)

Guarantees Completeness: NOT NULL constraints ensure critical information is always present

Prevents Duplicates: UNIQUE constraints ensure identifiers truly identify uniquely

Provides Sensible Defaults: DEFAULT constraints reduce data entry burden and ensure consistency

Together, these constraints create a database that is resilient, consistent, and trustworthy—the foundation for building reliable applications.

⚙️ Trigger Explanation

Overview

During Stage 2, we implemented a sophisticated capacity management trigger system that automatically tracks and enforces group enrollment limits. 

This trigger system is defined in the capacity_manage_system.sql file and represents one of the most important pieces of business logic in our sports class management system.

Why Was This Trigger Necessary? Without triggers, managing group capacity would require application code to:

Check current enrollment before adding a student

Update the current_amount field manually

Recalculate and update group status

Ensure consistency if multiple operations happen simultaneously

Handle all edge cases and error conditions

This approach is error-prone, inconsistent, and fragile. Different applications might implement the logic differently, leading to data inconsistencies. The trigger system ensures that capacity management happens automatically, consistently, and correctly regardless of how data is inserted or deleted.

Business Rules Enforced

The trigger system enforces three critical business rules:

Minimum Viable Group Size: Groups need at least 5 students to be considered "ACTIVE" and officially open. Below 5 students, a group remains "PENDING."

Maximum Capacity: Groups cannot exceed their sports class capacity (max 20 students). Once a group reaches capacity, it becomes "FULL" and no more students can join.

Dynamic Status Management: As students join or leave, group status must automatically update to reflect the current enrollment situation.

How the Trigger System Operates

The system consists of three interconnected triggers that work together:

Trigger 1: Prevent Students from Joining Full Groups (BEFORE INSERT)

When It Fires: Before a new record is inserted into the participate_in table (before a student joins a group).

What It Does:

Retrieves the sports class capacity for the group being joined

Checks the current number of students in that group

If adding the new student would exceed capacity, raises an exception and prevents the insert

If capacity is available, allows the insert to proceed

Why It's Important: This is the first line of defense. By checking capacity BEFORE the insert happens, we prevent invalid states from ever occurring. The error message includes specific details (group ID, capacity, current enrollment) to help users understand why the operation failed.

Example: If a swimming class has capacity 15 and currently has 15 students, attempting to add a 16th student will fail with a clear error message: "Cannot add student to group 5. Group is FULL (capacity: 15, current: 15)."

Trigger 2: Update Group Status After Student Joins (AFTER INSERT)

When It Fires: After a new record is successfully inserted into the participate_in table (after a student has joined a group).

What It Does:

Increments the current_amount field in group_of_sports by 1

Retrieves the sports class capacity for the group

Evaluates the new enrollment level and updates status:

If current_amount < 5 → Status = 'PENDING'

If current_amount >= capacity → Status = 'FULL'

Otherwise → Status = 'ACTIVE'



Why It's Important: This trigger automatically maintains accurate enrollment counts and status without requiring application code to do it manually. The status update is particularly valuable because it provides immediate visibility into group viability—administrators can instantly see which groups are officially open (ACTIVE), which need more students (PENDING), and which cannot accept more enrollments (FULL).

Example: When the 5th student joins a PENDING group, this trigger automatically changes the status to ACTIVE. When the 15th student joins a group with capacity 15, the status automatically changes to FULL.

Trigger 3: Update Group Status After Student Leaves (AFTER DELETE)

When It Fires: After a record is deleted from the participate_in table (after a student has left a group).

What It Does:

Decrements the current_amount field in group_of_sports by 1

Retrieves the sports class capacity for the group

Evaluates the new enrollment level and updates status:

If current_amount < 5 → Status = 'PENDING'

If current_amount >= capacity → Status = 'FULL'

Otherwise → Status = 'ACTIVE'



Why It's Important: Student withdrawals need the same careful status management as enrollments. When a student leaves, the group might drop below the minimum threshold (becoming PENDING again) or might open up a spot in a previously FULL group (becoming ACTIVE). This trigger ensures status stays accurate even as enrollments fluctuate.

Example: If a FULL group with 20 students loses one student, the trigger automatically changes the status back to ACTIVE, allowing new enrollments. If an ACTIVE group with 5 students loses one student, the trigger changes the status to PENDING since it's now below the minimum threshold.

Step-by-Step Operation Example

Let's walk through what happens when a student joins a group:

Initial State:

Group #7 (Intermediate Swimming) has 4 students, Status = 'PENDING'

The swimming class has capacity = 15

Student #45 Attempts to Join Group #7:

Application/User: Executes INSERT INTO participate_in (student_id, group_id) VALUES (45, 7);

Trigger 1 (BEFORE INSERT):

Checks: "Is group 7 full?"

Current amount = 4, Capacity = 15

Result: Not full, allow the insert to proceed


Database: The participate_in record is inserted

Trigger 2 (AFTER INSERT):

Updates: current_amount from 4 to 5

Evaluates: 5 < 15 (not full), 5 >= 5 (meets minimum)

Updates: Status from 'PENDING' to 'ACTIVE'


Final State:

Group #7 now has 5 students, Status = 'ACTIVE'

Group is now officially open and shows up in active group listings

All happened automatically with no additional code



Why This Design Choice?

Advantages of Using Triggers:

Automatic Enforcement: Rules are enforced regardless of which application accesses the database (web app, mobile app, direct SQL client)

Data Consistency: Impossible to have mismatched current_amount and status fields—triggers keep them synchronized

Atomic Operations: Changes happen as part of the insert/delete transaction—either everything succeeds or everything fails (no partial updates)

Centralized Logic: Business rules are in one place (the database), not scattered across multiple applications

Performance: Triggers execute on the database server without network round-trips

Reliability: Database-level logic is less prone to bugs than application-level code that might have race conditions or edge cases

Impact on CSV Files

The trigger implementation had a significant impact on our data files, specifically requiring us to rewrite two CSV files:

Why Rewrite Was Necessary

The original participate_in.csv and groupofsports.csv files were created before the trigger system existed. They contained:

Manual current_amount values that might not match actual participation records

Manual status values that might not reflect actual enrollment levels

Potential inconsistencies between the two files

Once triggers were implemented, these inconsistencies would cause problems:

If we imported old data with current_amount = 10 but only 8 students in participate_in, the triggers would maintain the wrong count

If we imported with status = 'ACTIVE' but only 3 students, the status would be wrong

The Rewrite Process

participate_in.csv was rewritten to:

Ensure all student-group relationships are valid

Match the group capacities and constraints

Create realistic enrollment patterns that would trigger proper status changes

groupofsports.csv was rewritten to:

Set all current_amount values to 0 initially

Set all status values to 'PENDING' initially

Let the triggers calculate the correct values when participate_in data is loaded

This approach ensures that when data is imported:

Groups start with current_amount = 0, status = 'PENDING'

Each participate_in insert triggers the update functions

Final current_amount and status values are calculated automatically

Data is guaranteed consistent because triggers enforced the rules

Benefits of This Approach

The trigger-based capacity management system provides several key benefits:

Data Integrity: Impossible to have inconsistent enrollment counts or status values

Simplified Application Code: Applications just insert/delete participation records—no need to manually manage counts or status

Real-Time Accuracy: Status updates happen immediately and automatically

Audit Trail: All changes are logged by the database trigger system

Scalability: Works correctly even with concurrent enrollments from multiple users

Business Intelligence: Views and reports can trust that status fields accurately reflect reality

User Experience: Students and administrators get immediate feedback about group availability


Integration with Other Features

The trigger system integrates seamlessly with other database features:

CASCADE Deletes: When a group is deleted, the foreign key cascades delete participation records, and the triggers handle cleanup

Views: The active_groups view can filter on status = 'ACTIVE' with confidence

Functions: The add_student_to_group() function relies on triggers to handle the details

Queries: All selection queries use current_amount and status values that are guaranteed accurate

This trigger system represents professional-grade database design—automated, reliable, and maintainable business logic that protects data integrity while simplifying application development.

🗄️ Database Backup

As part of Stage 2 completion, a second comprehensive backup of the database was performed and saved as backup2. This backup captures the complete state of the database after all Stage 2 operations:

All table structures with constraints

The capacity management trigger system

All data after query operations

Updated current_amount and status values maintained by triggers

All indexes for performance optimization

🎯 Conclusion
Stage 2 transforms our sports class management database from a static data repository into an intelligent, active system that enforces business rules, provides valuable insights, and maintains data integrity automatically. 

The combination of comprehensive queries, carefully designed update and delete operations, trigger-based automation, and transaction control creates a professional-grade database system ready for production use.













