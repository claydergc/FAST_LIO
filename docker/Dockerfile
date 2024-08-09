FROM osrf/ros:kinetic-desktop-full-xenial

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y curl \
    && apt-get install -y tar \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y ros-kinetic-navigation \
    && apt-get install -y ros-kinetic-robot-localization \
    && apt-get install -y ros-kinetic-robot-state-publisher \
    && apt-get install -y software-properties-common \
    && apt-get install -y libeigen3-dev \
    && apt-get -y install sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a custom user with UID 1234 and GID 1234
#RUN groupadd -g 1234 customgroup && \
#    useradd -m -u 1234 -g customgroup fast-lio2 &&\

RUN useradd -m fast-lio2 && echo "fast-lio2:1234" | chpasswd && adduser fast-lio2 sudo


# Switch to the custom user
USER fast-lio2

# Set the workdir
WORKDIR /home/fast-lio2

SHELL ["/bin/bash", "-c"]

#RUN mkdir ~/MyLibraries

RUN mkdir ~/MyLibraries \
    && cd ~/MyLibraries \
    && git clone https://github.com/Livox-SDK/Livox-SDK.git \
    && cd Livox-SDK \
    && cd build && cmake .. \
    && make -j 10 \
    && echo 1234 | sudo -S make install

RUN mkdir -p ~/catkin_ws/src \
    && cd ~/catkin_ws/src \
    && git clone https://github.com/Livox-SDK/livox_ros_driver.git \
    && cd .. \
    && source /opt/ros/kinetic/setup.bash \
    && catkin_make
    
RUN curl -LO https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.0.tar.gz \
    && tar -xf pcl-1.8.0.tar.gz \
    && cd pcl-pcl-1.8.0 && mkdir build && cd build \
    && cmake .. \
    && make -j 10 \
    && echo 1234 | sudo -S make install

RUN cd ~/catkin_ws/src \
    && git clone https://github.com/claydergc/FAST_LIO.git \
    && cd .. \
    && source /opt/ros/kinetic/setup.bash \
    && catkin_make clean \
    && catkin_make

#RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc \
#    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
    && echo "source /home/fast-lio2/catkin_ws/devel/setup.bash" >> ~/.bashrc

    
RUN mkdir ~/rosbags

#WORKDIR /root/catkin_ws
