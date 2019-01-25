FROM  nvcr.io/nvidia/caffe:19.01-py2

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
        libeigen3-dev \
        libopencv-dev \
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

# Openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose /workspace/openpose
RUN cd openpose && \
        mkdir build && \
        cd build && \
        cmake -DOpenCV_INCLUDE_DIRS=/home/"${USERNAME}"/softwares/opencv/build/install/include \
  -DOpenCV_LIBS_DIR=/home/"${USERNAME}"/softwares/opencv/build/install/lib \
  -DCaffe_INCLUDE_DIRS=/home/"${USERNAME}"/softwares/caffe/build/install/include \
  -DCaffe_LIBS=/home/"${USERNAME}"/softwares/caffe/build/install/lib/libcaffe.so -DBUILD_CAFFE=OFF \
  -WITH_EIGEN ..

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
