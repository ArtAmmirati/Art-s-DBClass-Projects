USE AdventureWorks2012
GO

-- FUNCTION TO GET FULL NAME AND PHONE NUMBER FROM PART OF A PHONE NUMBER

USE AdventureWorks2012
GO

CREATE FUNCTION PhoneNumber
(
		@PhoneNumPart Varchar(MAX)
)
RETURNS TABLE
AS
RETURN
				SELECT CONCAT(P.LastName, ',  ' ,P.FirstName) as [Full Name], PP.PhoneNumber
				FROM [Person].[Person] P
				JOIN [Person].[PersonPhone] PP
				ON P.BusinessEntityID = PP.BusinessEntityID
				WHERE PP.PhoneNumber LIKE '%' + @PhoneNumPart + '%'




				--SELECT  * FROM [dbo].[PhoneNumber] (638)