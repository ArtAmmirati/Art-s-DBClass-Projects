USE [AdventureWorks2012]
 GO
 
 CREATE FUNCTION [dbo].[FNonhandprodID]  -- USES THE PRODUCT ID
 (
 	@prodID VARCHAR(MAX)
 )
 RETURNS TABLE
 AS
 RETURN
 	SELECT p.ProductID, p.Name, p.ProductNumber, sum( i.Quantity)'Total On Hand'  
 	FROM [Production].[Product] P
 	Join [Production].[ProductInventory] I
 	on I.ProductID = P.ProductID
 	WHERE i.ProductID = @prodID
 	group by p.ProductID,p.Name, p.ProductNumber
   
  
  
 USE [AdventureWorks2012]
 
 CREATE FUNCTION [dbo].[FNonhandprodnum] -- USES THE PRODUCT NUMBER
 (
 	@prodnum varchar(max)
 )
 RETURNS TABLE
 AS
 RETURN
 	SELECT p.ProductID, p.Name, p.ProductNumber, sum( i.Quantity)'Total On Hand'  
 	FROM [Production].[Product] P
 	Join [Production].[ProductInventory] I
 	on I.ProductID = P.ProductID
 	WHERE ProductNumber = @prodnum
 	group by p.ProductID,p.Name, p.ProductNumber