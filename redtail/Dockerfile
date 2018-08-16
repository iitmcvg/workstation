FROM  nvcr.io/nvidia/tensorflow:18.05-py2
LABEL maintainer caffe-maint@googlegroups.com

# Basic packages
RUN apt-get update && apt-get -y  --no-install-recommends install software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
    ant \
    bzip2 \
    ca-certificates \
    ccache \
    cmake \
    curl \
    fuse \
    fdupes \
    genromfs \
    git \
    gosu \
    htop \
    imagemagick \
    iproute \
    iputils-ping \
    less \
    lcov \
    libeigen3-dev \
    libopencv-dev \
    libcurl4-gnutls-dev \
    make \
    nano \
    net-tools \
    ninja-build \
    openjdk-8-jdk \
    openssl \
    openssh-server \
    patch \
    pkg-config \
    protobuf-compiler \
    python-argparse \
    python-dev \
    python-empy \
    python-numpy \
    python-pip \
    python-serial \
    python-software-properties \
    rsync \
    s3cmd \
    snapd \
	snap-confine \ 
	squashfuse \ 
    software-properties-common \
    sudo \
    unzip \
    xsltproc \
    vim \
    wget \
    zip \
    zsh && \
    rm -rf /var/lib/apt/lists/* &&\
    apt-get clean

# pip packages
RUN pip install setuptools wheel \
    # coveralls code coverage reporting
    && pip install cpp-coveralls \
    # jinja template generation
    && pip install jinja2 \
    # Add Fast-RTPS
    && cd /opt && curl http://www.eprosima.com/index.php/component/ars/repository/eprosima-fast-rtps/eprosima-fast-rtps-1-5-0/eprosima_fastrtps-1-5-0-linux-tar-gz?format=raw | tar xz eProsima_FastRTPS-1.5.0-Linux/share/fastrtps/fastrtpsgen.jar eProsima_FastRTPS-1.5.0-Linux/bin/fastrtpsgen \
    && ln -s /opt/eProsima_FastRTPS-1.5.0-Linux/bin/fastrtpsgen /usr/local/bin/fastrtpsgen \
    && mkdir -p /usr/local/share/fastrtps && ln -s /opt/eProsima_FastRTPS-1.5.0-Linux/share/fastrtps/fastrtpsgen.jar /usr/local/share/fastrtps/fastrtpsgen.jar

# Gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
        && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
            && gpg --verify /usr/local/bin/gosu.asc \
                && rm /usr/local/bin/gosu.asc \
                    && chmod +x /usr/local/bin/gosu

# User entrypoints
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"]

# GStreamer
RUN apt-get update 
RUN apt-get -y --no-install-recommends install \
    gstreamer1.0-plugins-base        \
    gstreamer1.0-plugins-bad         \
    gstreamer1.0-plugins-ugly        \
    gstreamer1.0-plugins-base-apps   \
    gstreamer1.0-plugins-good        \
    gstreamer1.0-tools               \
    libgstreamer1.0-dev              \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libyaml-cpp-dev                  \
    v4l-utils

# Gazebo
<<<<<<< HEAD
RUN echo ${HOME}
WORKDIR ${HOME}
RUN wget --quiet http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
=======
#WORKDIR ${HOME}
RUN cd /home/$USERNAME && wget --quiet http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
>>>>>>> 092d0caae0208b829396f8f26b10a485c7736d63
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable xenial main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && apt-get update && apt-get -y --no-install-recommends install \
        gazebo7         \
        libgazebo7-dev  \
    # px4tools
    && pip install px4tools \
    # dronekit latest
    && git clone https://github.com/dronekit/dronekit-python.git                         \
    && (cd dronekit-python && pip install -r requirements.txt) && rm -rf dronekit-python \
    # pymavlink latest
    && git clone https://github.com/ArduPilot/pymavlink.git && cd pymavlink                             \
    && git clone git://github.com/mavlink/mavlink.git && ln -s ${PWD}/mavlink/message_definitions ../   \
    && pip install . && cd .. && rm -rf pymavlink && rm -rf message_definitions

# PX4 firmware
WORKDIR /home/$USERNAME
RUN mkdir ./px4/ && cd ./px4/                                        \
    && git clone https://github.com/PX4/Firmware.git && cd Firmware/ \
    && git checkout v1.4.4 

# ROS Kinetic
WORKDIR /home/$USERNAME
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list' \
    && sh -c 'echo "deb http://packages.ros.org/ros-shadow-fixed/ubuntu/ xenial main" > /etc/apt/sources.list.d/ros-shadow.list' \
    && apt-get update && apt-get -y --no-install-recommends install \
        ros-kinetic-gazebo-ros-pkgs \
        ros-kinetic-mavros          \
        ros-kinetic-mavros-extras   \
        ros-kinetic-ros-base        \
        ros-kinetic-joy             \
        ros-kinetic-rviz            \
    && apt-get -y autoremove        \
    && apt-get clean autoclean      \
    && rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# Initialize ROS
RUN geographiclib-get-geoids egm96-5 \
    && rosdep init                   \
    && rosdep update

RUN echo 'source /opt/ros/kinetic/setup.bash' >> ${HOME}/.bashrc

# Install OpenCV with CUDA support.
# REVIEW alexeyk: JetPack 3.2 comes with OpenCV 3.3.1 _without_ CUDA support.
WORKDIR /home/$USERNAME
RUN git clone https://github.com/opencv/opencv.git && cd opencv \
    && git checkout 3.3.1                   \
    && mkdir build && cd build              \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE    \
        -D CMAKE_INSTALL_PREFIX=/usr/local  \
        -D WITH_CUDA=OFF                     \
        -D WITH_OPENCL=OFF                  \
        -D ENABLE_FAST_MATH=1               \
        -D CUDA_FAST_MATH=1                 \
        -D WITH_CUBLAS=1                    \
        -D BUILD_DOCS=OFF                   \
        -D BUILD_PERF_TESTS=OFF             \
        -D BUILD_TESTS=OFF                  \
        ..                                  \
    && make -j `nproc`                      \
    && make install                         \
    && cd ${HOME} && rm -rf ./opencv/

# Setup catkin workspace
ENV CATKIN_WS /home/$USERNAME/ws
COPY ./scripts/init_workspace.sh /home/$USERNAME/
COPY .bashrc /home/$USERNAME/
RUN /home/$USERNAME//init_workspace.sh

# To be run by a user after creating a container.
COPY ./scripts/build_redtail.sh ${HOME}

ENV CCACHE_CPP2=1
ENV CCACHE_MAXSIZE=1G
ENV DISPLAY :0
#ENV PATH "/usr/lib/ccache:$PATH"
ENV TERM=xterm
# Some QT-Apps/Gazebo don't not show controls without this
ENV QT_X11_NO_MITSHM 1

# SITL UDP PORTS
EXPOSE 14556/udp
EXPOSE 14557/udp

# CMAKE 3.3
RUN apt-get update && \
apt-get install -y software-properties-common && \
add-apt-repository ppa:george-edison55/cmake-3.x && \
apt-get install cmake && \
apt-get update

# x11 
RUN apt-get update
RUN apt-get install -qqy x11-apps

#ld config over ssh
RUN ldconfig

# Set up zsh + zim
#RUN cd /home/$USERNAME && sh -c "$(wget https://gist.githubusercontent.com/rsnk96/87229bd910e01f2ee7c35f96d7cb2f6c/raw/f068812ebd711ed01ebc4c128c8624730ab0dc81/build-zsh.sh -O -)" && \
#RUN git clone --recursive https://github.com/Eriner/zim.git /home/$USERNAME/.zim && \
#ln -s /home/$USERNAME/.zim/templates/zimrc $HOME/.zimrc && \
#ln -s /home/$USERNAME/.zim/templates/zlogin $HOME/.zlogin && \
#ln -s /home/$USERNAME/.zim/templates/zshrc $HOME/.zshrc

# Lang configs for tensorboard
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /workspace
