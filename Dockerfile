# wunder/fuzzy-alpine-mariadb
#
# Adds a default database. The DB will be pre-configured based on build args,
# which have defaults
#
# Typically use this for access:
#    mysqli://app:app@{DB}/app
#
# VERSION v10.1.12-0
#
FROM quay.io/wunder/fuzzy-alpine-base:v3.4
MAINTAINER james.nesbitt@wunder.io

####
# Pull some args from the build command line (or docker-compose build: args: )
#
ARG MYSQL_ROOT_PASSWORD=root
ARG MYSQL_DATABASE=app
ARG MYSQL_USER=app
ARG MYSQL_PASSWORD=app

####
# Update the package repository and install mariadb applications
#
# - technically mariadb-client is not needed after db is created.
#
RUN apk --no-cache --update add mariadb && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

####
# Using a custom my.cnf
#
ADD etc/mysql/my.cnf /etc/mysql/my.cnf

####
# Initial db setup
# - Secure the db, leaving a lame root password, that can be changed in sub images, or in containers
# - Make sure that NOBODY can access the server without a password
# - Kill the anonymous users
# - Kill off the demo database
# - Make our changes take effect
#
# Additionally
# - try to stop the mysql server
# - remove the mysql client now that we don't need it anymore
# - clean up apk
#
RUN apk --no-cache --update add -t .build-deps mariadb-client && \
    mysql_install_db && \
    chown -R mysql:mysql /var/lib/mysql && \
    (/usr/bin/mysqld_safe &) && sleep 3 && \
    mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root'" && \
    mysql -u root -e "DELETE FROM mysql.user WHERE User=''" && \
    mysql -u root -e "DROP DATABASE test" && \
    mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE}" && \
    mysql -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* to ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'" && \
    mysql -u root -e "FLUSH PRIVILEGES" &&\
    killall mysqld && \
    sleep 3 # waiting for mysql to die && \
    apk del .build-deps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

####
# Expose port 3306
#
EXPOSE 3306

####
# Set entrypoint
#
ENTRYPOINT ["mysqld_safe"]
