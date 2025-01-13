-- application de fragmentation verticale par details des employes
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department VARCHAR2(50)
);

CREATE TABLE employee_details (
    emp_id NUMBER PRIMARY KEY,
    address VARCHAR2(200),
    phone_number VARCHAR2(20),
    email VARCHAR2(100)
);
