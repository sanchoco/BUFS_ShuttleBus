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

-- Add shuttle_domitory data with VIEW
CREATE VIEW shuttle_domitory
AS
SELECT id, DATE_ADD(arrive, INTERVAL 3 MINUTE) AS "arrive"
FROM shuttle_bufs;

-- Add shuttle_beomeoa data with VIEW
CREATE VIEW shuttle_beomeosa
AS
SELECT id, DATE_ADD(arrive, INTERVAL 7 MINUTE) AS "arrive"
FROM shuttle_bufs;

-- Add shuttle_namsan data with VIEW
CREATE VIEW shuttle_namsan
AS
SELECT id, DATE_ADD(arrive, INTERVAL 9 MINUTE) AS "arrive"
FROM shuttle_bufs;

-- Add shuttle_fireStation data with VIEW
CREATE VIEW shuttle_fire
AS
SELECT id, DATE_ADD(arrive, INTERVAL 13 MINUTE) AS "arrive"
FROM shuttle_bufs;

-- add town_bufs_namsan data
CREATE TABLE town_bufs_namsan (id INT PRIMARY KEY, arrive time);
INSERT INTO town_bufs_namsan
VALUES
(0, '07:55:00'),
(1, '14:13:00'),
(2, '18:13:00'),
(3, '23:13:00');

-- add town_namsan_bufs data
CREATE TABLE town_namsan_bufs (id INT PRIMARY KEY, arrive time);
INSERT INTO town_namsan_bufs
VALUES
(0, '09:55:00'),
(1, '13:55:00'),
(2, '20:55:00'),
(3, '23:20:00');

-- add town_bufs_guseo data
CREATE TABLE town_bufs_guseo (id INT PRIMARY KEY, arrive time);
INSERT INTO town_bufs_guseo
VALUES
(0, '10:10:00'),
(1, '14:10:00'),
(2, '19:10:00'),
(3, '23:10:00');

-- add town_guseo_bufs data
CREATE TABLE town_guseo_bufs (id INT PRIMARY KEY, arrive time);
INSERT INTO town_guseo_bufs
VALUES
(0, '10:10:00'),
(1, '14:10:00'),
(2, '19:10:00'),
(3, '23:10:00');

-- city_301 table !Don't Touch!
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
