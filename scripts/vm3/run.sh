#!/bin/bash


# Wait for database to be ready
sleep 30
cd /app

# modify tnsnames.ora
cat /app/tnsanmes.txt >> /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora

# restart listener
lsnrctl reload

# test connections
echo "Testing connection with xe..."
tnsping xe

echo "Testing connection with vm1..."
tnsping vm1

echo "Testing connection with vm2..."
tnsping vm2

echo "Testing connection with vm3..."
tnsping vm3

# create databse links and tables
sqlplus system/oracle @vm3_init.sql

# apply mixed fragmentation
sqlplus system/oracle @mixed_fragmentation.sql

# insert some rows
sqlplus system/oracle @vm3_dump.sql

