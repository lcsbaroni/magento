FROM debian:jessie

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV TIMEZONE America/Sao_Paulo
ENV PHP_MEMORY_LIMIT 1024M
ENV PHP_MAX_EXECUTION_TIME 300
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

# Install necessary packages
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        wget \
        curl \
        git \
        libcurl4-openssl-dev \
        libmcrypt-dev \
        libxml2-dev \
        libjpeg-dev \
        libjpeg62 \
        libfreetype6-dev \
        libmysqlclient-dev \
        libgmp-dev \
        libicu-dev \
        libpspell-dev \
        librecode-dev \
        libxpm-dev \
        nginx \
        supervisor \
        locales

# Ensure UTF-8 locale
RUN sed -i "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN locale-gen

RUN wget -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
  echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
  echo "\ndeb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list && \
  apt-get update

RUN apt-get install -y \
    openssh-client \
    php7.0 \
    php7.0-dev \
    php7.0-curl \
    php7.0-common \
    php7.0-intl \
    php7.0-gd \
    php7.0-opcache \
    php7.0-phar \
    php7.0-mcrypt \
    php7.0-mbstring \
    php7.0-mysqli \
    php7.0-json \
    php7.0-iconv \
    php7.0-ctype \
    php7.0-dom \
    php7.0-pdo \
    php7.0-fpm  \
    php7.0-redis \
    php7.0-bcmath \
    php7.0-soap \
    php7.0-xsl \
    php7.0-xdebug \
    php7.0-zip

RUN sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s|max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini

RUN curl --insecure -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer

# Configure PHP-FPM, Nginx and Supervisor
ADD conf/php-fpm.conf /etc/php7/php-fpm.conf
ADD conf/www.conf /etc/php7/php-fpm.d/www.conf
ADD ./conf/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./conf/nginx.conf /etc/nginx/sites-available/default

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm -fr /tmp/* /var/lib/apt/lists/* /var/tmp/* \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean

WORKDIR /www

EXPOSE 80

CMD ["/usr/bin/supervisord"]
