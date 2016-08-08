#!/bin/bash
echo "####################################### MARKER"
echo "Creating directories"

mkdir -p /opt/Papertrail/conf
cp /opt/papertrail.properties /opt/Papertrail/conf/
cp /opt/logback.groovy /opt/Papertrail/conf/
mkdir -p /opt/install
mkdir -p /opt/Papertrail/webapps/
mkdir -p /opt/Papertrail/plugins/

ln -s /opt/install/deploy /opt/Papertrail/deploy
ln -s /opt/install/libs /opt/Papertrail/libs
cp /opt/install/webapps/* /opt/Papertrail/webapps/
cp -r /opt/install/plugins/* /opt/Papertrail/plugins/
echo

[ "$(ls -A /var/lib/mysql)" ] || mysql_install_db

echo > /opt/dbexists
echo "####################################### MARKER"
echo "Starting MYSQL"
sh -c "/opt/start-db.sh"

MYSQL="mysql -uroot"
echo
DBEXISTS=$(cat /opt/dbexists)

if [ "$DBEXISTS" -eq 0 ]; then
  SEED="/opt/Papertrail/deploy/scripts/sql/seed"
  echo "####################################### MARKER"
  echo "Initializing Papertrail DB (Call to seed script)"
  sh -c "/opt/seed.sh"
  echo
else
  echo "####################################### MARKER"
  echo "DB Papertrail already exists ... continuing as normal (seed script SKIPPED)"
  echo
fi

echo "http.hostname=$VIRTUAL_HOST" >> /opt/Papertrail/conf/papertrail.properties
echo "####################################### MARKER"
echo "Starting Papertrail"

cd /opt/Papertrail
java -Xms256m -Xmx256m -classpath "$(echo deploy/*.jar libs/*.jar . | sed 's/ /:/g'):/opt/Papertrail/conf/" com.egis.Startup

echo "####################################### MARKER"
echo "We must have received a stop or java failed ..."

echo "####################################### MARKER"
echo "Trying to shutdown DB safely ..."
sh -c "/opt/stop-db.sh"
