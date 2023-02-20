FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD=12345
ENV MYSQL_DATABASE=mydb
COPY yourfile.sql /docker-entrypoint-initdb.d/
