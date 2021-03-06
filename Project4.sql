/**********************************************************************************/
/*																	              */
/*  Date         Programmer       Description						              */
/*10-9-2020		 Lmarchant		  Initial implementation of the disk inventory db */
/*10-16-2020	 Lmarchant        Add Insert statements for all tables			  */
/*10-22-2020     Lmarchant        Add reports as specified in Project 4           */
/*10-28-2020     Lmarchant        Add ins, ups, del proc for the disk, artisit, borrower */
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

--Project 3

--Inserts for artist_type
INSERT INTO artist_type (description)
VALUES ('Solo');
INSERT INTO artist_type (description)
VALUES ('Groups');

--Inserts for disk_type
INSERT INTO disk_type (description)
VALUES 
	('CD'), 
	('Vinyl'),
	('8Track'),
	('Cassette'),
	('DVD');

--Inserts for genre
INSERT INTO genre (description)
VALUES
	('Classic Rock')
	,('Country')
	,('Jazz')
	,('AltRock')
	,('Metal')
	;

--Inserts for status
INSERT status
VALUES ('Available');
INSERT status
VALUES ('On loan');
INSERT status
VALUES ('Damaged');
INSERT status
VALUES ('Missing');

--Inserts for Borrower
INSERT borrower (fname, lname, phone_num)
VALUES('Mickey', 'Mouse', '123-123-1234')
	 ,('Minnie', 'Mouse', '222-222-2221')
	 ,('Daisy', 'Duck', '333-333-3321')
	 ,('Daffy', 'Duck', '444-444-4321')
	 ,('Donald', 'Duck', '555-555-4321')
	 ,('Huey', 'Duck', '666-666-5432')
	 ,('Dewey', 'Duck', '777-777-6543')
	 ,('Louie', 'Duck', '544-474-4321')
	 ,('Elmer', 'Fudd', '494-434-4321')
	 ,('Buzz', 'Lightyear', '448-499-4391')
	 ,('Sheriff', 'Woody', '134-499-4371')
	 ,('Little Bo', 'Peep', '754-444-9021')
	 ,('Slink', 'Dog', '665-344-4321')
	 ,('Mr. Potato', 'Head', '111-478-4945')
	 ,('Mr.', 'Spell', '550-422-7863')
	 ,('Race', 'Car', '907-677-9812')
	 ,('T', 'Rex', '286-690-5491')
	 ,('Mrs. Potato', 'Head', '345-981-3345')
	 ,('Sargeant', 'Soldier', '789-123-4529')
	 ,('Jessie', 'Cowgirl', '770-411-6590')
	 ;

--Delete 1 row
DELETE borrower
WHERE borrower_id = 20;

--Insert artist rows
INSERT Artist
VALUES ('Ozzy', 'Osbourne', 1);
INSERT Artist
VALUES ('ACDC', NULL, 2);
INSERT Artist
VALUES ('Prince', NULL, 1);
INSERT Artist
VALUES ('Five Finger Death Punch', NULL, 2);
INSERT Artist
VALUES ('Creedance Clearwater Revival', NULL, 2);
INSERT Artist
VALUES ('Billy', 'Joel', 1);
INSERT Artist
VALUES ('The Eagles', NULL, 2);
INSERT Artist
VALUES ('Willie', 'Nelson', 1);
INSERT Artist
VALUES ('Johhny', 'Cash', 1);
INSERT Artist
VALUES ('Jimi', 'Hendrix', 1);
INSERT Artist
VALUES ('Cream', NULL, 2);
INSERT Artist
VALUES ('Chris', 'Daughtry', 1);
INSERT Artist
VALUES ('Bob', 'Seager', 1);
INSERT Artist
VALUES ('The Rolling Stones', NULL, 2);
INSERT Artist
VALUES ('Linkin Park', NULL, 2);
INSERT Artist
VALUES ('Led Zeppelin', NULL, 2);
INSERT Artist
VALUES ('Def Leppard', NULL, 2);
INSERT Artist
VALUES ('Steve Miller Band', NULL, 2);
INSERT Artist
VALUES ('Green Day', NULL, 2);
INSERT Artist
VALUES ('Bryan', 'Adams', 1);

--Disk table inserts
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Crazy Train', '1/1/1975', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('No More Tears', '1/1/1975', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Frotunate Son', '3/23/1971', 2, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Shoot To Thrill', '4/12/1970', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Hotel California', '11/1/1977', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('White Room', '1/27/1965', 2, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Heaven', '5/25/1977', 1, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Numb', '2/22/2001', 1, 4, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Hey Joe', '6/23/1960', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Old Time Rock and Roll', '11/12/1976', 2, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Rockn Me', '9/30/1972', 2, 1, 4);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Pour Some Sugar On Me', '11/23/1968', 2, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Ring of Fire', '12/23/1955', 1, 2, 4);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Highwayman', '4/21/1960', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Vitalogy', '3/22/1994', 4, 3, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Its Not Over', '7/28/2002', 1, 4, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('Bad Company', '8/31/2001', 1, 4, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('On the Road Again', '6/21/1965', 2, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('What Ive Done', '9/26/2005', 1, 4, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES('I Walk the Line', '1/12/1966', 4, 2, 2);

--Update 1 disk row
UPDATE disk
SET release_date = '1/23/1967'
WHERE disk_name = 'I Walk the Line';

--Inserts to disk_has_borrower
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 4, '1-2-2012', '2-20-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 3, '1-20-2012', '2-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 3, '5-20-2013', '7-28-2013');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 4, '1-2-2012', '1-12-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 1, '3-12-2012', '3-29-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 2, '4-8-2012', '4-12-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (4, 3, '9-25-2012', '9-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 3, '8-25-2012', '10-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 3, '3-25-2012', '4-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 2, '9-25-2012', '9-31-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 2, '7-22-2012', '8-24-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 3, '5-22-2012', '5-26-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 1, '2-25-2012', '3-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 1, '10-15-2012', '11-23-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (4, 1, '12-25-2012', '12-28-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (4, 3, '10-3-2012', '10-14-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 4, '6-11-2012', '6-27-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (4, 4, '7-24-2012', '7-31-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (1, 2, '9-11-2012', '9-23-2012');
INSERT INTO disk_has_borrower (borrower_id, disk_id, borrowed_date, returned_date)
VALUES (2, 3, '5-25-2012', '6-8-2012');

--Inserts to disk_has_artist
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,1);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,1);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,1);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,2);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,2);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,2);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,3);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,3);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,3);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,4);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,4);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,4);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,2);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,4);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,1);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,1);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,2);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(2,4);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(4,3);
INSERT disk_has_artist (disk_id, artist_id)
VALUES(1,1);

--Project 4
--3.
SELECT disk_name, release_date, fname, lname
FROM artist
JOIN disk_has_artist
    ON disk_has_artist.artist_id = artist.artist_id
JOIN disk 
    ON disk.disk_id = disk_has_artist.disk_id
WHERE artist_type_id = 1
ORDER BY disk_name DESC;

--4. Create a view called View_Individual_Artist that shows the artists� names and not group names. Include the artist id in the view definition but do not display the id in your output.
USE disk_inventoryLM
GO
CREATE VIEW View_Individual_Artist 
AS 
SELECT fname, lname, artist_id, artist_type_id
FROM artist
WHERE artist_type_id = 1
GO
SELECT fname AS FirstName, lname AS LastName
FROM View_Individual_Artist
GO


--5. Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view. 
--SELECT * FROM View_Individual_Artist

ALTER VIEW View_Individual_Artist
AS
SELECT disk_name AS DiskName, release_date AS ReleaseDate, fname AS ArtistFirstName
FROM artist
JOIN disk_has_artist ON disk_has_artist.artist_id = artist.artist_id
JOIN disk ON disk.disk_id = disk_has_artist.disk_id
WHERE artist_type_id = 2
go

SELECT *
FROM View_Individual_Artist
ORDER BY DiskName DESC;
go

--6. Show the borrowed disks and who borrowed them.
SELECT fname AS First, lname AS Last, disk_name AS DiskName, borrowed_date AS BorrowedDate, release_date AS ReturnedDate
FROM borrower
JOIN disk_has_borrower ON disk_has_borrower.borrower_id = borrower.borrower_id
JOIN disk ON disk.disk_id = disk_has_borrower.disk_id
WHERE status_id = 2
							--See output for other specifications

--7.
SELECT disk.disk_id AS Diskid, disk_name AS DiskName,COUNT(*) AS 'Times Borrowed'
FROM disk
join disk_has_borrower on disk.disk_id = disk_has_borrower.disk_id
group by disk.disk_id, disk_name
order by disk.disk_id
GO

--8.
SELECT disk_name AS DiskName, borrowed_date AS Borrowed, returned_date AS Returned, lname AS LastName
FROM disk
JOIN disk_has_borrower ON disk_has_borrower.disk_id = disk.disk_id
JOIN borrower ON disk_has_borrower.borrower_id = borrower.borrower_id
WHERE returned_date IS NULL

--Project 5
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name nvarchar(60), @release_date date, @genre_id int,
	@status_id int, @disk_type_id int
AS
	BEGIN TRY
		INSERT disk(disk_name, release_date, genre_id, status_id, disk_type_id)
		VALUES (@disk_name, @release_date, @genre_id, @status_id, @disk_type_id);
	END TRY
	BEGIN CATCH
		PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
EXEC sp_ins_disk 'Superknown2', '3/3/1994', 4, 1, 1;
GO
EXEC sp_ins_disk 'Superknown3', '3/3/1994', 4, 1, NULL;
GO