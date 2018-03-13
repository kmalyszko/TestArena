#FROM php:5.6-apache
FROM php:5.6-fpm

RUN apt-get update && apt-get install -y mysql-client libpng-dev

RUN docker-php-ext-install mysql mysqli
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gd

WORKDIR /var/www/html

COPY . /var/www/html
COPY application.testing.ini ./application/configs/application.ini

RUN chmod -R 777 public/upload
RUN chmod -R 777 public/captcha
RUN chmod -R 777 logs/
RUN chmod -R 777 cache/
RUN chmod -R 777 temp/
