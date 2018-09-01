Use DB_Literate
GO
/*=======================================
		QUERIES SECTION
=======================================*/

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask1
AS
BEGIN
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
END
GO
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask2
AS
BEGIN
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
END


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask3
AS
BEGIN
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
END


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask4_BooksDueToday
AS
BEGIN
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
END

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask5_BooksOutPerBranch
AS
BEGIN
--======================
--==== QUERY TASK 5 ====
--======================
SELECT
a1.BranchName as 'Branch Name',
COUNT(a2.BookID) as 'Number of books Checked out'
FROM
tBranch a1
INNER JOIN tLOANS a2 ON a2.BranchID = a1.BranchID
Group By a1.BranchNAME
;
END

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask6_InfoBorrowersMorethan5Books
AS
BEGIN
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
End

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTask7_StephenKingBooksatCentral
AS
BEGIN
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
END

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTaskBonus1_PopularBooksPassIn_BranchName
@BranchName NVARCHAR(max) = NULL
AS
BEGIN
--================================
--======= QUERY TASK BONUS =======
--==== Popular Books by Branch ===
--================================
--Declare @branchname NVARCHAR(max);
--Set @BranchName = null;
SELECT 
tBOOK.BkTitle 'Book Title',
SUM(tCopies.N_Copies) 'Total Copies',
tBranch.BranchNAME
FROM
tBOOK
INNER JOIN tCopies ON tCopies.BookID = tBOOK.BookID
INNER JOIN tBRANCH ON tBRANCH.BranchID = tCOPIES.BranchID
INNER JOIN tAUTHOR ON tBOOK.BookID = tAUTHOR.BookID
Where tBranch.BranchNAME = ISNULL(@BranchName,BranchNAME)
GROUP BY tbook.BkTitle, tBRANCH.BranchNAME
ORDER BY SUM(tcopies.N_copies) DESC
;
END


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Create Procedure dbo.pSP_QueryTaskBonus2_MostPopular
AS
BEGIN
--===========================
--==== QUERY TASK BONUS2 ====
--=== Most Popular Books ====
--===========================
SELECT 
tBOOK.BkTitle 'Book Title',
tAUTHOR.AuthorNAME 'Book Author',
COUNT(tLOANS.BookID) 'Total Copies Checked Out',
tBOOK.bkPublisher
FROM
tLOANS
INNER JOIN tBOOK ON tBOOK.BookID = tLOANS.BookID
INNER JOIN tAUTHOR ON tAUTHOR.BookID = tLOANS.BookID
WHERE NOT tAUTHOR.AuthorNAME = 'Stephen King'
GROUP BY tbook.BkTitle, tAUTHOR.AuthorNAME, tBOOK.bkPublisher
ORDER BY count(tLOANS.BookID) DESC
;
END

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
