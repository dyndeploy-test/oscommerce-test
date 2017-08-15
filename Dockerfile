FROM php:apache

RUN apt-get update && apt-get --no-install-recommends install unzip libjpeg-dev libpng-dev -y && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && docker-php-ext-install gd mysqli pdo_mysql
RUN cd /tmp && \
    curl -X POST "https://www.oscommerce.com/Products&Download=oscom-2.4.0" > oscommerce.zip && \
    unzip oscommerce.zip && \
    cp -ar oscommerce-2.4.0/catalog/* /var/www/html && \
    rm -r oscommerce.zip oscommerce-2.4.0 && \
    sed -i "s/if (.*http_server.*) {/if(false) {/" /var/www/html/includes/application_top.php && \
    chown -R www-data:www-data /var/www/html
