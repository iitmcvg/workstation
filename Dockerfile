FROM  nvcr.io/nvidia/tensorflow:18.06-py3
LABEL maintainer caffe-maint@googlegroups.com


RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
        git \
        wget \
	fuse \
	snapd \
	snap-confine \ 
	squashfuse \ 
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
apt-get install cmake && \
apt-get update


#ld config over ssh
RUN ldconfig

#netaccess
RUN apt-get update && \
  #curl -sSf https://static.rust-lang.org/rustup.sh | sh && \
#curl https://sh.rustup.rs -o rustup-init.sh && \
#sh rustup-init.sh -y
#RUN apt-get install -y libssl-dev 
#RUN /bin/bash -c "source $HOME/.cargo/env; cargo install --git https://github.com/j-jith/iitm-netaccess-cmd" 

#  apt-get install -y snapd && \
ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ARG BUILD_DATE
ARG SNAP_VERSION=latest

ENV SNAP_VERSION=${SNAP_VERSION}
ENV SNAP_TRUST_LEVEL=0
ENV SNAP_LOG_LEVEL=1
ENV CI_URL=https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io

LABEL vendor="Intelsdi-X" \
      name="Snap Ubuntu 16.04" \
      license="Apache 2.0" \
      build-date=$BUILD_DATE \
      io.snap-telemetry.snap.version=$SNAP_VERSION \
      io.snap-telemetry.snap.version.is-beta=

EXPOSE 8181

ADD ${CI_URL}/snap/${SNAP_VERSION}/linux/x86_64/snapteld  /opt/snap/sbin/snapteld
ADD ${CI_URL}/snap/${SNAP_VERSION}/linux/x86_64/snaptel  /opt/snap/bin/snaptel
COPY init_snap /usr/local/bin/init_snap
COPY snapteld.conf /etc/snap/snapteld.conf

#ENV LANG C.UTF-8
#ENV LC_ALL C.UTF-8
#RUN apt-get clean && \
 #dpkg-divert --local --rename --add /sbin/udevadm && \
 #ln -s /bin/true /sbin/udevadm
CMD systemctl start snap.service 
CMD snap install netaccess

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
