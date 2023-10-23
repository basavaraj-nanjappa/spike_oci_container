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

# Installign composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer \
    && php -r "unlink('composer-setup.php');" \
    && composer --version \
    && php --version
