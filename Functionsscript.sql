USE AdventureWorks2012
GO
IF OBJECT_ID ('dbo.udfnEXPIREDDATE') IS not NULL
DROP FUNCTION dbo.udfnEXPIREDDATE;

GO

CREATE FUNCTION DBO.udfnEXPIREDDATE
(
	@CARDNUMBER AS VARCHAR(MAX)
)
RETURNS VARCHAR (MAX)
AS
BEGIN

DECLARE @EOM VARCHAR (MAX)= (SELECT EOMONTH(DATEFROMPARTS(EXPYEAR,EXPMONTH,1)) FROM [Sales].[CreditCard] WHERE [CardNumber] = @CARDNUMBER)

SET @CARDNUMBER = @EOM

RETURN @CARDNUMBER

END

GO

IF OBJECT_ID ('DBO.udfnStateTax') IS NOT NULL
DROP FUNCTION  DBO.udfnStateTax;

GO

CREATE FUNCTION DBO.udfnStateTax
(
@stateprovince int,
@taxtype tinyint
)
RETURNS SMALLMONEY
AS
BEGIN
DECLARE @taxrate smallmoney

SET @taxrate = (select taxrate from sales.SalesTaxRate where StateProvinceID = @stateprovince and TaxType = TaxType)
IF @taxrate is null
	begin
	set @taxrate = 0
	end
 RETURN @taxrate
 END

GO

	IF OBJECT_ID ('dbo.ufnin2cm') IS not NULL
	drop function  DBO.ufnin2cm;
GO

 CREATE FUNCTION [ufnin2cm] (@in decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@in * 2.54)
	END
GO

	 IF OBJECT_ID ('dbo.ufngal2lit') IS not NULL
	 drop function  DBO.ufngal2lit;
GO
	CREATE FUNCTION [ufngal2lit] (@gal decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@gal * 3.785)
	END
GO
	IF OBJECT_ID ('dbo.ufnlbs2kg') IS not NULL
	 drop function  DBO.ufnlbs2kg;
GO
	CREATE FUNCTION [ufnlbs2kg] (@lbs decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@lbs * .454)
	END
SELECT DBO.UFNLBS2KG (2)