# alpine-mariadb

A base docker image for providing a mariadb (mysql) service

Maintained by: Aleksi Johansson <aleksi.johansson@wunder.io>

## Docker

### Image

This image is available publicly at:

- quay.io/wunder/alpine-mariadb : [![Docker Repository on Quay](https://quay.io/repository/wunder/alpine-mariadb/status "Docker Repository on Quay")](https://quay.io/repository/wunder/alpine-mariadb)

### Base

This image is based on https://github.com/wunderkraut/alpine-base

### Modifications

#### Install mariadb

1. Install standard maridb

## Using this Image

run this container as an independent service:

```
$/> docker run -d quay.io/wunder/alpine-mariadb
```

* link any containers that need a db to this one
* this image is not necessarily usefull for run-time orchestration as
  it contains no initialized database.

## TODO

1. some kind of automated testing would be usefull.
