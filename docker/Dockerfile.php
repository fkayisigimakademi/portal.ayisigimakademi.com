# Resmi Moodle PHP Apache imajı - tüm gerekli eklentiler dahil
# PHP 8.3 + Apache + Moodle için gerekli tüm PHP extension'lar
FROM moodlehq/moodle-php-apache:8.3-bookworm

# Ek araçlar
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Moodle veri dizini
RUN mkdir -p /var/moodledata && chown -R www-data:www-data /var/moodledata

# Moodle 5.x: repo root çalışma dizini
# (Apache'nin DocumentRoot public/ olacak şekilde aşağıda ayarlanıyor)
WORKDIR /var/www/moodle

# Apache'yi Moodle 5.x public/ dizinine yönlendir
RUN echo '<VirtualHost *:80>\n\
    ServerName portal.localhost\n\
    DocumentRoot /var/www/moodle/public\n\
    <Directory /var/www/moodle/public>\n\
        Options FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/moodle.conf \
    && a2ensite moodle.conf \
    && a2dissite 000-default.conf \
    && a2enmod rewrite

EXPOSE 80
