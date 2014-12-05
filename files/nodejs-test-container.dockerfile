FROM ubuntu
MAINTAINER Hylke Stapersma "hylke.stapersma@gmail.com"

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV DEBIAN_FRONTEND noninteractive
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN unset LC_ALL

RUN apt-get update
RUN apt-get -y -q install node nodejs npm git git-core

RUN ln -fs /usr/bin/nodejs /usr/local/bin/node
