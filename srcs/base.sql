-- Create database
CREATE DATABASE goSchool;
USE goSchool;

-- add shuttle_bufs data
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
(16, '22:15:00'),
(17, '22:50:00'),
(18, '23:10:00'),
(19, '23:20:00'),
(21, '23:45:00'),
(22, '23:30:00'),
(23, '23:45:00'),
(24, '23:59:00');

-- Add shuttle_beomeoa data with VIEW
CREATE VIEW shuttle_beomeosa
AS
SELECT id, DATE_ADD(arrive, INTERVAL 6 MINUTE) AS "arrive"
FROM shuttle_bufs;

-- city_301 table
CREATE TABLE city_301(idx INT PRIMARY KEY, min1 INT, min2 INT);
INSERT INTO city_301
VALUES
(10, NULL, NULL),
(62, NULL, NULL);

-- Create user and Add permission
CREATE USER 'readOnly'@'%' identified by '1234';
GRANT SELECT ON goSchool.* TO 'readOnly'@'%';
flush privileges;

CREATE USER 'apiUpdate'@'%' identified by '1234';
GRANT ALL PRIVILEGES ON goSchool.city_301 TO 'apiUpdate'@'%';
flush privileges;
