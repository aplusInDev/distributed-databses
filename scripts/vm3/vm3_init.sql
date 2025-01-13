CREATE DATABASE LINK oracle_vm1_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM1';


CREATE DATABASE LINK oracle_vm2_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM2';

SELECT * FROM dual@oracle_vm1_link;
SELECT * FROM dual@oracle_vm2_link;
