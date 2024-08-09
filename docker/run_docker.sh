xhost +local:

docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/claydergc/rosbags:/home/fast-lio2/rosbags fast-lio2
