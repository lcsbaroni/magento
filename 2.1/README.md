# lcsbaroni/alpine:nginx-5.6

NGINX and PHP image based on Alpine Linux

Image is based on the oficial image of alpine

## Docker image size

[![](https://badge.imagelayers.io/lcsbaroni/alpine:nginx-5.6.svg)](https://imagelayers.io/?images=lcsbaroni/alpine:nginx-5.6 'NGINX with PHP 5.6')

## Docker image usage

```
docker run [docker-options] lcsbaroni/alpine:nginx-5.6
```

## Examples

Typical basic usage:

```
docker run -it lcsbaroni/alpine:nginx-5.6
```

Typical usage in Dockerfile:

```
FROM lcsbaroni/alpine:nginx-5.6
RUN echo "<?php phpinfo() ?>" > /var/www/localhost/htdocs/index.php
```

Typical usage:

```
docker run -it --link=somedb:db lcsbaroni/alpine:nginx-5.6
```

Typical usage on docker-compose:

```
docker-compose up -d
```