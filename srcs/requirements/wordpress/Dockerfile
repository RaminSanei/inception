# FROM debian:bullseye

# RUN apt-get update && apt-get install -y \
#     php-fpm php-mysql wget

# WORKDIR /var/www/html
# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz --strip-components=1 && \
#     rm latest.tar.gz

# COPY ./tools/start.sh /start.sh
# RUN chmod +x /start.sh

# EXPOSE 9000
# CMD [ "/start.sh" ]

FROM debian:bullseye

# Install dependencies with cleanup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php-fpm \
        php-mysql \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -sS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

# Configure PHP-FPM
RUN mkdir -p /run/php /var/www/html && \
    sed -i 's/listen = .*/listen = 9000/' /etc/php/*/fpm/pool.d/www.conf

# Set up WordPress
WORKDIR /var/www/html
RUN curl -sS https://wordpress.org/latest.tar.gz | tar -xz --strip-components=1 && \
    rm -f latest.tar.gz

# Copy and prepare scripts
COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000
CMD ["/start.sh"]