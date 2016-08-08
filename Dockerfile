FROM egis/base-mysql

ENV DEBIAN_FRONTEND noninteractive

COPY ./papertrail.properties /opt/
COPY ./start.sh /
COPY ./logback.groovy /opt/
COPY ./start-db.sh /opt/
COPY ./seed.sh /opt/
COPY ./stop-db.sh /opt/
COPY ./my.cnf /etc/mysql/my.cnf

EXPOSE 80
CMD /bin/sh /start.sh
