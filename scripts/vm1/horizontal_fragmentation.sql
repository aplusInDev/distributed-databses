-- application de fragmentation horizontal par departement
CREATE TABLE employees_sales (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    department VARCHAR2(50),
    CONSTRAINT chk_dept_sales CHECK (department = 'Sales')
);

CREATE TABLE employees_it (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    department VARCHAR2(50),
    CONSTRAINT chk_dept_it CHECK (department = 'IT')
);
