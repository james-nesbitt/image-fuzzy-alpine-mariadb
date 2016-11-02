# image-fuzzy-alpine-mariadb

Fuzzy as in reference to the https://en.wikipedia.org/wiki/The_Mythical_Man-Month book where Fred describes the approach of "write one to throw away" as the best start.

A base docker image for providing a Mariadb service with a default database.

Maintained by: James Nesbitt <james.nesbitt@wunder.io>

## Docker

### Image

This image is available publicly at:

- quay.io/wunder/fuzzy-alpine-mariadb : [![Docker Repository on Quay](https://quay.io/repository/wunder/fuzzy-alpine-mariadb/status "Docker Repository on Quay")](https://quay.io/repository/wunder/fuzzy-alpine-mariadb)

### Base

This image is based on https://github.com/wunderkraut/image-fuzzy-alpine-base

### Modifications

#### Install mariadb

1. Install standard maridb

#### etc/mysql/my.cnf

This image contains a highly tuned my.cnf:

1. Error and output logging goes to the container output;
2. Engine defaults to UTF-8 encoding and collation;
3. Cache settings are made more lenient;
4. Request timeout and size limits are increased;
5. InnoDB is used as a default, and is heavily tuned;
6. One or two custom changes relating to transaction locking are set.

#### A default database is created

- A general mysql installation is processed;
- Some default insecure mysql access is removed;
- The root password is set;
- The database `mysql://app:app@127.0.0.1/app` is created.

* Credentials used here are avaialble as build args for any custom application requirements.

## Using this Image

run this container as an independent service:

```
$/> docker run -d quay.io/wunder/image-fuzzy-alpine-mariadb
```

Then link the resulting container into any other containers that need a database.
Access to the database service is defined in the Dockerfile, and can be read there.

## TODO

1. some kind of automated testing would be usefull.
