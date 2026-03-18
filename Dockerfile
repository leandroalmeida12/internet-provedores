FROM php:8.2-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git zip unzip curl libpng-dev libonig-dev libxml2-dev libzip-dev && \
    docker-php-ext-install pdo pdo_mysql zip

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Criar diretório da aplicação
WORKDIR /app

# Copiar projeto Laravel
COPY . .

# Instalar dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Gerar APP_KEY corretamente
RUN php artisan key:generate --force

# Expor porta usada pelo Artisan
EXPOSE 8080

# Iniciar servidor Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]