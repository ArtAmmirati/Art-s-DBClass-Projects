USE AdventureWorks2012

GO
CREATE FUNCTION ufn_Address4persons (@BusEntID int)
RETURNS varchar(max)
AS
begin

Declare @address varchar(max)
 
SET @ADDRESS = (SELECT TOP 1000 CONCAT(A.AddressLine1, A.AddressLine2,'  ',A.City, ', ', SP.StateProvinceCode, '  ',CR.Name)
FROM Person.Person p
INNER JOIN person.BusinessEntity BE
On P.BusinessEntityID = BE.BusinessEntityID 
INNER JOIN Person.BusinessEntityAddress BEA
ON BE.BusinessEntityID = BEA.BusinessEntityID
INNER JOIN Person.Address A
ON BEA.AddressID = A.AddressID
INNER JOIN Person.StateProvince SP
ON A.StateProvinceID = SP.StateProvinceID
INNER JOIN Person.CountryRegion CR
ON SP.CountryRegionCode = CR.CountryRegionCode
WHERE p.BusinessEntityID = @BusEntID
ORDER BY P.BusinessEntityID ASC)

RETURN @Address;
end
go

SELECT[dbo].[ufn_Address4persons] (200)

DROP FUNCTION [dbo].[ufn_Address4persons]