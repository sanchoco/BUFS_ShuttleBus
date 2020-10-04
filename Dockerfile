FROM ubuntu:20.04

#program install
RUN mkdir /app
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server vim wget
RUN wget http://mirror.apache-kr.org/tomcat/tomcat-9/v9.0.38/bin/apache-tomcat-9.0.38.tar.gz
RUN tar xvzf apache-tomcat-9.0.38.tar.gz -C /app && rm -rf apache-tomcat-9.0.38.tar.gz
RUN wget https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
RUN tar xvzf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz -C /app && rm -rf /openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
RUN wget https://downloads.mariadb.com/Connectors/java/connector-java-2.6.2/mariadb-java-client-2.6.2.jar -P /app/java-se-8u41-ri/lib
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

#tomcat settings
COPY	./srcs/project.war /app/apache-tomcat-9.0.38/webapps/
COPY	./srcs/server.xml /app/apache-tomcat-9.0.38/conf/
RUN		rm -rf /app/apache-tomcat-9.0.38/webapps/ROOT

#server settings
ENV		TZ=Asia/Seoul
RUN		echo set encoding=utf-8 >> /etc/vim/vimrc
RUN		echo set fileencodings=utf-8,cp949 >> /etc/vim/vimrc
ENV		JAVA_HOME /app/java-se-8u41-ri
ENV		CATALINA_HOME /app/apache-tomcat-9.0.38
ENV		PATH $PATH:$JAVA_HOME/bin
#RUN	echo "export JAVA_HOME=/app/java-se-8u41-ri" >> ~/.bashrc
#RUN	echo "export CATALINA_HOME=/app/apache-tomcat-9.0.38" >> ~/.bashrc
COPY	./srcs/tomcat /etc/init.d/
RUN		chmod 755 /etc/init.d/tomcat
RUN		update-rc.d tomcat defaults

#mariadb settings
COPY ./srcs/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./srcs/base.sql /app/

#Language settings
RUN apt-get install -y locales
ENV LANGUAGE ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
RUN locale-gen ko_KR ko_KR.UTF-8

#run
COPY ./srcs/start.sh /
RUN sed -i -e 's/\r$//' start.sh
CMD sh start.sh && bash

EXPOSE 80 3306
