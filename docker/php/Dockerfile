FROM php:8.3-fpm-alpine3.21

# Install required extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Install additional extensions required by CodeIgniter 4 and Laravel
RUN apk add --no-cache \
  libpng-dev \
  libjpeg-turbo-dev \
  libwebp-dev \
  libxpm-dev \
  freetype-dev \
  libzip-dev \
  oniguruma-dev \
  icu-dev \
  g++ \
  make \
  autoconf

RUN apk add --no-cache $PHPIZE_DEPS \
  && pecl install redis

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && docker-php-ext-install intl \
  && docker-php-ext-install mbstring \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install opcache\
  && docker-php-ext-enable redis

# Set working directory
WORKDIR /var/www/html
