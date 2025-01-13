-- Create database links
CREATE DATABASE LINK vm1_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM1';

CREATE DATABASE LINK vm2_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM2';

CREATE DATABASE LINK vm3_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM3';

-- Test the DBLinks
-- On VM1
SELECT * FROM dual@vm1_link;
-- On VM2
SELECT * FROM dual@vm2_link;
-- On VM3
SELECT * FROM dual@vm3_link;


-- Create central tables
CREATE TABLE central_employees_sales (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    department VARCHAR2(50),
    CONSTRAINT chk_dept_sales CHECK (department = 'Sales')
);

CREATE TABLE central_employees_it (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    department VARCHAR2(50),
    CONSTRAINT chk_dept_it CHECK (department = 'IT')
);

CREATE TABLE central_employee_details (
    emp_id NUMBER PRIMARY KEY,
    address VARCHAR2(200),
    phone_number VARCHAR2(20),
    email VARCHAR2(100)
);

CREATE TABLE central_emp_projects_sales (
    emp_id NUMBER,
    project_id NUMBER,
    role VARCHAR2(50),
    department VARCHAR2(50) DEFAULT 'Sales',
    CONSTRAINT pk_emp_proj_sales PRIMARY KEY (emp_id, project_id),
    CONSTRAINT chk_proj_dept_sales CHECK (department = 'Sales')
);


CREATE TABLE central_prj_sales_detatils (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE central_employee_projects_it (
    emp_id NUMBER,
    project_id NUMBER,
    role VARCHAR2(50),
    department VARCHAR2(50) DEFAULT 'IT',
    CONSTRAINT pk_emp_proj_it PRIMARY KEY (emp_id, project_id),
    CONSTRAINT chk_proj_dept_it CHECK (department = 'IT')
);

CREATE TABLE central_projects_it_detatils (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE
);
