FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx \
        openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42Heilbronn/CN=${DOMAIN_NAME}" \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 443
COPY ./conf/default /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;" ]