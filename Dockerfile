FROM ubuntu:20.04

#program install
RUN mkdir /app
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget mariadb-server vim
RUN wget http://mirror.apache-kr.org/tomcat/tomcat-9/v9.0.38/bin/apache-tomcat-9.0.38.tar.gz
RUN tar xvzf apache-tomcat-9.0.38.tar.gz -C /app && rm -rf apache-tomcat-9.0.38.tar.gz
RUN wget https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
RUN tar xvzf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz -C /app && rm -rf /openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
RUN wget https://downloads.mariadb.com/Connectors/java/connector-java-2.6.2/mariadb-java-client-2.6.2.jar -P /app/apache-tomcat-9.0.38/lib/
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

#tomcat settings
COPY ./srcs/project.war /app/apache-tomcat-9.0.38/webapps/
COPY ./srcs/server.xml /app/apache-tomcat-9.0.38/conf/

#server settings
ENV	TZ=Asia/Seoul
RUN echo set encoding=utf-8 >> /etc/vim/vimrc
RUN echo set fileencodings=utf-8,cp949 >> /etc/vim/vimrc
ENV JAVA_HOME /app/java-se-8u41-ri
ENV CATALINA_HOME /app/apache-tomcat-9.0.38
#	RUN echo "export JAVA_HOME=/app/java-se-8u41-ri" >> ~/.bashrc
#	RUN echo "export CATALINA_HOME=/app/apache-tomcat-9.0.38" >> ~/.bashrc


#run
CMD service mysql start && bash /app/apache-tomcat-9.0.38/bin/catalina.sh start && bash

EXPOSE 8080
