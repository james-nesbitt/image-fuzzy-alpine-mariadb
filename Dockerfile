FROM quay.io/wunder/wunder-alpine-base
MAINTAINER ilari.makela@wunderkraut.com

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

VOLUME /var/log/mysql

# Expose port 3306
EXPOSE 3306

CMD ["mysqld_safe"]