FROM ubuntu:20.04

#program install
RUN mkdir /app
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/ports.ubuntu.com/ftp.harukasan.org/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server vim wget cron
RUN wget http://mirror.apache-kr.org/tomcat/tomcat-9/v9.0.38/bin/apache-tomcat-9.0.38.tar.gz
RUN tar xvzf apache-tomcat-9.0.38.tar.gz -C /app && rm -rf apache-tomcat-9.0.38.tar.gz
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

#tomcat settings
COPY ./srcs/project.war /app/apache-tomcat-9.0.38/webapps/
COPY ./srcs/server.xml /app/apache-tomcat-9.0.38/conf/
COPY ./srcs/web.xml /app/apache-tomcat-9.0.38/conf/
COPY ./srcs/context.xml /app/apache-tomcat-9.0.38/conf/
RUN rm -rf /app/apache-tomcat-9.0.38/webapps/ROOT
COPY ./srcs/tomcat /etc/init.d/
RUN sed -i -e 's/\r$//' /etc/init.d/tomcat
RUN chmod 755 /etc/init.d/tomcat
RUN update-rc.d tomcat defaults

#server settings
ENV TZ=Asia/Seoul
RUN echo set encoding=utf-8 >> /etc/vim/vimrc
RUN echo set fileencodings=utf-8,cp949 >> /etc/vim/vimrc
ENV CATALINA_HOME /app/apache-tomcat-9.0.38

#java
RUN mkdir /usr/lib/jvm
RUN mkdir /usr/lib/jvm/java-13-openjdk
RUN apt-get install -y openjdk-13-jdk
RUN mv -f /usr/lib/jvm/java-13-openjdk-*/* /usr/lib/jvm/java-13-openjdk
RUN rm -rf /usr/lib/jvm/java-13-openjdk-*
ENV JAVA_HOME /usr/lib/jvm/java-13-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
RUN wget https://downloads.mariadb.com/Connectors/java/connector-java-2.7.0/mariadb-java-client-2.7.0.jar -P /usr/lib/jvm/java-13-openjdk/lib/

#mariadb settings
COPY ./srcs/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN mkdir /app/database
COPY ./srcs/database/* /app/database/

#Language settings
RUN apt-get install -y locales
ENV LANGUAGE ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
RUN locale-gen ko_KR ko_KR.UTF-8

#api connect setting
RUN mkdir /app/api
COPY ./srcs/City301Api.java /app/api/
COPY ./srcs/HolidayApi.java /app/api/
COPY ./srcs/api_sync.sh /app/api/
RUN chmod 755 /app/api/api_sync.sh

#crontab settings

#run
COPY ./srcs/start.sh /
RUN sed -i -e 's/\r$//' start.sh
RUN chmod 755 /start.sh
CMD sh start.sh && bash

EXPOSE	80 3306
