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
        apt-utils \
        lsb-core \
        libatlas-base-dev \
        libcurl4-gnutls-dev \
        wget \
        openssh-server \
        libgtk2.0-dev \
        pkg-config \
        libdc1394-22 libdc1394-22-dev \
        libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev libavcodec-dev \
        libavformat-dev libswscale-dev libxine2-dev \
        libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
        libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev \
        libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev \
        libvorbis-dev libxvidcore-dev x264 v4l-utils \
        ffmpeg \
        qtbase5-dev \
        curl unzip &&\
        rm -rf /var/lib/apt/lists/* &&\
        apt-get clean

# Opencv Build
WORKDIR /
ENV OPENCV_VERSION="3.1.0"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_QT=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=ON \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DPYTHON_EXECUTABLE=$(which python) \
  -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.zip \
&& rm -r /opencv-${OPENCV_VERSION} 

RUN ln -s \
  /usr/local/python/cv2/python-2.7/cv2.cpython-27m-x86_64-linux-gnu.so \
  /usr/local/lib/python2.7/site-packages/cv2.so

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
WORKDIR /workspace
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose
RUN cd openpose && \
        mkdir build && \
        cd build  && \
        cmake -DOpenCV_INCLUDE_DIRS=/usr/local/include \
  -DOpenCV_LIBS_DIR=/usr/local/lib \
  -DCaffe_INCLUDE_DIRS=/usr/local/include \
  -DCaffe_LIBS=/usr/local/lib/libcaffe.so -DBUILD_CAFFE=OFF \
  -WITH_EIGEN .. && make -j12

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace
