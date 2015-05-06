#!/bin/bash

# Start MySQL Server
service mysql start > /dev/null 2>&1

RET=1
while [[ RET -ne 0 ]]; do
  echo "Waiting for MySQL to start..."
  sleep 5
  mysql -e "status" > /dev/null 2>&1
  RET=$?
done

# Initialize the db and create the user 
echo "CREATE DATABASE emoncms;" >> init.sql
echo "CREATE USER 'emoncms'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> init.sql
echo "GRANT ALL ON emoncms.* TO 'emoncms'@'localhost';" >> init.sql
echo "flush privileges;" >> init.sql
mysql < init.sql

# Cleanup
rm init.sql

# Stop MySQL Server
service mysql stop > /dev/null 2>&1

RET=0
while [[ RET -eq 0 ]]; do
  echo "Waiting for MySQL to stop..."
  sleep 5
  mysql -e "status" > /dev/null 2>&1
  RET=$?
done
