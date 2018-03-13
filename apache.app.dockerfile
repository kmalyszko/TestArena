FROM php:5.6-apache
#FROM php:5.6-fpm
#FROM nimmis/apache-php5

#ENV APACHE_DOCUMENT_ROOT /var/www/html/public

#RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y mysql-client libpng-dev
#RUN apt-get install -y php5.6-mysql
#php-mysqli php-mbstring php-gd

#RUN docker-php-ext-install mysql mysqli
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gd

### for testing purposes ###
#RUN tee "php_admin_flag[log_errors]=On" > /usr/local/etc/php/php.ini

WORKDIR /var/www/html

COPY . /var/www/html
COPY application.testing.ini ./application/configs/application.ini
COPY apache.vhost.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite
RUN service apache2 restart

RUN chown -R www-data:www-data /var/www/html
#RUN chmod -R 777 public/upload
#RUN chmod -R 777 public/captcha
#RUN chmod -R 777 logs/
#RUN chmod -R 777 cache/
#RUN chmod -R 777 temp/
