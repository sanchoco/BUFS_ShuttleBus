CREATE DATABASE goSchool;
USE goSchool;
CREATE TABLE shuttle_bufs ( id INT PRIMARY KEY, arrive time);

INSERT INTO shuttle_bufs
VALUES
(0, '07:55:00'),
(1, '08:05:00'),
(2, '08:17:00'),
(3, '08:20:00');

CREATE USER 'readOnly'@'%' identified by '1234';
GRANT ALL PRIVILEGES ON goSchool.* TO 'readOnly'@'%';
flush privileges;
