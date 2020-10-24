echo "-------| Server Setting... |-------"
service mysql start
sleep 3
mysql -u root < /app/database/base.sql
mysql -u root < /app/database/shuttle_bufs.sql
mysql -u root < /app/database/town_bufs_guseo.sql
mysql -u root < /app/database/town_guseo_bufs.sql
mysql -u root < /app/database/town_bufs_namsan.sql
mysql -u root < /app/database/town_namsan_bufs.sql
mysql -u root < /app/database/town_bufs_guseo_holiday.sql
mysql -u root < /app/database/town_guseo_bufs_holiday.sql
mysql -u root < /app/database/town_bufs_namsan_holiday.sql
mysql -u root < /app/database/town_namsan_bufs_holiday.sql
sleep 2
service mysql restart
service tomcat start
echo "--------------Finish---------------\n"

echo "------| 301bus and Holiday data Sync... |------"
javac -d /app/api -cp /app/api/*.jar /app/api/City301Api.java
java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar City301Api

javac -d /app/api -cp /app/api/*.jar /app/api/HolidayApi.java
java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar HolidayApi
echo "* * * * * /app/api/api_sync.sh\n0,1 0 1 1,6 * /usr/lib/jvm/java-13-openjdk/bin/java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar HolidayApi >> /app/api/log.txt" | crontab
service cron restart
echo "--------------Finish---------------"

#security
rm -rf /app/apache-tomcat-9.0.38/webapps/examples
rm -rf /app/apache-tomcat-9.0.38/webapps/manager
rm -rf /app/apache-tomcat-9.0.38/webapps/docs
rm -rf /app/apache-tomcat-9.0.38/webapps/host-manager
chmod 750 /app/apache-tomcat-9.0.38/webapps
rm -f /app/base.sql
