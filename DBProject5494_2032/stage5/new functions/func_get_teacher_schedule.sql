-- FUNCTION: public.get_teacher_schedule(integer)

-- DROP FUNCTION IF EXISTS public.get_teacher_schedule(integer);

CREATE OR REPLACE FUNCTION public.get_teacher_schedule(
	p_teacher_id integer)
    RETURNS TABLE(group_id integer, class_name character varying, level character varying, day_of_week character varying, start_time time without time zone, end_time time without time zone, room character varying, status character varying, current_students integer, capacity integer, cost numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    v_teacher_exists BOOLEAN;
    v_schedule_rec RECORD;
    schedule_cursor CURSOR FOR
        SELECT 
            g.groupid,
            sc.name,
            g.level,
            gd.day_of_week,
            gd.start_time,
            gd.end_time,
            gd.room,
            g.status,
            g.current_amount,
            sc.capacity,
            sc.cost
        FROM group_of_sports g
        JOIN sports_class sc ON g.sports_class_id = sc.id
        LEFT JOIN group_details gd ON g.groupid = gd.group_id
        WHERE g.teacher_id = p_teacher_id
       ORDER BY sc.name, gd.day_of_week, gd.start_time;
BEGIN
    -- בדיקה אם המורה קיים
    SELECT EXISTS(SELECT 1 FROM teacher WHERE teacherid = p_teacher_id) 
    INTO v_teacher_exists;
    
    IF NOT v_teacher_exists THEN
        RAISE EXCEPTION 'Teacher with ID % does not exist', p_teacher_id;
    END IF;
    
    -- מעבר על כל השיעורים והחזרת התוצאות
    FOR v_schedule_rec IN schedule_cursor
    LOOP
        group_id := v_schedule_rec.groupid;
        class_name := v_schedule_rec.name;
        level := v_schedule_rec.level;
        day_of_week := v_schedule_rec.day_of_week;
        start_time := v_schedule_rec.start_time;
        end_time := v_schedule_rec.end_time;
        room := v_schedule_rec.room;
        status := v_schedule_rec.status;
        current_students := v_schedule_rec.current_amount;
        capacity := v_schedule_rec.capacity;
        cost := v_schedule_rec.cost;
        
        RETURN NEXT;
    END LOOP;
    
    RETURN;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error retrieving teacher schedule: %', SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.get_teacher_schedule(integer)
    OWNER TO postgres;
