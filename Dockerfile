FROM alpine:3.3
MAINTAINER ilari.makela@wunderkraut.com

# Update the package repository and install applications
RUN apk --no-cache --update add mariadb && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    mysql_install_db

VOLUME /var/lib/mysql
VOLUME /var/log/mysql

# Expose port 3306
EXPOSE 3306

CMD ["mysqld_safe"]