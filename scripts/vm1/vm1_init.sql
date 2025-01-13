-- creation d'une database link
CREATE DATABASE LINK oracle_vm2_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM2';


CREATE DATABASE LINK oracle_vm3_link
CONNECT TO system IDENTIFIED BY oracle
USING 'VM3';

-- test de database link
SELECT * FROM dual@oracle_vm2_link;
SELECT * FROM dual@oracle_vm3_link;

/* CREATE DATABASE LINK oracle_vm2_link
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oracle-vm1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
)';
*/
