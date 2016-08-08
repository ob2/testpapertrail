#!/bin/bash
set -e

echo "Starting Mysql DB"
mysqld_safe --skip-syslog &

echo "Waiting 10s for DB to init"
sleep 10
mysql -uroot -e "SHOW DATABASES;" 
mysql -uroot -e "SHOW DATABASES;" | grep -c papertrail > /opt/dbexists
