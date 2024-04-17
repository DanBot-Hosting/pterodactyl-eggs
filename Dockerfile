FROM debian:bullseye-slim

MAINTAINER danielpmc, <dan@danbot.host>

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt -y install lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update
RUN apt install -y php8.2 php8.2-fpm php8.2-mcrypt php8.2-soap php8.2-openssl php8.2-gmp php8.2-pdo_odbc php8.2-json php8.2-dom php8.2-pdo php8.2-zip php8.2-mysqli php8.2-sqlite3 php8.2-apcu php8.2-pdo_pgsql php8.2-bcmath php8.2-gd php8.2-odbc php8.2-pdo_mysql php8.2-pdo_sqlite php8.2-gettext php8.2-xmlreader php8.2-xmlrpc php8.2-bz2 php8.2-iconv php8.2-pdo_dblib php8.2-curl php8.2-ctype php8.2-phar php8.2-fileinfo php8.2-mbstring php8.2-tokenizer


USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
