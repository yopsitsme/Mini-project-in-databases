-- FUNCTION: public.update_group_status_on_delete()

-- DROP FUNCTION IF EXISTS public.update_group_status_on_delete();

CREATE OR REPLACE FUNCTION public.update_group_status_on_delete()
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
    SET current_amount = current_amount - 1 
    WHERE groupId = OLD.groupId
    RETURNING current_amount INTO new_amount;
    
    SELECT sc.capacity INTO class_capacity
    FROM Group_Of_Sports g
    JOIN Sports_Class sc ON g.sports_class_id = sc.id
    WHERE g.groupId = OLD.groupId;
    
    UPDATE Group_Of_Sports
    SET status = CASE
        WHEN new_amount < 5 THEN 'PENDING'
        WHEN new_amount >= class_capacity THEN 'FULL'
        ELSE 'ACTIVE'
    END
    WHERE groupId = OLD.groupId;
    
    RETURN OLD;
END;
$BODY$;

ALTER FUNCTION public.update_group_status_on_delete()
    OWNER TO postgres;
