FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql wget

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000
CMD [ "/start.sh" ]