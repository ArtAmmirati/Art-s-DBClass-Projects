USE AdventureWorks2012
GO
-- FUNCTION USED TO GET PRODUCT NAME FROM ONLY 
-- PART OF NAME

CREATE FUNCTION ProductNamePart
(
		@ProdNamePart Varchar(MAX)
)
RETURNS TABLE
AS
RETURN
			SELECT 
					ProductID
					, Name
					, ProductNumber 

			FROM 
					[Production].[Product]

			WHERE 
					Name like '%' + @ProdNamePart + '%'


--SELECT * FROM [dbo].[ProductNamePart] ('hand')