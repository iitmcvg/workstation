FROM  nvcr.io/nvidia/pytorch:18.07-py3
LABEL maintainer caffe-maint@googlegroups.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
        git \
        wget \
        zsh \
        vim \
        sudo \
        zsh \
        htop \
        imagemagick \
        fdupes \
        openssl \
        libcurl4-gnutls-dev \
        wget \
        openssh-server \
        curl &&\
        rm -rf /var/lib/apt/lists/* &&\
        apt-get clean

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
        && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
            && gpg --verify /usr/local/bin/gosu.asc \
                && rm /usr/local/bin/gosu.asc \
                    && chmod +x /usr/local/bin/gosu

RUN apt-get update && \
apt-get install -y software-properties-common && \
add-apt-repository ppa:george-edison55/cmake-3.x && \
apt-get install -y cmake && \
apt-get update


#ld config over ssh
RUN ldconfig

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
