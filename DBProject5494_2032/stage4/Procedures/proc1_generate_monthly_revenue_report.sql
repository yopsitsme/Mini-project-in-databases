--Generates a formatted monthly revenue report showing income breakdown by sports class, 
--including student counts, group counts, and revenue calculations. 
--Uses explicit cursor to process class data and validates input parameters (year and month ranges).



CREATE OR REPLACE PROCEDURE generate_monthly_revenue_report(
    IN p_year INTEGER,
    IN p_month INTEGER,
    OUT p_report TEXT
)
AS $$
DECLARE
    v_class_record RECORD;
    v_total_revenue NUMERIC(12,2) := 0;
    v_total_students INTEGER := 0;
    v_class_revenue NUMERIC(12,2);
    v_report_lines TEXT := '';
   
    revenue_cursor CURSOR FOR
        SELECT
            sc.name,
            sc.cost,
            COUNT(DISTINCT pi.studentid) AS student_count,
            COUNT(DISTINCT g.groupid) AS group_count
        FROM sports_class sc
        JOIN group_of_sports g ON sc.id = g.sports_class_id
        JOIN participate_in pi ON g.groupid = pi.groupid
        WHERE EXTRACT(YEAR FROM pi.enrollment_date) = p_year
          AND EXTRACT(MONTH FROM pi.enrollment_date) = p_month
          AND g.status IN ('ACTIVE', 'FULL')
        GROUP BY sc.name, sc.cost
        ORDER BY sc.name;
BEGIN
    -- validation
    IF p_month < 1 OR p_month > 12 THEN
        p_report := 'ERROR: Invalid month ' || p_month || '. Must be between 1 and 12';
        RETURN;
    END IF;
   
    IF p_year < 2000 OR p_year > 2100 THEN
        p_report := 'ERROR: Invalid year ' || p_year;
        RETURN;
    END IF;

    ------------------------------------------------------------------
    -- Title
    ------------------------------------------------------------------
    v_report_lines :=
        E'\nMONTHLY REVENUE REPORT  ' || LPAD(p_month::TEXT,2,'0') || '/' || p_year || E'\n' ||
        repeat('=', 80) || E'\n';

    ------------------------------------------------------------------
    -- Header row
    ------------------------------------------------------------------
    v_report_lines := v_report_lines ||
        RPAD('Class Name', 30) ||
        LPAD('Students', 12) ||
        LPAD('Groups', 10) ||
        LPAD('Revenue', 16) || E'\n' ||
        repeat('-', 80) || E'\n';

    ------------------------------------------------------------------
    -- Data rows
    ------------------------------------------------------------------
    FOR v_class_record IN revenue_cursor LOOP
        v_class_revenue :=
            v_class_record.cost * v_class_record.student_count;

        v_total_revenue  := v_total_revenue  + v_class_revenue;
        v_total_students := v_total_students + v_class_record.student_count;

        v_report_lines := v_report_lines ||
            RPAD(v_class_record.name, 30) ||
            LPAD(v_class_record.student_count::TEXT, 12) ||
            LPAD(v_class_record.group_count::TEXT, 10) ||
            LPAD('₪' || to_char(v_class_revenue, 'FM999,999,990.00'), 16) ||
            E'\n';
    END LOOP;

    ------------------------------------------------------------------
    -- Totals
    ------------------------------------------------------------------
    v_report_lines := v_report_lines ||
        repeat('=', 80) || E'\n' ||
        RPAD('TOTAL STUDENTS:', 52) ||
        LPAD(v_total_students::TEXT, 10) || E'\n' ||
        RPAD('TOTAL REVENUE:', 52) ||
        LPAD('₪' || to_char(v_total_revenue, 'FM999,999,990.00'), 10) || E'\n';

    p_report := v_report_lines;

EXCEPTION
    WHEN OTHERS THEN
        p_report := 'ERROR: ' || SQLERRM;
END;
$$ LANGUAGE plpgsql;