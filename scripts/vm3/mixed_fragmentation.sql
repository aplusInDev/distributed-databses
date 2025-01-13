-- aplication de fragmentation mixte (fragmentation horizontale par departement[sales ou it] -- et verticale par projects et projects_details)
CREATE TABLE employee_projects_sales (
    emp_id NUMBER,
    project_id NUMBER,
    role VARCHAR2(50),
    department VARCHAR2(50) DEFAULT 'Sales',
    CONSTRAINT pk_emp_proj_sales PRIMARY KEY (emp_id, project_id),
    CONSTRAINT chk_proj_dept_sales CHECK (department = 'Sales')
);


CREATE TABLE projects_sales_detatils (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE employee_projects_it (
    emp_id NUMBER,
    project_id NUMBER,
    role VARCHAR2(50),
    department VARCHAR2(50) DEFAULT 'IT',
    CONSTRAINT pk_emp_proj_it PRIMARY KEY (emp_id, project_id),
    CONSTRAINT chk_proj_dept_it CHECK (department = 'IT')
);

CREATE TABLE projects_it_detatils (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE
);
