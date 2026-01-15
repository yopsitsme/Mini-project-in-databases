--Calculates and returns a formatted text report of a teacher's workload, including total groups taught, 
--number of students, weekly hours,and workload status classification (NO_CLASSES, LIGHT, NORMAL, HEAVY, or OVERLOADED). 
--Includes teacher validation and exception handling.


CREATE OR REPLACE FUNCTION public.calculate_teacher_workload(
	p_teacher_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_teacher_exists BOOLEAN;
    v_total_hours NUMERIC(5,2);
    v_group_count INTEGER;
    v_student_count INTEGER;
    v_workload_status VARCHAR(20);
    v_result TEXT;
    v_teacher_name TEXT;
BEGIN
    SELECT EXISTS(SELECT 1 FROM teacher WHERE teacherid = p_teacher_id) 
    INTO v_teacher_exists;
    
    IF NOT v_teacher_exists THEN
        RETURN 'ERROR: Teacher with ID ' || p_teacher_id || ' does not exist';
    END IF;
    
    SELECT first_name || ' ' || last_name
    INTO v_teacher_name
    FROM person
    WHERE personid = p_teacher_id;
    
    SELECT COUNT(g.groupid)
    INTO v_group_count
    FROM group_of_sports g
    WHERE g.teacher_id = p_teacher_id;
    
    SELECT COUNT(DISTINCT pi.studentid)
    INTO v_student_count
    FROM group_of_sports g
    JOIN participate_in pi ON g.groupid = pi.groupid
    WHERE g.teacher_id = p_teacher_id;
    

    SELECT COALESCE(
        SUM(
            (sc.duration::NUMERIC / 60.0) * 
            (SELECT COUNT(*) FROM group_details gd WHERE gd.group_id = g.groupid)
        ), 
        0
    )
    INTO v_total_hours
    FROM group_of_sports g
    JOIN sports_class sc ON g.sports_class_id = sc.id
    WHERE g.teacher_id = p_teacher_id;
    
    v_workload_status := CASE
        WHEN v_total_hours = 0 THEN 'NO_CLASSES'
        WHEN v_total_hours < 10 THEN 'LIGHT'
        WHEN v_total_hours BETWEEN 10 AND 20 THEN 'NORMAL'
        WHEN v_total_hours BETWEEN 20 AND 30 THEN 'HEAVY'
        ELSE 'OVERLOADED'
    END;
    
    v_result := 'Teacher: ' || v_teacher_name || E'\n' ||
                'Total Groups: ' || v_group_count || E'\n' ||
                'Total Students: ' || v_student_count || E'\n' ||
                'Weekly Hours: ' || v_total_hours || E'\n' ||
                'Workload Status: ' || v_workload_status;
    
    RETURN v_result;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'ERROR: Teacher data not found';
    WHEN OTHERS THEN
        RETURN 'ERROR: ' || SQLERRM;
END;
$BODY$;

ALTER FUNCTION public.calculate_teacher_workload(integer)
    OWNER TO postgres;