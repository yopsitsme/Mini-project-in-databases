--Demonstration script that analyzes a teacher's workload and 
--generates a monthly revenue report for the entire institution. 
--Combines teacher-specific metrics with system-wide financial reporting.


-- File: teacher_revenue_main.sql

DO $$
DECLARE
    v_teacher_id INTEGER := 196; 
    v_workload_result TEXT;
    v_year INTEGER := 2026;
    v_month INTEGER := 1;
    v_revenue_report TEXT;
BEGIN
    RAISE NOTICE '=== TEACHER WORKLOAD ANALYSIS ===';
    RAISE NOTICE 'Teacher ID: %', v_teacher_id;
    RAISE NOTICE '';
    
    v_workload_result := calculate_teacher_workload(v_teacher_id);
    
    RAISE NOTICE '%', v_workload_result;
    RAISE NOTICE '';
    RAISE NOTICE '';
    
    CALL generate_monthly_revenue_report(v_year, v_month, v_revenue_report);
    
    RAISE NOTICE '%', v_revenue_report;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR: %', SQLERRM;
END $$;