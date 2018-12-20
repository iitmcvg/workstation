FROM ubuntu:latest 
MAINTAINER varun "varun19299@gmail.com"  

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
        git \
        vim \
        sudo \
        htop \
        imagemagick \
        man \
        fdupes \
        libcurl4-gnutls-dev \
        wget \
        curl &&\
        rm -rf /var/lib/apt/lists/* &&\
        apt-get clean

RUN apt-get update \ 
        && apt-get install -y python3-pip python3-dev \
        && cd /usr/local/bin \ 
        && ln -s /usr/bin/python3 python \
        && pip3 install --upgrade pip 

RUN apt-get install -y cmake 

# Pip installs
RUN python3 -m pip install jupyter numpy scipy matplotlib

WORKDIR /workspace


CMD echo "Welcome to docker container for Python 3.6"

CMD jupyter notebook --ip=0.0.0.0 --allow-root
