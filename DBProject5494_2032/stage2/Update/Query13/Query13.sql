-- =====================================================
-- UPDATE QUERY 4: Equipment Inventory Replenishment and Reallocation
-- =====================================================
-- Updates equipment quantities based on:
-- 1. Usage patterns across all sports classes (needs table)
-- 2. Current vs. required quantities for active groups
-- 3. Seasonal demand variations (by month)
--
-- Used by: Inventory Manager and Equipment Coordinator
-- Business value: Ensure adequate equipment availability, prevent shortages, optimize inventory
-- GUI Display: Shows equipment name, current amount, required amount, shortage, and reorder priority

UPDATE equipment
SET 
    amount = adjustment_data.new_amount
FROM (
    SELECT 
        e.id AS equipment_id,
        e.name AS equipment_name,
        e.amount AS current_amount,
        
        -- Calculate new equipment amount based on demand and usage
        CASE
            -- CRITICAL SHORTAGE: Required quantity far exceeds available (shortage > 50%)
            WHEN usage_data.total_required > 0 
                AND e.amount < (usage_data.total_required * 0.5)
                AND usage_data.active_classes >= 2
            THEN GREATEST(
                CEIL(usage_data.total_required * 1.5),  -- Order 150% of required
                e.amount + 20  -- Add at least 20 units
            )
            
            -- HIGH DEMAND: Multiple classes using equipment with moderate shortage
            WHEN usage_data.total_required > e.amount
                AND usage_data.active_classes >= 3
                AND seasonal_data.is_peak_season = 'Yes'
            THEN GREATEST(
                CEIL(usage_data.total_required * 1.3),  -- Order 130% of required for buffer
                e.amount + 15
            )
            
            -- MODERATE SHORTAGE: Usage growing, need replenishment
            WHEN usage_data.total_required > (e.amount * 0.75)
                AND usage_data.total_students >= 20
                AND EXTRACT(MONTH FROM AGE(CURRENT_DATE, class_age_data.oldest_class_date)) >= 3
            THEN CEIL(usage_data.total_required * 1.2)  -- Order 120% of required
            
            -- SEASONAL ADJUSTMENT: Peak months (Sept-Dec, Jan-Mar) need extra inventory
            WHEN seasonal_data.is_peak_season = 'Yes'
                AND EXTRACT(MONTH FROM CURRENT_DATE) IN (9, 10, 11, 12, 1, 2, 3)
                AND e.amount < (usage_data.total_required * 0.8)
            THEN CEIL(e.amount * 1.4)  -- Increase by 40% for peak season
            
            -- SLIGHT SHORTAGE: Top up to meet minimum requirements
            WHEN usage_data.total_required > e.amount
                AND (usage_data.total_required - e.amount) <= 10
            THEN usage_data.total_required + 5  -- Meet requirement plus small buffer
            
            -- ADEQUATE STOCK: Minor seasonal increase
            WHEN e.amount >= usage_data.total_required
                AND EXTRACT(MONTH FROM CURRENT_DATE) IN (9, 1)  -- Start of fall/winter terms
                AND usage_data.active_classes >= 1
            THEN CEIL(e.amount * 1.1)  -- 10% increase for term start
            
            -- OVERSTOCKED: Reduce excess inventory (more than 2x required)
            WHEN e.amount > (usage_data.total_required * 2)
                AND usage_data.total_required > 0
                AND EXTRACT(MONTH FROM AGE(CURRENT_DATE, class_age_data.oldest_class_date)) >= 6
            THEN CEIL(usage_data.total_required * 1.5)  -- Reduce to 150% of required
            
            ELSE e.amount  -- Keep current amount if no adjustment needed
        END AS new_amount,
        
        -- Calculate shortage/surplus metrics
        usage_data.total_required - e.amount AS shortage_amount,
        CASE 
            WHEN usage_data.total_required > 0 
            THEN ROUND(((usage_data.total_required - e.amount)::DECIMAL / usage_data.total_required) * 100, 1)
            ELSE 0
        END AS shortage_percentage,
        
        -- Priority scoring for reordering (higher = more urgent)
        CASE
            WHEN e.amount < (usage_data.total_required * 0.5) AND usage_data.active_classes >= 2 
            THEN 5  -- Critical priority
            WHEN e.amount < usage_data.total_required AND usage_data.active_classes >= 3 
            THEN 4  -- High priority
            WHEN e.amount < (usage_data.total_required * 0.8) AND usage_data.total_students >= 20 
            THEN 3  -- Medium priority
            WHEN e.amount < usage_data.total_required 
            THEN 2  -- Low priority
            ELSE 1  -- Adequate stock
        END AS reorder_priority,
        
        -- Additional metrics for reporting
        usage_data.total_required,
        usage_data.active_classes,
        usage_data.total_students,
        usage_data.avg_students_per_class,
        class_age_data.avg_class_age_years,
        class_age_data.avg_class_age_months,
        seasonal_data.is_peak_season,
        seasonal_data.current_month,
        seasonal_data.current_year,
        seasonal_data.current_day
        
    FROM equipment e
    
    -- Calculate total equipment requirements across all classes
    LEFT JOIN (
        SELECT 
            n.equipment_id,
            SUM(n.quantity_required) AS total_required,
            COUNT(DISTINCT n.sports_class_id) AS total_classes,
            COUNT(DISTINCT CASE 
                WHEN g.status IN ('ACTIVE', 'FULL') 
                THEN n.sports_class_id 
            END) AS active_classes,
            SUM(g.current_amount) AS total_students,
            ROUND(AVG(g.current_amount), 1) AS avg_students_per_class,
            SUM(CASE 
                WHEN g.status IN ('ACTIVE', 'FULL') 
                THEN n.quantity_required * g.current_amount 
                ELSE 0 
            END) AS weighted_requirement  -- Weight by actual student count
        FROM needs n
        JOIN sports_class sc ON n.sports_class_id = sc.id
        JOIN group_of_sports g ON g.sports_class_id = sc.id
        WHERE g.current_amount > 0  -- Only count groups with students
        GROUP BY n.equipment_id
    ) AS usage_data ON e.id = usage_data.equipment_id
    
    -- Calculate age of classes using this equipment (based on teacher hire dates)
    LEFT JOIN (
        SELECT 
            n.equipment_id,
            MIN(t.hire_date) AS oldest_class_date,
            MAX(t.hire_date) AS newest_class_date,
            ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date))), 1) AS avg_class_age_years,
            ROUND(AVG(
                EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.hire_date)) * 12 + 
                EXTRACT(MONTH FROM AGE(CURRENT_DATE, t.hire_date))
            ), 0) AS avg_class_age_months,
            EXTRACT(DAY FROM AGE(CURRENT_DATE, MIN(t.hire_date))) AS days_since_oldest_class
        FROM needs n
        JOIN sports_class sc ON n.sports_class_id = sc.id
        JOIN group_of_sports g ON g.sports_class_id = sc.id
        JOIN teacher t ON g.teacher_id = t.id
        GROUP BY n.equipment_id
    ) AS class_age_data ON e.id = class_age_data.equipment_id
    
    -- Seasonal demand indicators
    CROSS JOIN (
        SELECT 
            EXTRACT(YEAR FROM CURRENT_DATE) AS current_year,
            EXTRACT(MONTH FROM CURRENT_DATE) AS current_month,
            EXTRACT(DAY FROM CURRENT_DATE) AS current_day,
            CASE 
                WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (9, 10, 11, 12, 1, 2, 3) 
                THEN 'Yes' 
                ELSE 'No' 
            END AS is_peak_season,
            CASE
                WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (9, 10, 11) THEN 'Fall'
                WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (12, 1, 2) THEN 'Winter'
                WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (3, 4, 5) THEN 'Spring'
                ELSE 'Summer'
            END AS season_name
    ) AS seasonal_data
    
    WHERE 
        -- Only update equipment that is actually being used
        usage_data.equipment_id IS NOT NULL
        AND usage_data.total_required > 0
        
        -- Focus on equipment with active demand
        AND (
            usage_data.active_classes >= 1  -- At least one active class
            OR usage_data.total_students >= 5  -- Or reasonable student count
        )
        
        -- Exclude equipment for very new classes (less than 14 days)
        AND (
            class_age_data.avg_class_age_months >= 1
            OR class_age_data.days_since_oldest_class >= 14
        )
    
    ORDER BY 
        reorder_priority DESC,  -- Most urgent first
        shortage_percentage DESC,  -- Largest shortage percentage
        usage_data.total_students DESC,  -- Most students affected
        e.id ASC
) AS adjustment_data
WHERE equipment.id = adjustment_data.equipment_id
    -- Only update if amount is actually changing
    AND adjustment_data.new_amount != adjustment_data.current_amount
    -- Safety check: ensure we're not reducing to zero
    AND adjustment_data.new_amount > 0;