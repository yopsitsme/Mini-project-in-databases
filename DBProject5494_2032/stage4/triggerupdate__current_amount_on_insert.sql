-- FUNCTION: public.update_current_amount_on_insert()

-- DROP FUNCTION IF EXISTS public.update_current_amount_on_insert();

CREATE OR REPLACE FUNCTION public.update_current_amount_on_insert()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    UPDATE group_of_sports 
    SET current_amount = current_amount + 1 
    WHERE id = NEW.group_id;
    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.update_current_amount_on_insert()
    OWNER TO postgres;
