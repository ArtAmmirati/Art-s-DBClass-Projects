use AdventureWorks2012
GO

-- FUNCTION TO GET THE LAST ORDERS FROM SALES 
-- (X) IN THE SELECT STATEMENT IS THE NUMBER OF ROW RETURNED

CREATE FUNCTION LatestOrdersTop
(
@TopRecordNum int
)
RETURNS TABLE
AS
RETURN

		SELECT TOP (@TopRecordNum) OrderDate
		FROM sales.SalesOrderHeader
		ORDER BY OrderDate DESC


--SELECT * FROM [dbo].[LatestOrdersTop] ( X )