FROM composer:2 AS composer

FROM php:8.3-apache

# Install OS deps for PHP extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        nodejs \
        npm \
        unzip \
        libicu-dev \
        libzip-dev \
        libxml2-dev \
        libonig-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libgmp-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache modules commonly required
RUN a2enmod rewrite headers expires deflate filter

# Configure & install PHP extensions required by FusionCMS
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        intl \
        zip \
        soap \
        gd \
        gmp

# mbstring, dom, libxml are enabled/bundled in this image; ensure they're present
# (dom/libxml come from php-xml, typically enabled by default in official images)
RUN docker-php-ext-install -j$(nproc) \
        mbstring \
        xml

# Apache document root = repo root (FusionCMS front controller lives at /index.php)
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Keep Apache config consistent with custom docroot
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Allow .htaccess overrides (Rewrite rules)
RUN sed -ri 's/AllowOverride\s+None/AllowOverride All/g' /etc/apache2/apache2.conf

# PHP runtime defaults (safe for local dev)
RUN { \
      echo 'memory_limit=512M'; \
      echo 'max_execution_time=300'; \
      echo 'upload_max_filesize=64M'; \
      echo 'post_max_size=64M'; \
    } > /usr/local/etc/php/conf.d/99-fusioncms-dev.ini

WORKDIR /var/www/html

# Install PHP dependencies (self-contained image)
COPY composer.json composer.lock ./
RUN composer install --no-interaction --prefer-dist --no-progress

# Install frontend dependencies used by theme asset bundling
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy application code (excluding by .dockerignore)
COPY . ./

# Ensure writable paths exist (permissions are best-effort; bind mounts on Windows may ignore chown)
RUN mkdir -p writable/cache writable/logs writable/uploads \
        && chown -R www-data:www-data writable || true
