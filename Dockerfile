FROM ubuntu:20.04
ARG sql_password="Password123!"

EXPOSE 3306

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt update && \
    apt upgrade -y

ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -q -y mysql-server

RUN grep -v bind-address /etc/mysql/my.cnf > temp.txt \
  && mv temp.txt /etc/mysql/my.cnf

ENV sql_password=$sql_password

COPY init_sql.sh /

RUN chmod +x /init_sql.sh

CMD /init_sql.sh && sleep infinity
