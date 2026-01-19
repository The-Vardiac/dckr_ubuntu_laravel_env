FROM ubuntu:24.04

### system dependencies
RUN apt update && apt install -y \
    ca-certificates \
    software-properties-common \
    lsb-release \
    curl \
    gnupg \
    git \
    iputils-ping \
    gcc \
    make \
    autoconf \
    libtool \
    bison \
    re2c \
    pkg-config \
    wget

### github cli
# RUN mkdir -p -m 755 /etc/apt/keyrings \
# 	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
# 	&& cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
# 	&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
# 	&& mkdir -p -m 755 /etc/apt/sources.list.d \
# 	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# 	&& apt update \
# 	&& apt install gh -y

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
    php8.4-mysql \
    php-dev

# PIE
# RUN curl -fL --output /tmp/pie.phar https://github.com/php/pie/releases/latest/download/pie.phar \
#     && gh attestation verify --owner php /tmp/pie.phar \
#     && mv /tmp/pie.phar /usr/local/bin/pie \
#     && chmod +x /usr/local/bin/pie
# composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer
ENV PATH="$PATH:/root/.config/composer/vendor/bin"
# laravel
RUN composer global require laravel/installer
# redis
RUN pecl install redis  \
    && echo "extension=redis" > /etc/php/8.4/mods-available/redis.ini \
    && phpenmod redis

WORKDIR /opt/Dev