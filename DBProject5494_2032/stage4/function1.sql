CREATE OR REPLACE FUNCTION get_student_courses(p_student_id INTEGER)
RETURNS TABLE (
    group_id INTEGER,
    class_name VARCHAR(100),
    level VARCHAR(50),
    teacher_name TEXT,
    day_of_week VARCHAR(20),
    start_time TIME,
    end_time TIME,
    room VARCHAR(3),
    status VARCHAR(20),
    cost NUMERIC(10,2)
	) 
AS $$
DECLARE
    v_student_exists BOOLEAN;
    v_course_rec RECORD;
    course_cursor CURSOR FOR
        SELECT 
            g.groupid,
            sc.name,
            g.level,
            (p.first_name || ' ' || p.last_name) as teacher_full_name,
            gd.day_of_week,
            gd.start_time,
            gd.end_time,
            gd.room,
            g.status,
            sc.cost
		FROM participate_in pi
        JOIN group_of_sports g ON pi.groupid = g.groupid
        JOIN sports_class sc ON g.sports_class_id = sc.id
        JOIN teacher t ON g.teacher_id = t.teacherid
        JOIN person p ON t.teacherid = p.personid
        LEFT JOIN group_details gd ON g.groupid = gd.group_id
        WHERE pi.studentid = p_student_id
        ORDER BY sc.name, gd.day_of_week, gd.start_time;
BEGIN
    -- בדיקה אם התלמיד קיים
    SELECT EXISTS(SELECT 1 FROM student WHERE studentid = p_student_id) 
    INTO v_student_exists;
    
    IF NOT v_student_exists THEN
        RAISE EXCEPTION 'Student with ID % does not exist', p_student_id;
    END IF;
    
    -- מעבר על כל הקורסים והחזרת התוצאות
    FOR v_course_rec IN course_cursor
    LOOP
        group_id := v_course_rec.groupid;
        class_name := v_course_rec.name;
        level := v_course_rec.level;
        teacher_name := v_course_rec.teacher_full_name;
        day_of_week := v_course_rec.day_of_week;
        start_time := v_course_rec.start_time;
        end_time := v_course_rec.end_time;
        room := v_course_rec.room;
        status := v_course_rec.status;
        cost := v_course_rec.cost;
        
        RETURN NEXT;
    END LOOP;
    
    RETURN;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error retrieving student courses: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;