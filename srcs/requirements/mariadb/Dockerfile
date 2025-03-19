FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3306
CMD [ "/start.sh" ]