# Etapa 1 - Build
FROM composer:2 AS build

WORKDIR /app

# Copia apenas composer.json (não precisa de composer.lock)
COPY composer.json ./
RUN composer install --no-dev --optimize-autoloader

# Copia todo o projeto
COPY . .

# Etapa 2 - Runtime
FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git \
    && docker-php-ext-install pdo pdo_mysql zip

COPY --from=build /app /app

WORKDIR /app

# Gerar APP_KEY
RUN php artisan key:generate --force

EXPOSE 8080

# Inicia Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]