FROM debian:jessie

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

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

RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list \
    && curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && apt-get update \
    && apt-get -y --no-install-recommends install php7.0-cli php7.0-apcu php7.0-apcu-bc php7.0-curl \
        php7.0-json php7.0-mcrypt php7.0-opcache php7.0-readline php7.0-xml php7.0-zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer

RUN adduser -u 1000 docker -D -s /bin/ash && \
    chown -R docker:docker /home/docker && \
    mkdir /www && \
    chown -R docker:docker /www && \

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

WORKDIR /

EXPOSE 80

CMD ["/usr/bin/supervisord"]
