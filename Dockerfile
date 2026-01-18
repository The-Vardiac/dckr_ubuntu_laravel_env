FROM ubuntu:24.04

### system dependencies
RUN apt update && apt install -y \
    ca-certificates \
    software-properties-common \
    lsb-release \
    curl \
    gnupg \
    git \
    iputils-ping

### php environment
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update
RUN apt install -y \
    php8.4-fpm \
    php8.4-common \ 
    php8.4-bcmath \
    php8.4-bz2 \
    php8.4-curl \
    php8.4-gd \
    php8.4-gmp \
    php8.4-intl \
    php8.4-mbstring \
    php8.4-opcache \
    php8.4-readline \
    php8.4-xml \
    php8.4-zip \
    php8.4-mysql
# composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer
ENV PATH="$PATH:/root/.config/composer/vendor/bin"
# laravel
RUN composer global require laravel/installer

WORKDIR /opt/Dev