#!/bin/bash

MYSQL="mysql -uroot"
SEED="/opt/Papertrail/deploy/scripts/sql/seed"
echo "Initializing Papertrail DB"
$MYSQL <<MYSQL_SCRIPT
CREATE DATABASE papertrail;
CREATE USER 'papertrail'@'localhost' IDENTIFIED BY 'papertrail';
GRANT ALL PRIVILEGES ON papertrail.* TO 'papertrail'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "Running Seed scripts into Papertrail DB"
$MYSQL papertrail < $SEED/mysql-create.sql
$MYSQL papertrail < $SEED/mysql-seed.sql
$MYSQL papertrail < $SEED/common-seed.sql

echo 
echo "Papertrail DB has been initialized"
