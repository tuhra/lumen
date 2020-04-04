FROM php:7.2-fpm

# Copy composer.lock and composer.json
COPY ./src/composer.lock ./src/composer.json /var/www/

# Set working directory
WORKDIR /var/www

RUN apt-get update && apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY src/ /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]