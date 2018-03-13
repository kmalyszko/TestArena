FROM php:5.6-apache

RUN apt-get update && apt-get install -y mysql-client libpng-dev
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gd

WORKDIR /var/www/html

COPY . /var/www/html
### copy app configuration file -> you have to create it first and fill with working data (database, mails, captha secrets and so on) ###
COPY application.testing.ini ./application/configs/application.ini
COPY apache.vhost.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite
RUN service apache2 restart

RUN chown -R www-data:www-data /var/www/html
