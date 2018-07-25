FROM node:10.6.0-alpine

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root
ENV COMPOSER_VERSION 1.6.5

RUN apk --no-cache add \
    openssh-client \
    php7 \
    php7-curl \
    php7-iconv \
    php7-mbstring \
    php7-json \
    php7-openssl \
    php7-phar

## Install Composer
RUN apk add --no-cache --virtual .build-deps curl \
    && curl -sfLo /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
    && php -r " \
        \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
        \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
        if (!hash_equals(\$signature, \$hash)) { \
            unlink('/tmp/installer.php'); \
            echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
            exit(1); \
        }" \
    && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
    && composer --ansi --version --no-interaction \
    && composer global require hirak/prestissimo \
    && rm -rf /root/.composer/cache/* \
    && rm -rf /tmp/* \
    && apk del .build-deps

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["node"]

