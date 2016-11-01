# wunder/alpine-php
#
# VERSION v10.1.12-0
#
FROM quay.io/wunder/alpine-base:v3.4
MAINTAINER aleksi.johansson@wunder.io

# Update the package repository and install applications
RUN apk --no-cache --update add mariadb && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# You will want to install a db before using this image:
#
# @note this step is not included in this image as you may want
#  to first add your own my.cnf before creating the db structure
##
#RUN mysql_install_db && \
#    chown -R mysql:mysql /var/lib/mysql

# You may want to put logs on a volume
#
# @note this is not done in this image, as you may want to
#  pipe logs to /dev/1/fd/1 to get them to appear in the docker
#  logs
##
#VOLUME /var/log/mysql

# Expose port 3306
EXPOSE 3306

ENTRYPOINT ["mysqld_safe"]