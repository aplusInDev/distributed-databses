BEGIN
   DBMS_SCHEDULER.create_job (
    -- sync sales_employees from vm1 to central
      job_name        => 'sync_sales_employees',
      job_type        => 'PLSQL_BLOCK',
      job_action      => 'BEGIN
                            MERGE INTO central_employees_sales c
                            USING (
                              SELECT * FROM employees_sales@vm1_link
                            ) v ON (c.emp_id = v.emp_id)
                            WHEN MATCHED THEN
                              UPDATE SET c.name = v.name,
                                       c.salary = v.salary,
                                       c.department = v.department
                            WHEN NOT MATCHED THEN
                              INSERT (emp_id, name, salary, department)
                              VALUES (v.emp_id, v.name, v.salary, v.department);
                            COMMIT;
                          END;',
      start_date      => SYSTIMESTAMP,
      repeat_interval => 'FREQ=HOURLY; INTERVAL=1',
      enabled         => TRUE
   );
END;
/

BEGIN
    -- Job pour synchroniser employees_it from vm1 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_it_employees',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_employees_it c
                            USING (
                                SELECT * FROM employees_it@vm1_link
                            ) v ON (c.emp_id = v.emp_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.name = v.name,
                                         c.salary = v.salary,
                                         c.department = v.department
                            WHEN NOT MATCHED THEN
                                INSERT (emp_id, name, salary, department)
                                VALUES (v.emp_id, v.name, v.salary, v.department);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=1',
        enabled         => TRUE
    );
END;
/

BEGIN
    -- Job pour synchroniser employee_details from vm2 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_employee_details',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_employee_details c
                            USING (
                                SELECT * FROM employee_details@vm2_link
                            ) v ON (c.emp_id = v.emp_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.address = v.address,
                                         c.phone_number = v.phone_number,
                                         c.email = v.email
                            WHEN NOT MATCHED THEN
                                INSERT (emp_id, address, phone_number, email)
                                VALUES (v.emp_id, v.address, v.phone_number, v.email);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=2',
        enabled         => TRUE
    );
END;
/

BEGIN
    -- Job pour synchroniser employee_projects_sales from vm3 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_sales_projects',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_emp_projects_sales c
                            USING (
                                SELECT * FROM employee_projects_sales@vm3_link
                            ) v ON (c.emp_id = v.emp_id AND c.project_id = v.project_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.role = v.role,
                                         c.department = v.department
                            WHEN NOT MATCHED THEN
                                INSERT (emp_id, project_id, role, department)
                                VALUES (v.emp_id, v.project_id, v.role, v.department);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=3',
        enabled         => TRUE
    );
END;
/

BEGIN
    -- Job pour synchroniser projects_sales_details from vm3 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_sales_project_details',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_prj_sales_detatils c
                            USING (
                                SELECT * FROM projects_sales_detatils@vm3_link
                            ) v ON (c.project_id = v.project_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.project_name = v.project_name,
                                         c.start_date = v.start_date,
                                         c.end_date = v.end_date
                            WHEN NOT MATCHED THEN
                                INSERT (project_id, project_name, start_date, end_date)
                                VALUES (v.project_id, v.project_name, v.start_date, v.end_date);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=4',
        enabled         => TRUE
    );
END;
/

BEGIN
    -- Job pour synchroniser employee_projects_it from vm3 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_it_projects',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_employee_projects_it c
                            USING (
                                SELECT * FROM employee_projects_it@vm3_link
                            ) v ON (c.emp_id = v.emp_id AND c.project_id = v.project_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.role = v.role,
                                         c.department = v.department
                            WHEN NOT MATCHED THEN
                                INSERT (emp_id, project_id, role, department)
                                VALUES (v.emp_id, v.project_id, v.role, v.department);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=3',
        enabled         => TRUE
    );
END;
/

BEGIN
    -- Job pour synchroniser projects_it_details from vm3 to central
    DBMS_SCHEDULER.create_job (
        job_name        => 'sync_it_project_details',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                            MERGE INTO central_projects_it_detatils c
                            USING (
                                SELECT * FROM projects_it_detatils@vm3_link
                            ) v ON (c.project_id = v.project_id)
                            WHEN MATCHED THEN
                                UPDATE SET c.project_name = v.project_name,
                                         c.start_date = v.start_date,
                                         c.end_date = v.end_date
                            WHEN NOT MATCHED THEN
                                INSERT (project_id, project_name, start_date, end_date)
                                VALUES (v.project_id, v.project_name, v.start_date, v.end_date);
                            COMMIT;
                          END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=4',
        enabled         => TRUE
    );
END;
/

SELECT * FROM employees_sales@vm1_link;
SELECT * FROM central_employees_sales;


SELECT job_name, state, last_start_date, next_run_date 
FROM user_scheduler_jobs;

SELECT job_name, status, error#, actual_start_date, run_duration
FROM user_scheduler_job_run_details;
