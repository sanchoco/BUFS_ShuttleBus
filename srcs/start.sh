echo "-------| Server Setting... |-------"
service mysql start
sleep 1
mysql -u root < /app/base.sql
service mysql restart
service tomcat start
echo "--------------Finish---------------\n"

echo "------| 301bus and Holiday data Sync... |------"
javac -d /app/api -cp /app/api/*.jar /app/api/City301Api.java
java -cp /app/api:/app/java-se-8u41-ri/lib/mariadb-java-client-2.7.0.jar City301Api

javac -d /app/api -cp /app/api/*.jar /app/api/HolidayApi.java
java -cp /app/api:/app/java-se-8u41-ri/lib/mariadb-java-client-2.7.0.jar HolidayApi
echo "* * * * * /app/api/api_sync.sh\n0,1 0 1 1,6 * /app/java-se-8u41-ri/bin/java -cp /app/api:/app/java-se-8u41-ri/lib/mariadb-java-client-2.7.0.jar HolidayApi >> /app/api/log.txt" | crontab
service cron restart
echo "--------------Finish---------------"
