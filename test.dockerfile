FROM ubuntu:latest

ENV DISPLAY ${DISPLAY}:0.0

RUN echo "Hello world!"