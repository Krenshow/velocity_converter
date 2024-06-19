FROM ros:humble

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV TZ=Europe/Moscow

ENV ROS_DISTRO humble

# ................................................................................
# init Colcon workspace ..........................................................

RUN apt update && apt install -y --no-install-recommends \
  python3-pip python3-apt curl && \
  pip3 install -U colcon-common-extensions colcon-ros-bundle

# ................................................................................
# copy pkgs ......................................................................

COPY ./velocity_converter /ros2ws/src/velocity_converter

# ................................................................................
# build pkgs .....................................................................

RUN /bin/bash -c '. /opt/ros/$ROS_DISTRO/setup.bash; cd /ros2ws/ && colcon build --symlink-install'

# ................................................................................
# setup entrypoint ...............................................................

COPY ./ros_entrypoint.sh /
RUN chmod 755 ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
