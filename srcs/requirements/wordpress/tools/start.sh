#!/bin/bash
set -eo pipefail

# Move to WordPress directory
cd /var/www/html

# Wait for database to be ready (max 30 seconds)
timeout=30
while ! wp db check --allow-root >/dev/null 2>&1; do
  if [ $timeout -eq 0 ]; then
    echo "ERROR: Database connection timed out"
    exit 1
  fi
  echo "Waiting for database... (${timeout}s remaining)"
  sleep 1
  timeout=$((timeout-1))
done

# Download WordPress if not present
if [ ! -f wp-config.php ]; then
  wp core download --allow-root

  # Configure WordPress
  wp config create \
    --url="$WP_URL" \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASS" \
    --dbhost="$DB_HOST" \
    --skip-check \
    --allow-root

  # Install WordPress
  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

  # Create additional user
  wp user create \
    "$WP_USER" \
    "$WP_USER_EMAIL" \
    --role=author \
    --user_pass="$WP_PASS" \
    --allow-root
fi

# Start PHP-FPM
exec php-fpm7.4 -F