service mysql start
sleep 1
mysql -u root < /app/base.sql
service mysql restart
/app/apache-tomcat-9.0.38/bin/catalina.sh start
