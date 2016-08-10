# Use Alpine Linux
FROM alpine:3.4

# Timezone
ENV TIMEZONE America/Sao_Paulo
ENV PHP_MEMORY_LIMIT 1024M
ENV PHP_MAX_EXECUTION_TIME 300
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

ADD ./conf/nginx.runit /etc/service/nginx/run
ADD ./conf/php7.runit /etc/service/php7/run

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
        runit@testing \
        nginx \
        curl \
        git \
        openssh-client \
        php7@testing \
        php7-dev@testing \
        php7-curl@testing \
        php7-common@testing \
        php7-intl@testing \
        php7-gd@testing \
        php7-opcache@testing \
        php7-openssl@testing \
        php7-phar@testing \
        php7-mcrypt@testing \
        php7-mbstring@testing \
        php7-mysqli@testing \
        php7-json@testing \
        php7-iconv@testing \
        php7-session@testing \
        php7-ctype@testing \
        php7-dom@testing \
        php7-pdo@testing \
        php7-pdo_mysql@testing \
        php7-fpm@testing  \
        php7-redis@testing \
        php7-bcmath@testing \
        php7-amqp@testing \
        php7-soap@testing \
        php7-xsl@testing \
        php7-xdebug@testing \
        php7-zip@testing && \
    sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php7/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php7/php.ini && \
    sed -i "s|max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php7/php.ini && \
    sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php7/php.ini && \
    sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php7/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini && \
    echo "xdebug.remote_enable=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_handler=dbgp" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_mode=req" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9001" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $6 }'` >> /etc/php7/conf.d/xdebug.ini && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    curl --insecure -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    mkdir /etc/nginx/sites-enabled && \
    adduser -u 1000 docker -D -s /bin/ash && \
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

# Set Workdir
WORKDIR /www

# Expose ports
EXPOSE 80 443

CMD ["sh", "-c", "exec /sbin/runsvdir -P /etc/service/"]
