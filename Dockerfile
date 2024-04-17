FROM alpine:latest
MAINTAINER danielpmc, <dan@danbot.host>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && apt-get -y install liblzma-dev \
    && apt-get -y install lzma \
    && adduser container \
    && apt-get update \ 
    && apt -y install cmake \
    && apt -y install wget


RUN apk --update --no-cache add ca-certificates nginx
RUN apk add php8.2 php8.2-fpm php8.2-mcrypt php8.2-soap php8.2-openssl php8.2-gmp php8.2-pdo_odbc php8.2-json php8.2-dom php8.2-pdo php8.2-zip php8.2-mysqli php8.2-sqlite3 php8.2-apcu php8.2-pdo_pgsql php8.2-bcmath php8.2-gd php8.2-odbc php8.2-pdo_mysql php8.2-pdo_sqlite php8.2-gettext php8.2-xmlreader php8.2-xmlrpc php8.2-bz2 php8.2-iconv php8.2-pdo_dblib php8.2-curl php8.2-ctype php8.2-phar php8.2-fileinfo php8.2-mbstring php8.2-tokenizer

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install the speedtest by ookla
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash \
    && apt-get install speedtest -y
# For calling speedtest, enter command "speedtest --accept-license YES"

# Install the system dependencies required for puppeteer support
RUN apt-get install -y \
    fonts-liberation \
    gconf-service \
    libappindicator1 \
    libasound2 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libfontconfig1 \
    libgbm-dev \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libicu-dev \
    libjpeg-dev \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpng-dev \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    xdg-utils


USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
