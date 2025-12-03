-- Delete Query 11: Remove person records for individuals with invalid contact information who are neither students nor teachers
-- Business Logic: Clean up incomplete person records that have no role in the system
DELETE FROM person
WHERE (email IS NULL OR email NOT LIKE '%@%')
AND (phone IS NULL OR phone = '')
AND id NOT IN (
    SELECT id FROM student
    UNION
    SELECT id FROM teacher
)
AND birth_date IS NOT NULL;
