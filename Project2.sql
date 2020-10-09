/**********************************************************************************/
/*																	              */
/*  Date         Programmer       Description						              */
/*10-9-2020		 Lmarchant		  Initial implementation of the disk inventory db */
/*																	              */
/**********************************************************************************/

--Create Database
USE master;
DROP DATABASE IF EXISTS disk_inventoryLM;
GO
CREATE DATABASE disk_inventoryLM;
GO

USE disk_inventoryLM;

--Create server login
IF SUSER_ID ('diskUserlm') IS NULL
	CREATE LOGIN diskUserlm WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventoryLM;

DROP USER IF EXISTS diskUserlm;
CREATE USER diskUserlm;
AlTER ROLE db_datareader
	ADD MEMBER diskUserlm;

--Create Tables
CREATE TABLE artist_type (
	artist_type_id INT NOT NULL PRIMARY KEY IDENTITY,
	description    NVARCHAR(60) NOT NULL
);

CREATE TABLE disk_type (
	disk_type_id   INT NOT NULL PRIMARY KEY IDENTITY,
	description    NVARCHAR(60) NOT NULL
);

CREATE TABLE status (
	status_id      INT NOT NULL PRIMARY KEY IDENTITY,
	description    NVARCHAR(60) NOT NULL
);

CREATE TABLE genre (
	genre_id       INT NOT NULL PRIMARY KEY IDENTITY,
	description    NVARCHAR(60) NOT NULL
);

CREATE TABLE borrower (
	borrower_id    INT NOT NULL PRIMARY KEY IDENTITY,
	fname          NVARCHAR(60) NOT NULL,
	lname          NVARCHAR(60) NOT NULL,
	phone_num      VARCHAR(15)  NOT NULL
);

CREATE TABLE artist (
	artist_id      INT NOT NULL PRIMARY KEY IDENTITY,
	fname          NVARCHAR(60) NOT NULL,
	lname          NVARCHAR(60) NULL,
	artist_type_id INT NOT NULL REFERENCES artist_type(artist_type_id)
);

CREATE TABLE disk ( 
	disk_id        INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name      NVARCHAR(60) NOT NULL,
	release_date   DATE NOT NULL,
	genre_id       INT NOT NULL REFERENCES genre(genre_id),
	status_id      INT NOT NULL REFERENCES status(status_id),
	disk_type_id   INT NOT NULL REFERENCES disk_type(disk_type_id)
);

CREATE TABLE disk_has_borrower (
	borrower_id    INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id        INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date  DATETIME2 NOT NULL,
	returned_date  DATETIME2 NULL,
	PRIMARY KEY (borrower_id, disk_id)
);

CREATE TABLE disk_has_artist (
	disk_id        INT NOT NULL REFERENCES disk(disk_id),
	artist_id      INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id, artist_id)
);