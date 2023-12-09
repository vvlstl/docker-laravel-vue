FROM php:8.2-fpm-alpine

# Устанавливаем рабочую директорию
WORKDIR /var/www/laravel

# Копируем composer.lock и composer.json
COPY src/composer.lock src/composer.json /var/www/laravel/

# Устанавливаем зависимости
RUN apk update && apk add --no-cache \
    build-base \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    musl-locales \
    zip \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    libpq \
    libzip-dev \
    nodejs  \
    npm \
    bash

# Очищаем кэш
RUN apk --no-cache add && rm -rf /var/cache/apk/*

# Устанавливаем расширения PHP
RUN docker-php-ext-install pdo pdo_mysql

# Загружаем актуальную версию Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# В контейнере открываем 9000 порт и запускаем сервер php-fpm
EXPOSE 9000
CMD ["php-fpm"]


