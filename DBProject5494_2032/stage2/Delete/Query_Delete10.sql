-- Delete Query 10: Remove students who haven't enrolled in any classes in PENDING groups with less than 5 students
-- Business Logic: Clean up inactive student records from pending groups
DELETE FROM student
WHERE id IN (
    SELECT s.id
    FROM student s
    INNER JOIN participate_in pi ON s.id = pi.student_id
    INNER JOIN group_of_sports g ON pi.group_id = g.id
    WHERE g.current_amount < 5 AND g.status = 'PENDING'
    GROUP BY s.id
    HAVING COUNT(DISTINCT pi.group_id) = 1
)
AND id NOT IN (
    SELECT pi2.student_id
    FROM participate_in pi2
    INNER JOIN group_of_sports g2 ON pi2.group_id = g2.id
    WHERE g2.current_amount >= 5
);