CREATE Database DB_Literate
GO

USE DB_Literate
GO

/*==============================
		DROP TABLES
=============================*/

--DROP TABLE tBORROW;
--DROP TABLE tBRANCH;
--DROP TABLE tPUBLISHER;
--DROP TABLE tBOOK;
--DROP TABLE tAUTHOR;
--DROP TABLE tCOPIES;
--DROP TABLE tLOANS;

/*==============================
		CREATE TABLES
=============================*/

Create Table tBORROWER (
	CardID INT PRIMARY KEY NOT NULL IDENTITY (1000,1),
	mbrName NVARCHAR(60) NOT NULL,
	mbrAddress NVARCHAR(100) NOT NULL,
	mbrPhone BIGINT NOT NULL
)

Create Table tBRANCH (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	BranchNAME NVARCHAR(60) NOT NULL,
	BranchADDRESS NVARCHAR(100) NOT NULL,
	BranchPHONE BIGINT NOT NULL		--Added this... (The DB requires the publisher # and not the branch #? thats weird)
)

Create Table tPUBLISHER (
	BkPublisher NVARCHAR(60) PRIMARY KEY NOT NULL,
	PubADDRESS NVARCHAR(100),			--Accepts NULL values 
	PubPHONE BIGINT				--Accepts NULL values 
)

Create Table tBOOK (
	BookID INT PRIMARY KEY NOT NULL IDENTITY (1002,1),
	BkTitle NVARCHAR(Max) NOT NULL,
	BkPublisher NVARCHAR(60) NOT NULL
		CONSTRAINT tBOOK_tPUBLISHER FOREIGN KEY
		REFERENCES tPUBLISHER(BkPublisher)
		ON UPDATE CASCADE ON DELETE CASCADE
)

Create Table tAUTHOR (
	BookID INT NOT NULL
		Constraint tBOOK_tAUTHORS FOREIGN KEY
		References tBOOK(BookID)
		ON UPDATE Cascade ON DELETE Cascade,
	AuthorNAME NVARCHAR(80) NOT NULL,
)

Create Table tCOPIES (
	BookID INT 
		CONSTRAINT tBOOK_tCOPIES FOREIGN KEY
		REFERENCES tBOOK(BookID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT 
		CONSTRAINT tBRANCH_tCOPIES FOREIGN KEY
		REFERENCES tBRANCH(BranchID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	N_Copies INT 
)

Create Table tLOANS (
	LoanID INT IDENTITY(1,1),
	BookID INT 
		CONSTRAINT tBOOK_tLOANS FOREIGN KEY
		REFERENCES tBOOK(BookID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT 
		CONSTRAINT tBRANCH_tLOANS FOREIGN KEY
		REFERENCES tBRANCH(BranchID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	CardID INT NULL
		Constraint tBORROWER_tLOANS Foreign Key
		References tBORROWER(CardID)
		ON update cascade on delete cascade,
		DateOut DATE,
		DateDue Date 
)
GO

/* ==============================================
        INSERT DATA
=========================================*/

INSERT INTO tBORROWER
(mbrNAME, mbrAddress, mbrPhone)
VALUES
('Doug Blifton','234 NE Bird St Literate, WY 93214', 8795284606),
('Carl Jung','354 SE Dump St Literate, WY 93214', 8794827539),
('Bastian Pleth','375 NW Kale Ave Literate, WY 93204', 8795937562),
('Sammi Dilgus','867 NE Poor Blvd Literate, WY 93204', 8793584075),
('Kath Mineral','325 SW Dirt Rd Literate, WY 93214', 8794586357),

('Tommy 2Ton','657 NE SE Dump St Literate, WY 93204', 8794583754),
('Billy Grippo','794 SE Dirt Rd Literate, WY 93204', 8794596812),
('Slug Milton','646 NW Poor Blvd Literate, WY 93214', 8793475352),
('Dimple Grunt','363 SE Dump St Literate, WY 93204', 8793506975),
('Jethica Anderthon','653 SW Dump St Literate, WY 93214', 8793563684)
;

INSERT INTO tBRANCH
(BranchNAME, BranchADDRESS, BranchPHONE)
VALUES
('Sharpstown','12 NE Dump St Literate, WY 93204', 8792837293),
('Central', '56 SE Kale Ave Literate, WY 93214', 8792837201),
('Dirt Side','4 Poor Blvd Literate, WY 93204', 8795340284),
('Crum Edition', '67 Loaf St Literate, WY 93214', 8792346247)
;

INSERT INTO tPUBLISHER
(BkPublisher, PubADDRESS, PubPHONE)
VALUES
('Crum House', '354 4th Ave Newland, NY 93204', 3023049284),
('Smart Boi', '4 Terry Ln Bigport, ID 23593', 4305928403),
('Basement Books',NULL,9304283093)
;

INSERT INTO tBOOK
(BkTitle, BkPublisher)
VALUES
('Tides and the Rivers Ebb and Flow','Smart Boi'),
('The Personification of Self: I Am','Basement Books'),
('The Winter With My Beets','Smart Boi'),
('Transforming Into A Wizard','Basement Books'),
('Me and Poo-Paw','Smart Boi'),

('The Feel Good Gang','Crum House'),
('Females Have All The Fun','Crum House'),
('Spanning the Depths of My Heart, I Found You','Smart Boi'),
('Party Splatter','Crum House'),
('Deep Space Brine and the Adventures of Morkel Starpendian','Basement Books'),

('How to Be An Jerk','Crum House'),
('Cucumber Taste and The Pickle Complex','Smart Boi'),
('The Owls in the Kitchen Know How You Do','Basement Books'),
('Dreams From My Pathological Father','Smart Boi'),
('Sad Baby Divorce Guide Vol. II','Basement Books'),

('Bonding With Your Turtle','Crum House'),
('Cuddling with Your Cactus (of a Wife)','Crum House'),
('Night of 1000 Broaches','Smart Boi'),
('Bad To The Throne','Crum House'),
('Color Me Literate','Crum House'),

('Eye On The s’Prise','Smart Boi'),
('Down On My Buck: A Hunting Love Story','Crum House'),
('Good Night Spoon: A Collection of Tantric Ramen Recipes','Smart Boi'),
('Help! I’m White and Lonely: A Memoir','Crum House'),
('Hold The Toaster Shiny Man, Sir','Basement Books'),

('Tricks Are For Kids: Training Your Adolescent Goat','Crum House'),
('A Glock to Remember','Crum House'),
('The Audacity of Cake','Basement Books'),
('Ferris Wheel Concepts and Interpretations','Smart Boi'),
('Bing Bong Bing: A Doctorate Thesis on Foreign Relations','Basement Books'),

('The Lost Tribe','Crum House'),
('Pet Semetary','Smart Boi'),
('Under the Dome','Smart Boi'),
('The Mist','Smart Boi')
;

INSERT INTO tAUTHOR
(BookID, AuthorNAME)
VALUES
(1002,'Barry Reeto'),
(1003,'David Berry'),
(1004,'Kip Wofflebosh'),
(1005,'Bornell Splintermin'),
(1006,'Brendo Rapplewitz'),

(1007,'Greg McMuffmin'),
(1008,'Brinetta Kanderly'),
(1009,'Ronert Flunders'),
(1010,'Chorde Aflumption'),
(1011,'Rita Spratzmerg'),

(1012,'Villy Binton'),
(1013,'Bendledick Asstermath'),
(1014,'Roli Roligerth'),
(1015,'Donald Drumpf'),
(1016,'Hank Milk'),

(1017,'Pam Wentz'),
(1018,'Tummi Tinkz'),
(1019,'Tami Schultz'),
(1020,'Jeff ‘razor’ Raspen'),
(1021,'Tommy 2-Ton'),

(1022,'Bill Climton'),
(1023,'Joey ‘Gumz’ Milton'),
(1024,'Neth Berlum'),
(1025,'Conor Oberst'),
(1026,'Dale Gilman'),


(1027,'Bill Belichick'),
(1028,'Tupac Shakur'),
(1029,'Melania Trump'),
(1030,'Dave Smungs'),
(1031,'Donald Drumpf'),

(1032,'Edward Marriot'),
(1033,'Stephen King'),
(1034,'Stephen King'),
(1035,'Stephen King')
;

INSERT INTO tCOPIES
(BookID, BranchID, N_Copies)
VALUES
(1032,1,1),
(1003,1,3),
(1004,1,4),
(1032,2,1),
(1006,1,2),

(1007,2,3),
(1008,2,4),
(1009,2,2),
(1010,2,3),
(1011,2,4),

(1012,3,3),
(1013,3,2),
(1014,3,4),
(1015,3,2),
(1016,3,3),

(1017,4,3),
(1018,4,4),
(1019,4,2),
(1020,4,3),
(1021,4,4),

(1022,1,2),
(1023,1,3),
(1024,1,4),
(1025,1,3),
(1026,1,4),

(1027,2,3),
(1028,2,3),
(1029,2,4),
(1030,2,5),
(1031,2,4),

(1032,1,4),
(1033,2,4),
(1034,2,3),
(1035,2,3),

(1002,2,1),
(1003,3,2),
(1004,4,1),
(1005,2,2),
(1006,3,1),

(1017,2,1),
(1018,1,2),
(1019,3,1),
(1020,1,2),
(1021,2,1),

(1022,2,1),
(1023,3,1),
(1024,4,21),
(1025,2,1),
(1026,3,2),

(1027,3,1),
(1028,4,2),
(1029,1,1),
(1030,3,2),
(1031,4,1),

(1032,2,2),
(1033,3,1),
(1034,4,2),
(1035,1,1)
;



INSERT INTO tLOANS
(BookID,BranchID,CardID)
VALUES
(1017,4,1003),
(1018,4,1004),
(1019,4,1007),
(1020,4,1009),
(1021,4,1004),

(1022,1,1002),
(1023,1,1009),
(1024,1,1008),
(1025,1,1009),
(1026,1,1004),

(1027,2,1008),
(1028,2,1009),
(1029,2,1008),
(1030,2,1008),
(1031,2,1004),

(1032,1,1007),
(1033,2,1008),
(1034,2,1004),
(1035,2,1009),

(1012,3,1003),
(1013,3,1002),
(1014,3,1004),
(1015,3,1008),
(1016,3,1009),

(1017,4,1008),
(1018,4,1006),
(1019,4,1002),
(1020,4,1001),
(1021,4,1006),

(1022,1,1002),
(1023,1,1009),
(1024,1,1004),
(1025,1,1001),
(1026,1,1006),

(1027,2,1003),
(1028,2,1006),
(1029,2,1004),
(1030,2,1002),
(1031,2,1007),

(1032,1,1009),
(1033,2,1007),
(1034,2,1006),
(1035,2,1001),

(1027,2,1001),
(1028,2,1008),
(1029,2,1002),
(1030,2,1006),
(1031,2,1007),

(1032,1,1004),
(1033,2,1003),
(1034,2,1006),
(1035,2,1007)

;
Create Table tLoanDates (
LoanID INT IDENTITY(1,1),
DateOut Date,
DateDue Date
);
--Alter Table tLOANS
--	ADD DateOut date, DateDue date


Declare @today date
Set @today =getdate()
Declare @OldDay AS date
SET @OldDay = dateadd(day,-19,@today)
Declare @range as int
Set @range = datediff(day, @OldDay,@today) +1
declare @loans as int
set @loans = 52

BEGIN TRANSACTION
Declare @uid uniqueidentifier
Set @uid = NEWID()
DECLARE @i AS int
SET @i = 1

WHILE(@i <= @loans)
	Begin 
		INSERT INTO tLoanDates(DateOut)
		VALUES
		(dateadd (day,FLOOR(rand(checksum(@uid))*@range) - 1,@OldDay))
		SET @i += 1
		SET @uid = NEWID()
	END
Commit Transaction
GO


;

/*
update tLOANS
SET DateOUT = (select DateOUT FROM tLoanDates where tLoanDates.LoanID = tLOANS.LoanID)
; 
*/

Update tLOANS
	SET DateOut =tLoanDates.DateOut
	FROM tLoanDates
	WHERE tLoanDates.LoanID = tLOANS.LoanID
;

update tLoans
	SET DateDue = DateADD(day,20,[DateOut])
;


--SELECT * FROM tLOANS

/*=======================================
		QUERIES SECTION
=======================================*/
--SELECT * FROM tCopies


--======================
--==== QUERY TASK 1 ====
--======================

SELECT
a2.BkTitle 'Book Title',
a3.BranchName 'Branch Name',
SUM(a1.N_copies) AS 'Number of Copies'
FROM tCopies a1
Inner JOIN tBOOK a2 ON a2.BookID = a1.BookID
Inner JOIN tBRANCH a3 ON a3.BranchID = a1.BranchID
Where bkTitle = 'The Lost Tribe' AND BranchName = 'Sharpstown'
Group by a2.BkTitle, a3.BranchNAME
Order by BkTitle, BranchName
;

--=======================
--==== QUERY TASK 2 =====
--=======================

SELECT 
a2.BkTitle 'Book Title',
a3.BranchName 'Branch Name',
SUM(a1.N_copies) AS 'Number of Copies'
FROM tCopies a1
Inner JOIN tBOOK a2 ON a2.BookID = a1.BookID
Inner JOIN tBRANCH a3 ON a3.BranchID = a1.BranchID
Where bkTitle = 'The Lost Tribe'
Group by BkTitle, BranchNAME
Order by BkTitle, BranchName
;

--======================
--==== QUERY TASK 3 ====
--======================

Select
a1.mbrNAME 'Member Name',
COUNT(a2.CardID) 'Books Out'
From tBORROWER a1
LEFT JOIN tLoans a2 ON a2.CardID = a1.CardID
GROUP BY a1.mbrNAME
HAVING COUNT(a2.CardID) = 0
;

--======================
--==== QUERY TASK 4 ====
--======================

SELECT
a3.BkTitle 'Book Title',
a2.mbrNAME 'Member Name',
a2.mbrAddress 'Member Address',
a1.DateOut,
a1.DateDue
FROM tLOANS a1
INNER JOIN tBORROWER a2 ON a2.CardID = a1.CardID
INNER JOIN tBOOK a3 ON a3.BookID = a1.BookID
Where a1.DateDue = CAST(GETDATE() AS DATE)
;

--======================
--==== QUERY TASK 5 ====
--======================

SELECT
a1.BranchName,
COUNT(a2.BookID)
FROM
tBranch a1
INNER JOIN tLOANS a2 ON a2.BranchID = a1.BranchID
Group By a1.BranchNAME
;

--======================
--==== QUERY TASK 6 ====
--======================
 
SELECT
a1.mbrNAME 'Member Name',
a1.mbrADDRESS 'Member Address',
COUNT(a2.CardID) 'Books Currently Checked Out'
FROM
tBORROWER a1
LEFT JOIN tLOANS a2 ON a2.CardID = a1.CardID
Group by a1.mbrName, a1.mbrAddress
HAVING COUNT(a2.CardID) >5
ORDER BY COUNT(a2.CardID) DESC
;

--======================
--==== QUERY TASK 7 ====
--======================

SELECT 
tBOOK.BkTitle 'Book Title',
SUM(tCopies.N_Copies) 'Total Copies',
tBranch.BranchNAME
FROM
tBOOK
INNER JOIN tCopies ON tCopies.BookID = tBOOK.BookID
INNER JOIN tBRANCH ON tBRANCH.BranchID = tCOPIES.BranchID
INNER JOIN tAUTHOR ON tBOOK.BookID = tAUTHOR.BookID
Where tBranch.BranchNAME = 'Central' AND tAuthor.AuthorNAME = 'Stephen King'
GROUP BY tbook.BkTitle, tBRANCH.BranchNAME
;

--================================
--======= QUERY TASK BONUS =======
--==== Popular Books by Branch ===
--================================

SELECT 
tBOOK.BkTitle 'Book Title',
SUM(tCopies.N_Copies) 'Total Copies',
tBranch.BranchNAME
FROM
tBOOK
INNER JOIN tCopies ON tCopies.BookID = tBOOK.BookID
INNER JOIN tBRANCH ON tBRANCH.BranchID = tCOPIES.BranchID
INNER JOIN tAUTHOR ON tBOOK.BookID = tAUTHOR.BookID
Where tBranch.BranchNAME = 'Central'
GROUP BY tbook.BkTitle, tBRANCH.BranchNAME
ORDER BY SUM(tcopies.N_copies) DESC
;

--===========================
--==== QUERY TASK BONUS2 ====
--=== Most Popular Books ====
--===========================

SELECT 
tBOOK.BkTitle 'Book Title',
tAUTHOR.AuthorNAME 'Book Author',
COUNT(tLOANS.BookID) 'Total Copies Checked Out',
tLOANS.BookID
FROM
tLOANS
INNER JOIN tBOOK ON tBOOK.BookID = tLOANS.BookID
INNER JOIN tAUTHOR ON tAUTHOR.BookID = tLOANS.BookID
WHERE NOT tAUTHOR.AuthorNAME = 'Stephen King'
GROUP BY tbook.BkTitle, tAUTHOR.AuthorNAME, tLOANS.BookID
ORDER BY SUM(tLOANS.BookID) DESC
;

