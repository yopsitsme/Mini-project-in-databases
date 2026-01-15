--Decrements the current_amount field in group_of_sports table when a 
--student enrollment record is deleted from participate_in table.


-- FUNCTION: public.update_current_amount_on_delete()

-- DROP FUNCTION IF EXISTS public.update_current_amount_on_delete();

CREATE OR REPLACE FUNCTION public.update_current_amount_on_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    UPDATE group_of_sports 
    SET current_amount = current_amount - 1 
    WHERE id = OLD.group_id;
    RETURN OLD;
END;
$BODY$;

ALTER FUNCTION public.update_current_amount_on_delete()
    OWNER TO postgres;
