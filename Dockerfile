FROM debian:buster

MAINTAINER danielpmc, <dan@danbot.host>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && apt-get install -y default-jre \
    && apt-get install liblzma-dev \
    && apt-get install lzma \
    && adduser container \
    && apt-get update 

# Grant sudo permissions to container user for commands
RUN apt-get update && \
    apt-get -y install sudo

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - \
    && apt -y install nodejs \
    && apt -y install ffmpeg \
    && apt -y install make \
    && apt -y install build-essential \
    && apt -y install wget \ 
    && apt -y install curl
    
# Install basic software support
RUN apt-get update && \
    apt-get install -y software-properties-common
    
# Python 2 & 3
RUN apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
RUN tar -xf Python-3.10.*.tgz
RUN cd Python-3.10.0 && ./configure --enable-optimizations && make -j 8 && make altinstall
RUN rm -rf Python-3.10.0
RUN rm Python-3.10.0.tgz
RUN apt -y install python python-pip python3-pip
RUN pip3 install --upgrade pip

# Golang
RUN apt -y install golang

# Installing NodeJS dependencies for AIO.
RUN npm i -g yarn pm2 

# Installing NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
