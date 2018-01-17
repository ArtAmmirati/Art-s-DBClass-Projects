USE ADVENTUREWORKS2012
GO
CREATE PROCEDURE sp_OrdersShipped
AS
BEGIN
WITH CTE_OrdersShipped
AS
(
SELECT SOH.* FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.ProductInventory I
ON SOD.ProductID = I.ProductID
WHERE [Status] IN (1,2,3)  AND 
SOH.BillToAddressID IS NOT NULL AND
SOH.[ShipToAddressID] IS NOT NULL AND
SOH.CreditCardID IS NOT NULL AND
SOH.CreditCardApprovalCode IS NOT NULL AND
I.Quantity >= SOD.OrderQty
)
UPDATE Sales.SalesOrderHeader
set [Status] = 5
WHERE SalesOrderID IN (SELECT SalesOrderID FROM CTE_OrdersShipped)
END
GO

execute [dbo].[sp_OrdersShipped]
select [status] from [Sales].[SalesOrderHeader]

