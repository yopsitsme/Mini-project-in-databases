--Automatically updates group status (PENDING/ACTIVE/FULL) and increments current_amount 
--when a new student is added to participate_in table. 
--Uses CASE statement to determine status based on minimum requirements (5 students) and capacity limits.


-- FUNCTION: public.update_group_status_on_insert()

-- DROP FUNCTION IF EXISTS public.update_group_status_on_insert();

CREATE OR REPLACE FUNCTION public.update_group_status_on_insert()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    class_capacity INT;
    new_amount INT;
BEGIN
    UPDATE Group_Of_Sports 
    SET current_amount = current_amount + 1 
    WHERE groupId = NEW.groupId
    RETURNING current_amount INTO new_amount;
    
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = NEW.groupId;
    
    UPDATE Group_Of_Sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE groupId = NEW.groupId;
    
    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.update_group_status_on_insert()
    OWNER TO postgres;
