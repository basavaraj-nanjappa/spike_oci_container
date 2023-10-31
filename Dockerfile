# https://catalog.redhat.com/software/containers/ubi8/5c647760bed8bd28d0e38f9f?architecture=amd64&image=653651266d2632908205ec42
FROM registry.access.redhat.com/ubi8:8.8

# https://catalog.redhat.com/software/containers/ubi9/618326f8c0d15aff4912fe0b?architecture=amd64&image=652fc5bc9252cb8029f46161&container-tabs=gti
# FROM registry.access.redhat.com/ubi9:9.2

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

