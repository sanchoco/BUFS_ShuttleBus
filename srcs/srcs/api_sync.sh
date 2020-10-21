(sleep 1 && /usr/lib/jvm/java-13-openjdk/java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar City301Api >> /app/api/log.txt) &
	(sleep 20 && /usr/lib/jvm/java-13-openjdk/bin/java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar City301Api >> /app/api/log.txt) &
(sleep 40 && /usr/lib/jvm/java-13-openjdk/bin/java -cp /app/api:/usr/lib/jvm/java-13-openjdk/lib/mariadb-java-client-2.7.0.jar City301Api >> /app/api/log.txt)
