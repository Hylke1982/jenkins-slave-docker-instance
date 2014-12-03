FROM ubuntu
MAINTAINER Hylke Stapersma "hylke.stapersma@gmail.com"

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV DEBIAN_FRONTEND noninteractive
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN unset LC_ALL

RUN apt-get update
RUN apt-get -y -q install build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev
RUN apt-get -y -q install git
RUN apt-get -y -q install ruby1.9
RUN apt-get -y -q install libxml2-dev
RUN apt-get -y -q install libxslt-dev
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install bundler puppet librarian-puppet

# create and configure work directory
RUN mkdir -p /puppet
WORKDIR /puppet

# Command to run at 'docker run'
CMD cd /puppet \
 && bundle install --quiet \
 && bundle exec rake spec
