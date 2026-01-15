--Validates that a group is not full before allowing a new student enrollment. 
--Raises an exception if the group has reached capacity, preventing the insert operation from completing.


-- FUNCTION: public.check_group_capacity_before_insert()

-- DROP FUNCTION IF EXISTS public.check_group_capacity_before_insert();

CREATE OR REPLACE FUNCTION public.check_group_capacity_before_insert()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    class_capacity INT;
    current_students INT;
BEGIN
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = NEW.groupId;
    
    SELECT current_amount INTO current_students
    FROM Group_Of_Sports
    WHERE groupId = NEW.groupId;
    
    IF current_students >= class_capacity THEN
        RAISE EXCEPTION 'Cannot add student to group %. Group is FULL', NEW.groupId;
    END IF;
    
    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.check_group_capacity_before_insert()
    OWNER TO postgres;
