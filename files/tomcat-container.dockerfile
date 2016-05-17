FROM java:7
MAINTAINER Hylke Stapersma "hylke.stapersma@gmail.com"

RUN wget -nv --no-cookies http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.47/bin/apache-tomcat-7.0.47.tar.gz -O /tmp/apache-tomcat-7.0.47.tar.gz

# Check the checksum, if it fails, print an error message
RUN echo "efbae77efad579b655ae175754cad3df /tmp/apache-tomcat-7.0.47.tar.gz" | md5sum -c > /dev/null 2>&1 || echo "ERROR: MD5SUM MISMATCH"
RUN tar xzf /tmp/apache-tomcat-7.0.47.tar.gz -C /opt
RUN rm /tmp/apache-tomcat-7.0.47.tar.gz

# The following volumes should not be considered part of the image, but contain runtime data
VOLUME ["/opt/apache-tomcat-7.0.47/logs", "/opt/apache-tomcat-7.0.47/work", "/opt/apache-tomcat-7.0.47/temp", "/tmp/hsperfdata_root"]
ENV CATALINA_HOME /opt/apache-tomcat-7.0.47
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080

# Start Tomcat in the foreground (run) to make sure docker does not immediately shutdown the container
CMD cp /webapps/*.war /opt/apache-tomcat-7.0.47/webapps \
 && /opt/apache-tomcat-7.0.47/bin/catalina.sh run \& \
 && sleep 60s