FROM registry.access.redhat.com/ubi8:8.8

# Log the OS Details of the container image
RUN cat /etc/os-release

# customary update before we install additional packages
RUN dnf update -y \
    && dnf install -y make unzip

# Enable required php version
RUN dnf module enable -y php:7.4

# Install php and basic modules
RUN dnf install -y php \
    && dnf install -y php-json php-mbstring php-xml php-pdo php-pear php-devel \
    && php -m \
    && php -i | grep -i "Loaded Configuration File"

# Install PHP package installer, required for app development
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version \
    && php --version
