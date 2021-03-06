# Use Alpine Linux
FROM alpine:3.5

# Timezone
ENV TIMEZONE America/Sao_Paulo
ENV PHP_MEMORY_LIMIT 4096M
ENV PHP_MAX_EXECUTION_TIME 180000
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

ADD ./conf/nginx.runit /etc/service/nginx/run
ADD ./conf/php7.runit /etc/service/php7/run

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
    && echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "@old http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
        runit@community \
        nginx \
        curl \
        git \
        openssh-client \
        openssl \
        php7@old \
        php7-dev@old \
        php7-curl@old \
        php7-common@old \
        php7-intl@old \
        php7-gd@old \
        php7-opcache@old \
        php7-phar@old \
        php7-mcrypt@old \
        php7-mbstring@old \
        php7-mysqli@old \
        php7-json@old \
        php7-iconv@old \
        php7-session@old \
        php7-ctype@old \
        php7-dom@old \
        php7-pdo@old \
        php7-pdo_mysql@old \
        php7-fpm@old \
        php7-redis@community \
        php7-bcmath@old \
        php7-soap@old \
        php7-xsl@old \
        php7-xdebug@old \
        php7-zlib@old \
        php7-openssl@old \
        php7-zip@old \
        nodejs \
        nodejs-npm

RUN npm install -g grunt-cli

RUN sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php7/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php7/php.ini && \
    sed -i "s|max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php7/php.ini && \
    sed -i "s|max_input_time =.*|max_input_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php7/php.ini && \
    sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php7/php.ini && \
    sed -i "s|display_errors =.*|display_errors = ON|" /etc/php7/php.ini && \
    sed -i "s|short_open_tag =.*|short_open_tag = ON|" /etc/php7/php.ini && \
    sed -i "s|;realpath_cache_size =.*|realpath_cache_size = 32k|" /etc/php7/php.ini && \
    sed -i "s|realpath_cache_ttl =.*|realpath_cache_ttl = 7200|" /etc/php7/php.ini && \
    sed -i "s|output_buffering =.*|output_buffering = 4096|" /etc/php7/php.ini && \
    echo "opcache.enable = 1" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.validate_timestamps=1" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.memory_consumption = 512" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.max_accelerated_files = 65406" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.max_wasted_percentage = 10" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.interned_strings_buffer=12" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.fast_shutdown=1" >> /etc/php7/conf.d/00_opcache.ini && \
    echo "opcache.enable_file_override=1" >> /etc/php7/conf.d/00_opcache.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini && \
    echo "zend_extension=xdebug.so" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_handler=dbgp" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_mode=req" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9001" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_host=docker.local" >> /etc/php7/conf.d/xdebug.ini && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    curl --insecure -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    mkdir /etc/nginx/sites-enabled && \
    adduser -u 1001 docker -D -s /bin/ash && \
    chown -R docker:docker /home/docker && \
    mkdir -p /etc/service && \
    chmod a+x /etc/service/nginx/run && \
    chmod a+x /etc/service/php7/run && \
    mkdir /www && \
    chown -R docker:docker /www && \
    apk del tzdata && \
    rm -fr /tmp/*.apk && \
    rm -rf /var/cache/apk/*

ADD ./conf/nginx.conf /etc/nginx/nginx.conf
ADD ./conf/default.conf /etc/nginx/sites-enabled/default
ADD ./conf/php-fpm.conf /etc/php7/php-fpm.conf
ADD ./conf/www.conf /etc/php7/php-fpm.d/www.conf
ADD ./run.sh /home/docker/run.sh

# Set Workdir
WORKDIR /www

# Expose ports
EXPOSE 80 443

CMD ["/home/docker/run.sh"]
