echo "-------| Server Setting... |-------"
service mysql start
sleep 1
mysql -u root < /app/base.sql
service mysql restart
service tomcat start
echo "--------------Finish---------------\n"

echo "------| 301bus data Sync... |------"
javac -d /app/api -cp /app/api/*.jar /app/api/ApiExplorer.java
java -cp /app/api:/app/java-se-8u41-ri/lib/mariadb-java-client-2.7.0.jar ApiExplorer
echo "* * * * * /app/api/api_sync.sh" | crontab
service cron restart
echo "--------------Finish---------------"
