-- Create database
CREATE DATABASE goSchool;
USE goSchool;

-- add shuttle_bufs data
CREATE TABLE shuttle_bufs ( id INT PRIMARY KEY, arrive time);
INSERT INTO shuttle_bufs
VALUES
	(0, '07:55:00'),
	(1, '08:05:00'),
	(2, '08:15:00'),
	(3, '08:17:00'),
	(4, '08:20:00'),
	(5, '08:23:00'),
	(6, '08:25:00'),
	(7, '08:28:00'),
	(8, '08:30:00'),
	(9, '08:33:00'),
	(10, '08:35:00'),
	(11, '08:40:00'),
	(12, '08:45:00'),
	(13, '08:50:00'),
	(14, '08:55:00'),
	(15, '09:00:00'),
	(16, '09:03:00'),
	(17, '09:05:00'),
	(18, '09:08:00'),
	(19, '09:10:00'),
	(21, '09:13:00'),
	(22, '09:15:00'),
	(23, '09:18:00'),
-- sample start
	(30, '10:30:00'),
	(31, '11:20:00'),
	(32, '14:40:00'),
	(33, '15:10:00'),
	(34, '16:15:00'),
	(35, '17:25:00'),
	(36, '17:50:00'),
	(37, '18:45:00'),
	(38, '19:20:00'),
	(39, '20:00:00'),
	(40, '21:25:00'),
	(41, '21:50:00'),
	(42, '22:15:00'),
	(43, '22:50:00'),
	(44, '23:10:00'),
	(45, '23:20:00'),
	(46, '23:45:00'),
	(47, '23:30:00'),
	(48, '23:45:00'),
	(49, '23:59:00'),
-- sample end
	(130, '22:15:00');

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

-- add town_bufs_namsan_holiday data
CREATE TABLE town_bufs_namsan_holiday (id INT PRIMARY KEY, arrive time);
INSERT INTO town_bufs_namsan_holiday
VALUES
(0, '07:55:00'),
	(1, '14:13:00'),
	(2, '18:13:00'),
	(3, '23:13:00');

-- add town_namsan_bufs_holiday data
CREATE TABLE town_namsan_bufs_holiday  (id INT PRIMARY KEY, arrive time);
INSERT INTO town_namsan_bufs_holiday
VALUES
(0, '09:55:00'),
	(1, '13:55:00'),
	(2, '20:55:00'),
	(3, '23:20:00');

-- add town_bufs_guseo data
CREATE TABLE town_bufs_guseo_holiday (id INT PRIMARY KEY, arrive time);
INSERT INTO town_bufs_guseo_holiday
VALUES
(0, '10:10:00'),
	(1, '14:10:00'),
	(2, '19:10:00'),
	(3, '23:10:00');

-- add town_guseo_bufs data
CREATE TABLE town_guseo_bufs_holiday (id INT PRIMARY KEY, arrive time);
INSERT INTO town_guseo_bufs_holiday
VALUES
(0, '10:10:00'),
	(1, '14:10:00'),
	(2, '19:10:00'),
	(3, '23:10:00');


-- city_301 table. Don't Touch This! 10=guseo, 62=nopo
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
