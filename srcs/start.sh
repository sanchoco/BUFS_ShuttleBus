service mysql start
sleep 1
mysql -u root < /app/base.sql
service mysql restart
service tomcat start
