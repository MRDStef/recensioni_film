FROM php:8.2-apache
ARG UID
ARG GID
RUN apt-get update; apt-get install unzip git -y
RUN docker-php-ext-install mysqli pdo pdo_mysql && a2enmod rewrite
RUN a2enmod rewrite headers
RUN sed -ri -e 's/^([ \t]*)(<\/VirtualHost>)/\1\tSetEnvIf Origin "^http:\/\/(localhost|127\\.0\\.0\\.1):(3000|4200)$" cors_origin=$0\n\1\tHeader always set Access-Control-Allow-Origin "%{cors_origin}e" env=cors_origin\n\1\tHeader always set Access-Control-Allow-Headers "Content-Type, Authorization" env=cors_origin\n\1\tHeader always set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS" env=cors_origin\n\1\tHeader always set Access-Control-Allow-Credentials "true" env=cors_origin\n\1\2/g' /etc/apache2/sites-available/*.conf
EXPOSE 80
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ADD entrypoint-php.sh /entrypoint-php.sh
RUN sed -i 's/\r$//' /entrypoint-php.sh && chmod +x /entrypoint-php.sh
RUN groupadd -f informatica -g$GID
RUN adduser --disabled-password --uid $UID --gid $GID --gecos "" informatica || true
CMD ["/entrypoint-php.sh"]
