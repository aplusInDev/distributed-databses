-- Insert rows into employee_projects_sales table
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(1, 1, 'Manager', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(2, 2, 'Developer', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(3, 3, 'Analyst', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(4, 4, 'Consultant', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(5, 5, 'Manager', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(6, 6, 'Developer', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(7, 7, 'Analyst', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(8, 8, 'Consultant', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(9, 9, 'Manager', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(10, 10, 'Developer', 'Sales');
INSERT INTO employee_projects_sales (emp_id, project_id, role, department) VALUES
(11, 11, 'Analyst', 'Sales');

-- Insert rows into projects_sales_detatils table
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(1, 'Project Alpha', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(2, 'Project Beta', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(3, 'Project Gamma', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(4, 'Project Delta', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(5, 'Project Epsilon', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(6, 'Project Zeta', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(7, 'Project Eta', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(8, 'Project Theta', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(9, 'Project Iota', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-04-30', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(10, 'Project Kappa', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO projects_sales_detatils (project_id, project_name, start_date, end_date) VALUES
(11, 'Project Lambda', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-02-28', 'YYYY-MM-DD'));

-- Insert rows into employee_projects_it table
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(1, 1, 'SysAdmin', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(2, 2, 'Network Engineer', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(3, 3, 'Database Admin', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(4, 4, 'Developer', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(5, 5, 'SysAdmin', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(6, 6, 'Network Engineer', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(7, 7, 'Database Admin', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(8, 8, 'Developer', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(9, 9, 'SysAdmin', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(10, 10, 'Network Engineer', 'IT');
INSERT INTO employee_projects_it (emp_id, project_id, role, department) VALUES
(11, 11, 'Database Admin', 'IT');

-- Insert rows into projects_it_detatils table
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(1, 'Project Alpha', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(2, 'Project Beta', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(3, 'Project Gamma', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(4, 'Project Delta', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(5, 'Project Epsilon', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(6, 'Project Zeta', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(7, 'Project Eta', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(8, 'Project Theta', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-05-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(9, 'Project Iota', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-04-30', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(10, 'Project Kappa', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO projects_it_detatils (project_id, project_name, start_date, end_date) VALUES
(11, 'Project Lambda', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-02-28', 'YYYY-MM-DD'));
COMMIT;
