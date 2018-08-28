
FROM nvcr.io/nvidia/cuda:9.0-cudnn7.1-devel-ubuntu16.04
LABEL maintainer "cvigroup.cfi@gmail.com"

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
        ruby-full \
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
        libboost-all-dev \
        libeigen3-dev \
        libgoogle-glog-dev \
        libopencv-dev \
        libsuitesparse-dev \
        python3-dev \
        python3-numpy \
        python3-pip \
        python-pyexiv2 \
        python3-pyproj \
        python3-scipy \
        python3-yaml \
        wget \
        libglew-dev \
        libglu1-mesa-dev \
        freeglut3-dev \
        mesa-common-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN echo "Python 2 die die die" && \
#sudo ln -s /usr/bin/pip3 /usr/bin/pip && \
#sudo mv /usr/bin/python /usr/bin/python.old && \
#sudo ln -s /usr/bin/python3 /usr/bin/python 	

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

RUN apt-get update
RUN apt-get install -y libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev
# Link boost libs
RUN cd /usr/lib/x86_64-linux-gnu/ && ln -s libboost_python-py3x.so libboost_python3.so && cd / && \
#Install opengv from source
#RUN \
    mkdir -p /source && cd /source && \
    git clone https://github.com/paulinus/opengv.git && \
    cd /source/opengv && \
    mkdir -p build && cd build && \
    cmake .. -DBUILD_TESTS=OFF \
             -DBUILD_PYTHON=ON \
             -DBUILD_FOR_PYTHON3=ON \
             -DBOOST_PYTHON3_COMPONENT=python-py36 \
             -DPYTHON_INSTALL_DIR=/usr/local/lib/python3.6/dist-packages/ \
             && \
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
    pip3 install exifread==2.1.2 \
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

# Source opencv3
RUN git clone --depth 1 https://github.com/opencv/opencv.git /root/opencv && \
        cd /root/opencv && \
        mkdir build && \
        cd build && \
        cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON .. && \
        make -j4  && \
        make install && \
        ldconfig && \
        echo 'ln /dev/null /dev/raw1394' >> ~/.bashrc && cat ~/.bashrc >> ~/.zshrc 

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

RUN git clone https://github.com/mapillary/OpenSfM.git && \
    cd OpenSfM && \
    2to3 setup.py && \
    python3 setup.py build

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
