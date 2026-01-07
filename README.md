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


# 🔄 Database Integration Project - Stage 3
## Comprehensive System Integration Documentation

## 🎯 Project Overview

### Objective
This stage focused on **database integration** - merging two independent systems into a unified, cohesive database structure. The challenge was to combine our **Sports Enrollment System** with a received **Activities Management System** while maintaining data integrity and operational functionality.

### Source Systems

#### 🏀 System A: Sports Enrollment System (Our Original)
**Database:** `BD_Proj_5494_2032` (backup2.sql)
- **Primary Focus:** Sports class management and enrollment tracking
- **Key Entities:** Sports classes, enrollment groups, teachers, students, locations
- **Core Functionality:** Class scheduling, capacity management, revenue tracking
- **Unique Features:** Real-time enrollment status, capacity-based triggers

#### 🎨 System B: Activities Management System (Received)
**Database:** `full_backup.sql`
- **Primary Focus:** Educational activities and program coordination  
- **Key Entities:** Activities (Dance, Piano, etc.), groups, instructors, grade levels
- **Core Functionality:** Activity scheduling, instructor assignments, room management
- **Unique Features:** Grade-level targeting, weekly session scheduling

---

## 🔄 Integration Process

### Phase 1: Reverse Engineering 📐

#### ✏️ Step 1: DSD Creation
We received the backup file from the partner team and reconstructed their **Database Schema Diagram (DSD)** by analyzing:
- Table structures and column definitions
- Primary and foreign key relationships
- Data types and constraints
- Existing indexes and triggers

#### ✏️ Step 2: ERD Reconstruction  
From the DSD, we performed **reverse engineering** to create the conceptual **Entity-Relationship Diagram (ERD)**, identifying:
- Core entities and their attributes
- Relationship types (one-to-one, one-to-many, many-to-many)
- Cardinality and participation constraints
- Business rules embedded in the schema

### Phase 2: Integration Design 🎨

#### ✏️ Step 3: ERD Analysis
At this point, we had **two complete ERDs**:
- Our original Sports System ERD
- The reconstructed Activities System ERD

#### ✏️ Step 4: Combined ERD Design
We designed a **unified ERD** that merged both systems, making critical design decisions:

**Key Integration Decisions:**

| Decision Area |       Approach        | Rationale |
|---------------|-----------------------|-----------|
| **Person Entity** | Created inheritance hierarchy | Both systems had people entities (students, teachers, parents, instructors) - unified under common Person base |
| **Location Management** | School-centric model | Merged location concepts - renamed to `school_name` to reflect educational context |
| **Group Structure** | Unified Group_Of_Sports | Combined `group_of_sports` and `grps` tables with offset IDs to prevent conflicts |
| **Scheduling** | Centralized Group_Details | Extracted scheduling from multiple sources into dedicated `Group_Details` table |
| **Year Groups** | Added to all groups | Extended our system with year group concept from received system |
| **ID Strategy** | Offset-based migration | Applied systematic offsets (10000, 20000, 30000) to prevent primary key conflicts |

---

## ⚙️ Technical Implementation

### Phase 3: Database Transformation 🔨

#### ✅ Stage 1: Person Hierarchy Transformation

**Objective:** Create a unified person entity with proper inheritance structure

**Implementation Steps:**

1. **Name Decomposition** 📝
   ```sql
   -- Split full names into first_name and last_name
   UPDATE Person SET 
       first_name = SPLIT_PART(name, ' ', 1),
       last_name = SUBSTRING(name FROM POSITION(' ' IN name) + 1)
   ```
   - **Why:** Different naming conventions required standardization
   - **Impact:** Unified person data format across both systems

2. **ID Standardization** 🔑
   ```sql
   -- Rename columns for consistency
   ALTER TABLE Person RENAME COLUMN id TO personId;
   ALTER TABLE Student RENAME COLUMN id TO studentId;
   ALTER TABLE Teacher RENAME COLUMN id TO teacherId;
   ```
   - **Why:** Entity-specific naming improves clarity
   - **Impact:** Self-documenting foreign key relationships

3. **Parent Integration** 👨‍👩‍👧
   ```sql
   -- Migrate parents to Person hierarchy with offset
   INSERT INTO Person (personId, first_name, last_name, email, phone)
   SELECT parentId + 10000, first_name, last_name, email, phone
   FROM Parent
   ```
   - **Offset Used:** +10000 for all parent IDs
   - **Why:** Prevents ID collision with existing Person records
   - **Result:** Parents now inherit from Person entity

4. **Student Migration** 🎓
   ```sql
   -- Import students from backup2 with offset
   INSERT INTO Person (personId, first_name, last_name, birth_date)
   SELECT student_id + 20000, first_name, last_name, birth_date
   FROM temp_students
   ```
   - **Offset Used:** +20000 for all student IDs
   - **Why:** Separates student ID space from parents and original persons
   - **Result:** All students accessible through Person table

5. **Instructor Integration** 👨‍🏫
   ```sql
   -- Migrate instructors to Teacher entity
   INSERT INTO Person (personId, first_name, last_name, email, phone)
   SELECT instructor_id + 30000, first_name, last_name, email, phone
   FROM temp_instructors
   
   INSERT INTO Teacher (teacherId, specialty)
   SELECT instructor_id + 30000, specialty
   FROM temp_instructors
   ```
   - **Offset Used:** +30000 for all instructor IDs
   - **Why:** Unifies teaching staff under single Teacher entity
   - **Benefit:** Added specialty field from received system to our Teacher table

#### ✅ Stage 2: Location and Scheduling Transformation

**Objective:** Unify location concepts and centralize scheduling information

**Implementation Steps:**

1. **Location Unification** 🏫
   ```sql
   -- Rename to reflect school-centric model
   ALTER TABLE Location RENAME COLUMN location_name TO school_name;
   ```
   - **Why:** Both systems had location entities with different semantics
   - **Decision:** Adopted school-centric terminology as more descriptive

2. **Scheduling Centralization** 📅
   ```sql
   -- Rename and restructure scheduling table
   ALTER TABLE weeklysessions RENAME TO Group_Details;
   ALTER TABLE Group_Details RENAME COLUMN session_id TO timeId;
   ```
   - **Why:** Scheduling was scattered across multiple tables
   - **Result:** Single source of truth for all group schedules

3. **Group ID Standardization** 🔢
   ```sql
   -- Standardize group identification
   ALTER TABLE Group_Of_Sports RENAME COLUMN id TO groupId;
   ```
   - **Why:** Consistent naming convention across all entities
   - **Benefit:** Improved code readability and maintainability

#### ✅ Stage 3: Group and Enrollment Integration

**Objective:** Merge group structures and preserve all enrollment data

**Implementation Steps:**

1. **Group Migration** 🏃
   ```sql
   -- Import groups from received system with offset
   INSERT INTO Group_Of_Sports (groupId, teacher_id, sports_class_id, yeargroup_id)
   SELECT 
       group_id + 2000,           -- Offset to prevent conflicts
       instructor_id + 30000,      -- Link to migrated instructors
       activity_id,                -- Map activities to sports classes
       yeargroup_id                -- Preserve grade level associations
   FROM temp_grps
   ```
   - **Offset Used:** +2000 for all imported group IDs
   - **Why:** Prevents collision with existing group records
   - **Key Mapping:** Activities → Sports Classes (direct mapping, no offset needed)

2. **Schedule Migration** ⏰
   ```sql
   -- Move scheduling data from Group_Of_Sports to Group_Details
   INSERT INTO Group_Details (group_id, day_of_week, start_time)
   SELECT groupId, day_in_the_week, start_time
   FROM Group_Of_Sports
   WHERE day_in_the_week IS NOT NULL
   ```
   - **Why:** Normalize scheduling to dedicated table
   - **Result:** Clean separation of group metadata and timing

3. **Enrollment Integration** 📝
   ```sql
   -- Preserve student enrollments from both systems
   INSERT INTO Participate_In (studentId, groupId, enrollment_date)
   SELECT 
       student_id + 20000,  -- Reference migrated students
       group_id + 2000,     -- Reference migrated groups
       enrollment_date      -- Preserve historical data
   FROM temp_studentgroups
   ```
   - **Result:** All enrollments preserved with full history
   - **Validation:** Triggers ensure capacity constraints still respected

#### ✅ Stage 4: Relationship Establishment

**Objective:** Create proper foreign key relationships for data integrity

**Implementation Steps:**

1. **Year Group Integration** 🎯
   ```sql
   -- Add year group support to all groups
   ALTER TABLE Group_Of_Sports ADD COLUMN yeargroup_id INTEGER;
   ALTER TABLE Group_Of_Sports ADD CONSTRAINT group_yeargroup_fkey 
       FOREIGN KEY (yeargroup_id) REFERENCES yeargroups(yeargroup_id);
   ```
   - **Why:** Received system had grade-level targeting we wanted to adopt
   - **Benefit:** Groups now properly categorized by student age/grade

2. **Location-Year Group Bridge** 🌉
   ```sql
   -- Create many-to-many relationship table
   CREATE TABLE Takes_Place (
       yeargroup_id INTEGER NOT NULL,
       location_id INTEGER NOT NULL,
       PRIMARY KEY (yeargroup_id, location_id)
   );
   
   -- Populate all combinations (all grades at all locations)
   INSERT INTO Takes_Place (yeargroup_id, location_id)
   SELECT yg.yeargroup_id, l.id
   FROM yeargroups yg CROSS JOIN Location l;
   ```
   - **Why:** Year groups can be offered at multiple locations
   - **Design Choice:** Initially populated with all combinations (can be refined later)

3. **Student-Parent Linking** 👪
   ```sql
   -- Establish parent relationship
   ALTER TABLE Student ADD COLUMN parentId INTEGER;
   ALTER TABLE Student ADD CONSTRAINT student_parent_fkey 
       FOREIGN KEY (parentId) REFERENCES Parent(parentId);
   ```
   - **Result:** Students properly linked to their parents in unified hierarchy

#### ✅ Stage 5: Business Logic Migration

**Objective:** Preserve and update triggers for capacity management

**Implementation Steps:**

1. **Capacity Check Trigger** 🚦
   ```sql
   CREATE TRIGGER trg_check_capacity_before_insert
   BEFORE INSERT ON Participate_In
   FOR EACH ROW EXECUTE FUNCTION check_group_capacity_before_insert();
   ```
   - **Purpose:** Prevent over-enrollment in groups
   - **Updated:** Column names changed to match new schema (groupId, studentId)

2. **Status Update Triggers** 📊
   ```sql
   CREATE TRIGGER trg_insert_participate
   AFTER INSERT ON Participate_In
   FOR EACH ROW EXECUTE FUNCTION update_group_status_on_insert();
   
   CREATE TRIGGER trg_delete_participate
   AFTER DELETE ON Participate_In
   FOR EACH ROW EXECUTE FUNCTION update_group_status_on_delete();
   ```
   - **Purpose:** Automatically manage group status (PENDING/ACTIVE/FULL)
   - **Logic:** 
     - PENDING: < 5 students
     - ACTIVE: 5+ students, below capacity
     - FULL: at capacity

3. **Performance Optimization** ⚡
   ```sql
   -- Create indexes on all foreign keys
   CREATE INDEX idx_group_teacher ON Group_Of_Sports(teacher_id);
   CREATE INDEX idx_participate_student ON Participate_In(studentId);
   CREATE INDEX idx_student_parent ON Student(parentId);
   ```
   - **Why:** Large joined tables require indexing for performance
   - **Result:** Query performance maintained despite increased data volume

---

## 📊 Views and Queries

### View Design Philosophy 🎨

We created **two analytical views**, one representing each original system's perspective:
- Views abstract complex joins into simple, queryable interfaces
- Each view combines multiple tables to provide business-relevant insights
- Queries demonstrate practical use cases for system stakeholders

---

### 🏀 View 1: Sports Enrollment Analysis
**Perspective:** Original Sports System

#### 📋 View Definition

```sql
CREATE VIEW sports_enrollment_analysis AS
SELECT 
    g.groupId,
    sc.name AS class_name,           
    g.level,                          
    g.status,                        
    g.current_amount,            
    sc.capacity,                  
    sc.capacity - g.current_amount AS spots_left,  -- Available openings
    sc.cost,                          
    p.first_name || ' ' || p.last_name AS teacher_name,
    p.email AS teacher_email,
    l.school_name,           
    l.city,
    gd.day_of_week,            
    gd.start_time                  
FROM Group_Of_Sports g
INNER JOIN Sports_Class sc ON g.sports_class_id = sc.id
INNER JOIN Teacher t ON g.teacher_id = t.teacherId
INNER JOIN Person p ON t.teacherId = p.personId
INNER JOIN Takes_Place tp ON g.yeargroup_id = tp.yeargroup_id
INNER JOIN Location l ON tp.location_id = l.id
INNER JOIN Group_Details gd ON g.groupId = gd.group_id;
```

#### 🎯 View Purpose
Provides a **complete enrollment management dashboard** combining:
- Class offerings and capacity
- Real-time availability tracking
- Teacher assignments
- Location and schedule details
- Revenue information

#### 💡 Business Value
- **Customer Service:** Quickly find available classes for prospective students
- **Operations:** Monitor capacity utilization across locations
- **Finance:** Calculate revenue potential and enrollment trends
- **Management:** Assess teacher workload and location performance

---

#### 🔍 Query 1.1: Available Classes Report

**Purpose:** Find all active classes currently accepting enrollments

```sql
SELECT 
    class_name,          
    level,               
    day_of_week,         
    start_time,           
    current_amount,    
    spots_left,           
    cost,               
    teacher_name,     
    school_name,         
    city            
FROM sports_enrollment_analysis
WHERE status = 'ACTIVE'               -- Must be active (not pending/full)
    AND spots_left > 0                -- Must have openings
ORDER BY spots_left DESC, cost;       -- Most available first, then by price
```

**Use Case:** Customer service representative helping a parent find suitable classes

**Business Insight:** Classes are prioritized by availability, helping quickly fill classes nearing minimum thresholds while also considering price sensitivity.

---

#### 📈 Query 1.2: Location Revenue Analysis

**Purpose:** Aggregate enrollment and revenue statistics by location

```sql
SELECT 
    school_name,                               
    city,                                        
    COUNT(groupId) AS total_groups,                -- Number of groups/classes
    SUM(current_amount) AS total_enrolled,         -- Total students across all groups
    SUM(current_amount * cost) AS potential_revenue, -- Revenue calculation
    AVG(current_amount) AS avg_enrollment,         -- Average class size
    MIN(spots_left) AS min_spots_available,        -- Least available class
    MAX(spots_left) AS max_spots_available         -- Most available class
FROM sports_enrollment_analysis
GROUP BY school_name, city          -- Aggregate by location
HAVING SUM(current_amount) > 0      -- Only locations with students
ORDER BY potential_revenue DESC;    -- Highest revenue locations first
```

**Use Case:** Management reviewing location performance for strategic planning

**Business Insight:** Identifies highest-performing locations by revenue and enrollment efficiency, informing decisions about resource allocation and expansion.

---

### 🎨 View 2: Activity Participation Summary
**Perspective:** Received Activities System

#### 📋 View Definition

```sql
CREATE VIEW activity_participation_summary AS
SELECT 
    a.activity_id,
    a.activity_name,                          
    a.description,                            
    a.min_age,                                
    a.max_age,                               
    g.groupId,
    g.yeargroup_id,                               -- Grade level
    yg.grade_name,                                -- Grade name (e.g., "Grade 3")
    p.first_name || ' ' || p.last_name AS instructor_name,
    t.specialty,                               
    p.email AS instructor_email,
    gd.day_of_week,                              
    gd.start_time,                           
    gd.end_time,                               
    gd.room,                               
    l.school_name,                         
    l.city                                    
FROM Sports_Class a                               -- "Activities" mapped to Sports_Class
INNER JOIN Group_Of_Sports g ON a.id = g.sports_class_id
INNER JOIN yeargroups yg ON g.yeargroup_id = yg.yeargroup_id
INNER JOIN Teacher t ON g.teacher_id = t.teacherId
INNER JOIN Person p ON t.teacherId = p.personId
INNER JOIN Group_Details gd ON g.groupId = gd.group_id
INNER JOIN Takes_Place tp ON g.yeargroup_id = tp.yeargroup_id
INNER JOIN Location l ON tp.location_id = l.id;
```

#### 🎯 View Purpose
Provides a **comprehensive activity program catalog** combining:
- Activity offerings with age ranges
- Grade level targeting
- Instructor assignments and specialties
- Complete scheduling (day, time, room)
- Location availability

#### 💡 Business Value
- **Program Coordination:** Manage diverse activity offerings across locations
- **Instructor Management:** Track instructor assignments and specialties
- **Family Communication:** Provide complete schedule information
- **Resource Planning:** Optimize room utilization and avoid conflicts

---

#### 🔍 Query 2.1: Dance and Piano Programs

**Purpose:** List all Dance and Piano offerings with complete details

```sql
SELECT 
    activity_name,    
    grade_name,           -- Target grade level
    instructor_name,      
    specialty,           
    day_of_week,        
    start_time,           
    end_time,           
    room,                 
    school_name,      
    city                 
FROM activity_participation_summary
WHERE activity_name IN ('Dance', 'Piano')     -- Filter specific activities
ORDER BY activity_name, day_of_week, start_time; -- Chronological order
```

**Use Case:** Parent researching enrichment activities for their child

**Business Insight:** Families can compare offerings across locations and times, while administrators see instructor schedules and room usage patterns.

---

#### 📊 Query 2.2: Activity Program Statistics

**Purpose:** Analyze program breadth and resource allocation

```sql
SELECT 
    activity_name,                            ]
    COUNT(DISTINCT groupId) AS number_groups,    -- How many sections offered
    COUNT(DISTINCT instructor_name) AS num_instructors, -- Instructor coverage
    MIN(min_age) AS youngest_age,                -- Minimum age served
    MAX(max_age) AS oldest_age,                  -- Maximum age served
    COUNT(DISTINCT school_name) AS num_locations -- Location availability
FROM activity_participation_summary
GROUP BY activity_name              -- Aggregate by activity
HAVING COUNT(DISTINCT groupId) > 0  -- Only activities with active groups
ORDER BY number_groups DESC;        -- Most popular first
```

**Use Case:** Program director evaluating activity portfolio

**Business Insight:** Reveals which activities have highest demand (multiple groups), adequate instructor coverage, and age range served. Informs hiring and program development decisions.

---

## ✅ Results and Achievements

### Key Achievements 🏆

#### 1. ✅ Successful Person Hierarchy
- Unified 4 person-related entities (students, teachers, parents, instructors)
- Clean inheritance structure with proper foreign keys
- Zero data loss during migration

#### 2. ✅ Preserved Business Logic
- All capacity management triggers functional
- Status updates working across migrated data
- Enrollment constraints respected

#### 3. ✅ Comprehensive Views
- Both system perspectives represented
- Complex joins simplified into queryable interfaces
- Practical queries demonstrate real business value

#### 4. ✅ Data Integrity Maintained
- All foreign key relationships validated
- Referential integrity enforced
- No orphaned records

#### 5. ✅ Scalable Architecture
- Offset strategy allows future integrations
- Normalized structure reduces redundancy
- Indexed for performance at scale

---

## 🎓 Conclusion

This integration project successfully merged two independent database systems into a unified, functional whole. By following a systematic approach - reverse engineering, design integration, and careful implementation - we created a robust combined system that:

- ✅ Preserves all data from both sources
- ✅ Maintains operational business logic  
- ✅ Provides analytical views for both perspectives
- ✅ Scales to accommodate future growth
- ✅ Documents all decisions and transformations

The resulting unified database serves both the sports enrollment and activities management use cases while maintaining the unique characteristics and requirements of each system.



