CREATE OR REPLACE PROCEDURE enroll_student_bulk(
    IN p_student_id INTEGER,
    IN p_group_ids INTEGER[],
    OUT p_result TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_group_id INTEGER;
    v_status VARCHAR(20);
    v_current_amount INT;
    v_capacity INT;
    v_class_name VARCHAR(100);
    v_success_count INTEGER := 0;
    v_error_count INTEGER := 0;
    v_message TEXT := '';
BEGIN
    -- Check if the student exists
    IF NOT EXISTS (
        SELECT 1
        FROM student
        WHERE studentid = p_student_id
    ) THEN
        p_result := 'ERROR: Student ID ' || p_student_id || ' does not exist';
        RETURN;
    END IF;

    v_message := 'Enrollment Results for Student ID ' || p_student_id || ':' || E'\n';

    -- Loop over all group IDs
    FOREACH v_group_id IN ARRAY p_group_ids
    LOOP
        BEGIN
            -- Retrieve group information
            SELECT g.status,
                   g.current_amount,
                   sc.capacity,
                   sc.name
            INTO v_status,
                 v_current_amount,
                 v_capacity,
                 v_class_name
            FROM group_of_sports g
            JOIN sports_class sc ON g.sports_class_id = sc.id
            WHERE g.groupid = v_group_id;

            -- Check if group exists
            IF NOT FOUND THEN
                v_message := v_message || 'Group ' || v_group_id ||
                             ': ERROR - Does not exist' || E'\n';
                v_error_count := v_error_count + 1;
                CONTINUE;
            END IF;

            -- Check if group is full
            IF v_status = 'FULL' OR v_current_amount >= v_capacity THEN
                v_message := v_message || 'Group ' || v_group_id ||
                             ' (' || v_class_name || '): ERROR - Group is FULL' || E'\n';
                v_error_count := v_error_count + 1;
                CONTINUE;
            END IF;

            -- Check if student is already enrolled
            IF EXISTS (
                SELECT 1
                FROM participate_in
                WHERE studentid = p_student_id
                  AND groupid = v_group_id
            ) THEN
                v_message := v_message || 'Group ' || v_group_id ||
                             ' (' || v_class_name || '): ERROR - Already enrolled' || E'\n';
                v_error_count := v_error_count + 1;
                CONTINUE;
            END IF;

            -- Enroll the student
            INSERT INTO participate_in (studentid, groupid, enrollment_date)
            VALUES (p_student_id, v_group_id, CURRENT_DATE);

            v_message := v_message || 'Group ' || v_group_id ||
                         ' (' || v_class_name || '): SUCCESS' || E'\n';
            v_success_count := v_success_count + 1;

        EXCEPTION
            WHEN OTHERS THEN
                v_message := v_message || 'Group ' || v_group_id ||
                             ': ERROR - ' || SQLERRM || E'\n';
                v_error_count := v_error_count + 1;
        END;
    END LOOP;

    -- Summary
    v_message := v_message || E'\n' ||
                 'Summary: ' || v_success_count ||
                 ' successful, ' || v_error_count || ' errors';

    p_result := v_message;

END;
$$;
