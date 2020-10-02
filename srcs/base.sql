CREATE DATABASE goSchool;
USE goSchool;
CREATE TABLE shuttle_bufs ( id INT PRIMARY KEY, arrive time);

INSERT INTO shuttle_bufs
VALUES
(0, '07:55:00'),
(1, '08:05:00'),
(2, '08:17:00'),
(3, '08:20:00'),
(4, '10:30:00'),
(5, '11:20:00'),
(6, '14:40:00'),
(7, '15:10:00'),
(8, '16:15:00'),
(9, '17:25:00'),
(10, '17:50:00'),
(11, '18:45:00'),
(12, '19:20:00'),
(13, '20:00:00'),
(14, '21:25:00'),
(15, '21:50:00'),
(16, '22:15:00');

CREATE USER 'readOnly'@'%' identified by '1234';
GRANT ALL PRIVILEGES ON goSchool.* TO 'readOnly'@'%';
flush privileges;
