-- DELETE QUERY 2: Remove Inactive Students with No Enrollments in Past Year
-- Cleans up student records with no recent activity
-- Used by: Database administrator for data archival
DELETE FROM student
WHERE id IN (
    SELECT s.id
    FROM student s
    JOIN person p ON s.id = p.id
    WHERE NOT EXISTS (
        SELECT 1
        FROM participate_in pi
        JOIN group_of_sports g ON pi.group_id = g.id
        JOIN teacher t ON g.teacher_id = t.id
        WHERE pi.student_id = s.id
        AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) < 1
    )
    AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.birth_date)) >= 18
    AND EXTRACT(MONTH FROM AGE(CURRENT_DATE, p.birth_date)) > 6
);