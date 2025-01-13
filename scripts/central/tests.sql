SET TIMING ON
SELECT COUNT(*) FROM employees_sales@vm1_link;
SELECT COUNT(*) FROM employee_details@vm2_link;


-- Requête de vérification d'intégrité
SELECT COUNT(*) as differences
FROM (
    SELECT emp_id FROM central_employees_sales
    MINUS
    SELECT emp_id FROM employees_sales@vm1_link
);

-- 2. Test Job Status and Execution
CREATE OR REPLACE PROCEDURE test_sync_jobs AS
    v_enabled VARCHAR2(5);
    v_last_start_date TIMESTAMP;
    v_last_run_duration INTERVAL DAY TO SECOND;
BEGIN
    -- Check sync_sales_employees job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_sales_employees';
    
    DBMS_OUTPUT.put_line('Sales_employees Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);
    
    -- check sync_it_employees job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_it_employees';
    
    DBMS_OUTPUT.put_line('It_employees Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

    -- check sync_employee_details job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_employee_details';

    DBMS_OUTPUT.put_line('Employee_details Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

    -- check sync_sales_projects job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_sales_projects';

    DBMS_OUTPUT.put_line('Sales_projects Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

    -- check sync_it_projects job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_it_projects';

    DBMS_OUTPUT.put_line('It_projects Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

    -- check sync_sales_project_details job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_sales_project_details';

    DBMS_OUTPUT.put_line('Sales_project_details Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

    -- check sync_it_project_details job
    SELECT enabled, last_start_date, last_run_duration
    INTO v_enabled, v_last_start_date, v_last_run_duration
    FROM user_scheduler_jobs
    WHERE job_name = 'sync_it_project_details';

    DBMS_OUTPUT.put_line('It_project_details Sync Job Status:');
    DBMS_OUTPUT.put_line('Enabled: ' || v_enabled);
    DBMS_OUTPUT.put_line('Last Start: ' || v_last_start_date);
    DBMS_OUTPUT.put_line('Duration: ' || v_last_run_duration);

END;
/

-- 3. Test Data Synchronization
CREATE OR REPLACE PROCEDURE test_data_sync AS
    -- Variables for counting records
    v_source_count NUMBER;
    v_central_count NUMBER;
    v_diff_count NUMBER;
BEGIN
    -- Test employees_sales synchronization
    SELECT COUNT(*) INTO v_source_count FROM employees_sales@vm1_link;
    SELECT COUNT(*) INTO v_central_count FROM central_employees_sales;
    v_diff_count := v_source_count - v_central_count;
    
    DBMS_OUTPUT.put_line('VM1 Employee Data Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);
    
    -- Add detailed comparison
    FOR r IN (
        SELECT e.emp_id, e.name, 
               CASE 
                   WHEN c.emp_id IS NULL THEN 'Missing in Central'
                   WHEN e.name != c.name OR 
                        NVL(e.salary,0) != NVL(c.salary,0) OR 
                        NVL(e.department,'x') != NVL(c.department,'x') 
                   THEN 'Data Mismatch'
               END as status
        FROM employees_sales@vm1_link e
        LEFT JOIN central_employees_sales c ON e.emp_id = c.emp_id
        WHERE c.emp_id IS NULL OR 
              e.name != c.name OR 
              NVL(e.salary,0) != NVL(c.salary,0) OR 
              NVL(e.department,'x') != NVL(c.department,'x')
    ) LOOP
        DBMS_OUTPUT.put_line('Employee ' || r.emp_id || ' - ' || r.status);
    END LOOP;

    -- Test employees_it synchronization
    SELECT COUNT(*) INTO v_source_count FROM employees_it@vm1_link;
    SELECT COUNT(*) INTO v_central_count FROM central_employees_it;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM1 IT Employee Data Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.emp_id, e.name, 
               CASE 
                   WHEN c.emp_id IS NULL THEN 'Missing in Central'
                   WHEN e.name != c.name OR 
                        NVL(e.salary,0) != NVL(c.salary,0) OR 
                        NVL(e.department,'x') != NVL(c.department,'x') 
                   THEN 'Data Mismatch'
               END as status
        FROM employees_it@vm1_link e
        LEFT JOIN central_employees_it c ON e.emp_id = c.emp_id
        WHERE c.emp_id IS NULL OR 
              e.name != c.name OR 
              NVL(e.salary,0) != NVL(c.salary,0) OR 
              NVL(e.department,'x') != NVL(c.department,'x')
    ) LOOP
        DBMS_OUTPUT.put_line('Employee ' || r.emp_id || ' - ' || r.status);
    END LOOP;

    -- Test employee_details synchronization
    SELECT COUNT(*) INTO v_source_count FROM employee_details@vm2_link;
    SELECT COUNT(*) INTO v_central_count FROM central_employee_details;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM2 Employee Details Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.emp_id, e.address, e.phone_number, e.email,
               CASE 
                   WHEN c.emp_id IS NULL THEN 'Missing in Central'
                   WHEN e.address != c.address OR 
                        e.phone_number != c.phone_number OR 
                        e.email != c.email
                   THEN 'Data Mismatch'
               END as status
        FROM employee_details@vm2_link e
        LEFT JOIN central_employee_details c ON e.emp_id = c.emp_id
        WHERE c.emp_id IS NULL OR 
              e.address != c.address OR 
              e.phone_number != c.phone_number OR 
              e.email != c.email
    ) LOOP
        DBMS_OUTPUT.put_line('Employee ' || r.emp_id || ' - ' || r.status);
    END LOOP;

    -- Test employee_projects_sales synchronization
    SELECT COUNT(*) INTO v_source_count FROM employee_projects_sales@vm3_link;
    SELECT COUNT(*) INTO v_central_count FROM central_emp_projects_sales;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM3 Employee Projects Sales Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.emp_id, e.project_id, e.role, e.department,
               CASE 
                   WHEN c.emp_id IS NULL THEN 'Missing in Central'
                   WHEN e.role != c.role OR 
                        e.department != c.department
                   THEN 'Data Mismatch'
               END as status
        FROM employee_projects_sales@vm3_link e
        LEFT JOIN central_emp_projects_sales c ON e.emp_id = c.emp_id AND e.project_id = c.project_id
        WHERE c.emp_id IS NULL OR 
              e.role != c.role OR 
              e.department != c.department
    ) LOOP
        DBMS_OUTPUT.put_line('Employee ' || r.emp_id || ' - ' || r.status);
    END LOOP;

    -- Test projects_sales_details synchronization
    SELECT COUNT(*) INTO v_source_count FROM projects_sales_details@vm3_link;
    SELECT COUNT(*) INTO v_central_count FROM central_prj_sales_detatils;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM3 Projects Sales Details Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.project_id, e.project_name, e.start_date, e.end_date,
               CASE 
                   WHEN c.project_id IS NULL THEN 'Missing in Central'
                   WHEN e.project_name != c.project_name OR 
                        e.start_date != c.start_date OR 
                        e.end_date != c.end_date
                   THEN 'Data Mismatch'
               END as status
        FROM projects_sales_details@vm3_link e
        LEFT JOIN central_prj_sales_detatils c ON e.project_id = c.project_id
        WHERE c.project_id IS NULL OR 
              e.project_name != c.project_name OR 
              e.start_date != c.start_date OR 
              e.end_date != c.end_date
    ) LOOP
        DBMS_OUTPUT.put_line('Project ' || r.project_id || ' - ' || r.status);
    END LOOP;

    -- Test employee_projects_it synchronization
    SELECT COUNT(*) INTO v_source_count FROM employee_projects_it@vm3_link;
    SELECT COUNT(*) INTO v_central_count FROM central_employee_projects_it;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM3 Employee Projects IT Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.emp_id, e.project_id, e.role, e.department,
               CASE 
                   WHEN c.emp_id IS NULL THEN 'Missing in Central'
                   WHEN e.role != c.role OR 
                        e.department != c.department
                   THEN 'Data Mismatch'
               END as status
        FROM employee_projects_it@vm3_link e
        LEFT JOIN central_employee_projects_it c ON e.emp_id = c.emp_id AND e.project_id = c.project_id
        WHERE c.emp_id IS NULL OR 
              e.role != c.role OR 
              e.department != c.department
    ) LOOP
        DBMS_OUTPUT.put_line('Employee ' || r.emp_id || ' - ' || r.status);
    END LOOP;

    -- Test projects_it_details synchronization
    SELECT COUNT(*) INTO v_source_count FROM projects_it_details@vm3_link;
    SELECT COUNT(*) INTO v_central_count FROM central_projects_it_detatils;
    v_diff_count := v_source_count - v_central_count;

    DBMS_OUTPUT.put_line('VM3 Projects IT Details Sync Status:');
    DBMS_OUTPUT.put_line('Source Records: ' || v_source_count);
    DBMS_OUTPUT.put_line('Central Records: ' || v_central_count);
    DBMS_OUTPUT.put_line('Difference: ' || v_diff_count);

    -- Add detailed comparison
    FOR r IN (
        SELECT e.project_id, e.project_name, e.start_date, e.end_date,
               CASE 
                   WHEN c.project_id IS NULL THEN 'Missing in Central'
                   WHEN e.project_name != c.project_name OR 
                        e.start_date != c.start_date OR 
                        e.end_date != c.end_date
                   THEN 'Data Mismatch'
               END as status
        FROM projects_it_details@vm3_link e
        LEFT JOIN central_projects_it_detatils c ON e.project_id = c.project_id
        WHERE c.project_id IS NULL OR 
              e.project_name != c.project_name OR 
              e.start_date != c.start_date OR 
              e.end_date != c.end_date
    ) LOOP
        DBMS_OUTPUT.put_line('Project ' || r.project_id || ' - ' || r.status);
    END LOOP;

END;
/

-- 4. Create Test Data Generation Procedure
CREATE OR REPLACE PROCEDURE generate_test_data AS
BEGIN
    -- Generate test data in employees_sales
   EXECUTE IMMEDIATE 'INSERT INTO employees_sales@vm1_link 
   VALUES (1001, ''Test Employee 1'', 50000, ''Sales'')';

    -- Generate test data in employees_it
   EXECUTE IMMEDIATE 'INSERT INTO employees_it@vm1_link 
   VALUES (1001, ''Test Employee 1'', 50000, ''IT'')';
    
    -- Generate test data in employee_details
    EXECUTE IMMEDIATE 'INSERT INTO employee_details@vm2_link
    VALUES (1001, ''123 Test St'', ''555-1234'', ''test1@test.com'')';

    -- Generate test data in employee_projects_sales
    EXECUTE IMMEDIATE 'INSERT INTO employee_projects_sales@vm3_link
    VALUES (1001, 1, ''Manager'', ''Sales'')';

    -- Generate test data in projects_sales_details
    EXECUTE IMMEDIATE 'INSERT INTO projects_sales_details@vm3_link
    VALUES (1, ''Test Project 1'', SYSDATE, SYSDATE + 30)';

    -- Generate test data in employee_projects_it
    EXECUTE IMMEDIATE 'INSERT INTO employee_projects_it@vm3_link
    VALUES (1001, 1, ''Manager'', ''IT'')';

    -- Generate test data in projects_sales_details
    EXECUTE IMMEDIATE 'INSERT INTO projects_sales_details@vm3_link
    VALUES (1, ''Test Project 2'', SYSDATE, SYSDATE + 30)';
    
    COMMIT;
END;
/

-- 5. Main Test Execution Procedure
CREATE OR REPLACE PROCEDURE run_full_system_test AS
BEGIN
    DBMS_OUTPUT.put_line('=== Starting Full System Test ===');
    
    -- Step 1: Test DB Links
    DBMS_OUTPUT.put_line('Testing Database Links...');
    test_db_links();
    
    -- Step 2: Generate Test Data
    DBMS_OUTPUT.put_line('Generating Test Data...');
    generate_test_data();
    
    -- Step 3: Test Job Status
    DBMS_OUTPUT.put_line('Checking Job Status...');
    test_sync_jobs();
    
    -- Step 4: Test Data Synchronization
    DBMS_OUTPUT.put_line('Verifying Data Synchronization...');
    test_data_sync();
    
    DBMS_OUTPUT.put_line('=== Full System Test Completed ===');
END;
/

BEGIN
    run_full_system_test();
END;
/

-- Test just the database links
-- EXEC test_db_links();

-- Check job status
-- EXEC test_sync_jobs();

-- Verify data synchronization
-- EXEC test_data_sync();

-- Generate test data
-- EXEC generate_test_data();
