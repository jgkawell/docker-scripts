FROM ubuntu:latest

COPY ./.tmux.conf /root/.tmux.conf

VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

RUN apt update -y
RUN apt install -y x11-apps