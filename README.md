# Mini-project-in-databases

Submitters: Chana Perel Kats, Rachel Lea Izchaki

System Specification Document – Sports Class Management System
System Name: Sports Class Management System
Purpose:
The purpose of this system is to efficiently manage all information related to sports classes, including students, teachers, sports class groups, equipment, and locations. The system enables tracking of participant registration, class scheduling, costs, and the allocation of equipment and instructors to different classes.

Main Entities in the System:
Person – Super-type
Subtypes:
Student – Attributes: unique ID, address, email, phone number, date of birth, name.
Teacher – Attributes: unique ID, salary, hire date, email, phone number, name, date of birth.
Sports Class – Attributes: unique ID, class name, number of participants, cost, duration.
Group of Sports Classes – Attributes: unique ID, level, day of the week, start time, minimum age, current number of participants.

Relationships:
Participate_in – Students can participate in sports class groups.
Belongs_to – Sports classes belong to a sports group.
Teaches – A teacher teaches a specific group.
Location – Attributes: unique ID, location name, city, capacity.

Relationship: A sports class takes place at a specific location (Takes place).
Equipment – Attributes: unique ID, name, quantity.
Relationship: Sports classes require certain equipment (Needs).

Main Relationships in the System:
Students participate in sports class groups (Many-to-Many).
A teacher teaches a sports class group (One-to-Many).
A sports class takes place at one location (Many-to-One).
A sports class requires equipment (Many-to-Many).
A sports class belongs to a sports class group (Many-to-One).

Summary:
The system provides comprehensive management of sports classes, tracking students, teachers, equipment, and locations. The data is organized hierarchically and clearly: the Person entity is divided into Students and Teachers; Sports Classes are linked to Sports Class Groups; each class has a responsible teacher, a specific location, and required equipment.
