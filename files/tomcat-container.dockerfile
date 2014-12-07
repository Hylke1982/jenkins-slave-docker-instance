FROM dockerfile/java
MAINTAINER Hylke Stapersma "hylke.stapersma@gmail.com"

RUN apt-get -y -q update
RUN apt-get -y -q install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
EXPOSE 8080
CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out