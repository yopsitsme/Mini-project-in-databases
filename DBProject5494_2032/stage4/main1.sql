-- File: student_enrollment_main.sql

DO $$
DECLARE
    v_student_id INTEGER := 15;
    v_group_ids INTEGER[] := ARRAY[1, 2, 3];
    v_result TEXT;
    v_course_rec RECORD;
BEGIN
    RAISE NOTICE '=== STUDENT ENROLLMENT SYSTEM ===';
    RAISE NOTICE 'Processing enrollment for Student ID: %', v_student_id;
    RAISE NOTICE '';
    
    
    CALL enroll_student_bulk(v_student_id, v_group_ids, v_result);
    
    RAISE NOTICE '%', v_result;
    RAISE NOTICE '';
    RAISE NOTICE '=== CURRENT STUDENT SCHEDULE ===';
    
    FOR v_course_rec IN 
        SELECT * FROM get_student_courses(v_student_id)
    LOOP
        RAISE NOTICE 'Class: % (Level: %)', v_course_rec.class_name, v_course_rec.level;
        RAISE NOTICE '  Teacher: %', v_course_rec.teacher_name;
        RAISE NOTICE '  Schedule: % % - %', 
            v_course_rec.day_of_week, 
            v_course_rec.start_time, 
            v_course_rec.end_time;
        RAISE NOTICE '  Room: % | Cost: ₪% | Status: %', 
            v_course_rec.room, 
            v_course_rec.cost, 
            v_course_rec.status;
        RAISE NOTICE '';
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR: %', SQLERRM;
END $$;