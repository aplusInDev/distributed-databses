-- Check the integrity of the central tables

CREATE TABLE integrity_check_log (
    log_id NUMBER PRIMARY KEY,
    check_date TIMESTAMP,
    check_type VARCHAR2(50),
    status VARCHAR2(20),
    details VARCHAR2(4000)
);

SELECT * FROM integrity_check_log;


-- First create the sequence if it doesn't exist
CREATE SEQUENCE integrity_check_log_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- data integrity check

-- Common logging procedure used by all verification procedures
CREATE OR REPLACE PROCEDURE log_integrity_check (
    p_check_type IN VARCHAR2,
    p_status IN VARCHAR2,
    p_details IN VARCHAR2
) AS
BEGIN
    INSERT INTO integrity_check_log (
        log_id,
        check_date,
        check_type,
        status,
        details
    ) VALUES (
        integrity_check_log_seq.NEXTVAL,
        SYSTIMESTAMP,
        p_check_type,
        p_status,
        p_details
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error logging results: ' || SQLERRM);
        RAISE;
END;
/

-- Procedure to verify Sales department data integrity
CREATE OR REPLACE PROCEDURE verify_sales_data_integrity AS
    v_error_msg VARCHAR2(4000);
BEGIN
    -- 1. Check for duplicate primary keys in sales employees
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM (
            SELECT emp_id
            FROM central_employees_sales
            GROUP BY emp_id
            HAVING COUNT(*) > 1
        );
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Sales PK Check',
                'FAIL',
                'Duplicate emp_ids found: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Sales PK Check',
                'PASS',
                'No duplicate primary keys in sales employees'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Sales PK Check',
                'PASS',
                'No duplicate primary keys in sales employees'
            );
    END;

    -- 2. Check department constraint
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM central_employees_sales
        WHERE department != 'Sales';
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Sales Department Check',
                'FAIL',
                'Invalid department values found for emp_ids: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Sales Department Check',
                'PASS',
                'All department values are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Sales Department Check',
                'PASS',
                'All department values are valid'
            );
    END;

    -- 3. Check sales projects foreign key integrity
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM (
            SELECT DISTINCT p.emp_id
            FROM central_emp_projects_sales p
            LEFT JOIN central_employees_sales e ON e.emp_id = p.emp_id
            WHERE e.emp_id IS NULL
        );
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Sales FK Check',
                'FAIL',
                'Orphaned emp_ids in projects: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Sales FK Check',
                'PASS',
                'All foreign keys are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Sales FK Check',
                'PASS',
                'All foreign keys are valid'
            );
    END;

    -- 4. Check project dates validity
    BEGIN
        SELECT LISTAGG(project_id, ', ') WITHIN GROUP (ORDER BY project_id)
        INTO v_error_msg
        FROM central_prj_sales_detatils
        WHERE start_date > end_date;
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Sales Project Dates Check',
                'FAIL',
                'Invalid date ranges for projects: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Sales Project Dates Check',
                'PASS',
                'All project dates are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Sales Project Dates Check',
                'PASS',
                'All project dates are valid'
            );
    END;

EXCEPTION
    WHEN OTHERS THEN
        log_integrity_check(
            'Sales General Error',
            'ERROR',
            'Procedure error: ' || SQLERRM
        );
        RAISE;
END;
/

-- Procedure to verify IT department data integrity
CREATE OR REPLACE PROCEDURE verify_it_data_integrity AS
    v_error_msg VARCHAR2(4000);
BEGIN
    -- 1. Check for duplicate primary keys in IT employees
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM (
            SELECT emp_id
            FROM central_employees_it
            GROUP BY emp_id
            HAVING COUNT(*) > 1
        );
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'IT PK Check',
                'FAIL',
                'Duplicate emp_ids found: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'IT PK Check',
                'PASS',
                'No duplicate primary keys in IT employees'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'IT PK Check',
                'PASS',
                'No duplicate primary keys in IT employees'
            );
    END;

    -- 2. Check department constraint
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM central_employees_it
        WHERE department != 'IT';
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'IT Department Check',
                'FAIL',
                'Invalid department values found for emp_ids: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'IT Department Check',
                'PASS',
                'All department values are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'IT Department Check',
                'PASS',
                'All department values are valid'
            );
    END;

    -- 3. Check IT projects foreign key integrity
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM (
            SELECT DISTINCT p.emp_id
            FROM central_employee_projects_it p
            LEFT JOIN central_employees_it e ON e.emp_id = p.emp_id
            WHERE e.emp_id IS NULL
        );
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'IT FK Check',
                'FAIL',
                'Orphaned emp_ids in projects: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'IT FK Check',
                'PASS',
                'All foreign keys are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'IT FK Check',
                'PASS',
                'All foreign keys are valid'
            );
    END;

    -- 4. Check project dates validity
    BEGIN
        SELECT LISTAGG(project_id, ', ') WITHIN GROUP (ORDER BY project_id)
        INTO v_error_msg
        FROM central_projects_it_detatils
        WHERE start_date > end_date;
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'IT Project Dates Check',
                'FAIL',
                'Invalid date ranges for projects: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'IT Project Dates Check',
                'PASS',
                'All project dates are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'IT Project Dates Check',
                'PASS',
                'All project dates are valid'
            );
    END;

EXCEPTION
    WHEN OTHERS THEN
        log_integrity_check(
            'IT General Error',
            'ERROR',
            'Procedure error: ' || SQLERRM
        );
        RAISE;
END;
/

-- Procedure to verify employee details integrity
CREATE OR REPLACE PROCEDURE verify_employee_details_integrity AS
    v_error_msg VARCHAR2(4000);
BEGIN
    -- 1. Check for null values in mandatory columns
    BEGIN
        WITH null_check AS (
            SELECT 
                COUNT(CASE WHEN emp_id IS NULL THEN 1 END) as null_emp_id,
                COUNT(CASE WHEN address IS NULL THEN 1 END) as null_address,
                COUNT(CASE WHEN phone_number IS NULL THEN 1 END) as null_phone,
                COUNT(CASE WHEN email IS NULL THEN 1 END) as null_email
            FROM central_employee_details
        )
        SELECT 
            CASE 
                WHEN null_emp_id > 0 THEN null_emp_id || ' null emp_ids, '
                ELSE ''
            END ||
            CASE 
                WHEN null_address > 0 THEN null_address || ' null addresses, '
                ELSE ''
            END ||
            CASE 
                WHEN null_phone > 0 THEN null_phone || ' null phone numbers, '
                ELSE ''
            END ||
            CASE 
                WHEN null_email > 0 THEN null_email || ' null emails'
                ELSE ''
            END
        INTO v_error_msg
        FROM null_check
        WHERE null_emp_id + null_address + null_phone + null_email > 0;

        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Employee Details Null Check',
                'FAIL',
                'Found: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Employee Details Null Check',
                'PASS',
                'No null values in mandatory columns'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Employee Details Null Check',
                'PASS',
                'No null values in mandatory columns'
            );
    END;

    -- 2. Check for valid email format
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM central_employee_details
        WHERE email NOT LIKE '%_@_%.__%';
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Email Format Check',
                'FAIL',
                'Invalid email format for emp_ids: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Email Format Check',
                'PASS',
                'All email formats are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Email Format Check',
                'PASS',
                'All email formats are valid'
            );
    END;

    -- 3. Check for valid phone number format (assuming 10-15 digits)
    BEGIN
        SELECT LISTAGG(emp_id, ', ') WITHIN GROUP (ORDER BY emp_id)
        INTO v_error_msg
        FROM central_employee_details
        WHERE REGEXP_LIKE(phone_number, '[^0-9+-]')
        OR LENGTH(REGEXP_REPLACE(phone_number, '[^0-9]', '')) NOT BETWEEN 10 AND 15;
        
        IF v_error_msg IS NOT NULL THEN
            log_integrity_check(
                'Phone Format Check',
                'FAIL',
                'Invalid phone format for emp_ids: ' || v_error_msg
            );
        ELSE
            log_integrity_check(
                'Phone Format Check',
                'PASS',
                'All phone formats are valid'
            );
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            log_integrity_check(
                'Phone Format Check',
                'PASS',
                'All phone formats are valid'
            );
    END;

EXCEPTION
    WHEN OTHERS THEN
        log_integrity_check(
            'Employee Details General Error',
            'ERROR',
            'Procedure error: ' || SQLERRM
        );
        RAISE;
END;
/

-- Main procedure to run all checks
CREATE OR REPLACE PROCEDURE verify_all_data_integrity AS
BEGIN
    verify_sales_data_integrity();
    verify_it_data_integrity();
    verify_employee_details_integrity();
    
    DBMS_OUTPUT.put_line('All data integrity verifications completed. Check integrity_check_log for results.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error in verify_all_data_integrity: ' || SQLERRM);
        log_integrity_check(
            'Main Procedure Error',
            'ERROR',
            'Error running all checks: ' || SQLERRM
        );
        RAISE;
END;
/

-- Run all checks
BEGIN
    verify_all_data_integrity();
END;

EXEC verify_all_data_integrity();

-- View the results
SELECT * FROM integrity_check_log;
