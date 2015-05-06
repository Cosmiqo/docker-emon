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

# Generate a password using pwgen if MYSQL_PASSWORD is not passed in
if [[ -z $MYSQL_PASSWORD ]]; then 
  MYSQL_PASSWORD="$(pwgen -s 12 1)"
fi

# Initialize the db and create the user 
echo "CREATE DATABASE emoncms;" >> init.sql
echo "CREATE USER 'emoncms'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> init.sql
echo "GRANT ALL ON emoncms.* TO 'emoncms'@'localhost';" >> init.sql
echo "flush privileges;" >> init.sql
mysql < init.sql

# Update the settings file for emoncms
EMON_DIR="/var/www/html"
cp "$EMON_DIR/default.settings.php" "$EMON_DIR/settings.php"
sed -i "s/_DB_USER_/emoncms/" "$EMON_DIR/settings.php"
sed -i "s/_DB_PASSWORD_/$MYSQL_PASSWORD/" "$EMON_DIR/settings.php"

echo "==========================================================="
echo "The username and password for the emoncms user is:"
echo ""
echo "   username: emoncms"
echo "   password: $MYSQL_PASSWORD"
echo ""
echo "==========================================================="

# Cleanup
rm init.sql
