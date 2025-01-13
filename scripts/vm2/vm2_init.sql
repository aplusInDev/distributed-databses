CREATE DATABASE LINK oracle_vm1_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM1';


CREATE DATABASE LINK oracle_vm3_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM3';

SELECT * FROM dual@oracle_vm1_link;
SELECT * FROM dual@oracle_vm3_link;
