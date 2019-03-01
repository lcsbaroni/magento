# lcsbaroni/magento:2.3

NGINX and PHP image based on Alpine Linux

Image is based on the oficial image of alpine

## Docker image usage

```
docker run [docker-options] lcsbaroni/magento:2.3
```

## Examples

Typical basic usage:

```
docker run -it lcsbaroni/magento:2.3
```

Typical usage in Dockerfile:

```
FROM lcsbaroni/magento:2.3
RUN echo "<?php phpinfo() ?>" > /var/www/localhost/htdocs/index.php
```

Typical usage:

```
docker run -it --link=somedb:db lcsbaroni/magento:2.3
```

Typical usage on docker-compose:

```
docker-compose up -d
```