-- Create database
CREATE DATABASE goSchool;
USE goSchool;

-- add shuttle_bufs data
CREATE TABLE shuttle_bufs ( id INT PRIMARY KEY, arrive time);
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

-- create town_bufs_namsan table
CREATE TABLE town_bufs_namsan (id INT PRIMARY KEY, arrive time);

-- create town_namsan_bufs table
CREATE TABLE town_namsan_bufs (id INT PRIMARY KEY, arrive time);

-- create town_bufs_guseo table
CREATE TABLE town_bufs_guseo (id INT PRIMARY KEY, arrive time);

-- create town_guseo_bufs table
CREATE TABLE town_guseo_bufs (id INT PRIMARY KEY, arrive time);

-- create town_bufs_namsan_holiday table
CREATE TABLE town_bufs_namsan_holiday (id INT PRIMARY KEY, arrive time);

-- create town_namsan_bufs_holiday table
CREATE TABLE town_namsan_bufs_holiday  (id INT PRIMARY KEY, arrive time);

-- create town_bufs_guseo_holiday table
CREATE TABLE town_bufs_guseo_holiday (id INT PRIMARY KEY, arrive time);

-- create town_guseo_bufs_holiday table
CREATE TABLE town_guseo_bufs_holiday (id INT PRIMARY KEY, arrive time);

-- city_301 table. Don't Touch This! 10=guseo, 62=nopo
CREATE TABLE city_301(idx INT PRIMARY KEY, min1 INT, min2 INT);
INSERT INTO city_301
VALUES
(10, NULL, NULL),
(62, NULL, NULL);

-- IP_LOG TABLE. Don't Touch This!
CREATE TABLE log (ip CHAR(20), date date, time time);

-- holiday TABLE
CREATE TABLE holiday (dateName char(50), locdate date PRIMARY KEY);

-- Create user and Add permission
CREATE USER 'readOnly'@'%' identified by '1234';
GRANT SELECT ON goSchool.* TO 'readOnly'@'%';
flush privileges;

CREATE USER 'apiUpdate'@'%' identified by '1234';
GRANT ALL PRIVILEGES ON goSchool.* TO 'apiUpdate'@'%';
flush privileges;

CREATE USER 'logWrite'@'%' identified by '1234';
GRANT ALL PRIVILEGES ON goSchool.log TO 'logWrite'@'%';
flush privileges;
