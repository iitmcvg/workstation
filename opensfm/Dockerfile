FROM ubuntu:16.04
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

# Install apt-getable dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        libatlas-base-dev \
        libboost-python-dev \
        libeigen3-dev \
        libgoogle-glog-dev \
        libopencv-dev \
        libsuitesparse-dev \
        python-dev \
        python-numpy \
        python-opencv \
        python-pip \
        python-pyexiv2 \
        python-pyproj \
        python-scipy \
        python-yaml \
        wget \
        libglew-dev \
        libglu1-mesa-dev \
        freeglut3-dev \
        mesa-common-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install Ceres from source
RUN \
    mkdir -p /source && cd /source && \
    wget http://ceres-solver.org/ceres-solver-1.14.0.tar.gz && \
    tar xvzf ceres-solver-1.14.0.tar.gz && \
    cd /source/ceres-solver-1.14.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make install && \
    cd / && \
    rm -rf /source/ceres-solver-1.14.0 && \
    rm -f /source/ceres-solver-1.14.0.tar.gz


# Install opengv from source
RUN \
    mkdir -p /source && cd /source && \
    git clone https://github.com/paulinus/opengv.git && \
    cd /source/opengv && \
    mkdir -p build && cd build && \
    cmake .. -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON && \
    make install && \
    cd / && \
    rm -rf /source/opengv

# Gosu
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

# Install python requirements
RUN \
    pip install exifread==2.1.2 \
                gpxpy==1.1.2 \
                networkx==1.11 \
                numpy \
                pyproj==1.9.5.1 \
                pytest==3.0.7 \
                python-dateutil==2.6.0 \
                PyYAML==3.12 \
                scipy \
                xmltodict==0.10.2 \
                cloudpickle==0.4.0 \
                loky==1.2.1 \
                --user

# Install Pangolin from source
Run \
    mkdir -p /source && cd source && \
    git clone https://github.com/stevenlovegrove/Pangolin.git && \
    cd /source/Pangolin && \
    mkdir -p /source/Pangolin/build && \
    cd /source/Pangolin/build && \
    cmake .. && \
    cmake --build . && \
    rm -rf /source/Pangolin 

ARG repository
FROM nvidia/cuda:9.0-devel-ubuntu16.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

ENV CUDNN_VERSION 7.2.1.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
            libcudnn7-dev=$CUDNN_VERSION-1+cuda9.0 && \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*





COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
