FROM ubuntu
MAINTAINER Hylke Stapersma "hylke.stapersma@gmail.com"

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV DEBIAN_FRONTEND noninteractive
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN unset LC_ALL

RUN apt-get update
RUN apt-get install -y -q curl
RUN apt-get install -y -q build-essential
RUN apt-get install -y -q openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

# install RVM, Ruby, and Bundler
RUN gpg -q --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -s -L https://get.rvm.io | bash -s stable --quiet-curl --autolibs=enabled
RUN /bin/bash -l -c "rvm --quiet-curl requirements"
RUN /bin/bash -l -c "rvm --quiet-curl install 2.1.4"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "gem install puppet librarian-puppet --no-ri --no-rdoc"
RUN /bin/bash -l -c "gem install rspec-puppet --no-ri --no-rdoc"
