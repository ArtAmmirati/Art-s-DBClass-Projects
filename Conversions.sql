	CREATE FUNCTION [ufn.in2cm] (@in decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@in * 2.54)
	END
	GO
	CREATE FUNCTION [ufn.gal2lit] (@gal decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@gal * 3.785)
	END
	GO
	CREATE FUNCTION [ufn.lbs2kg] (@lbs decimal(10,3))
	RETURNS decimal(10,3)
	AS
	BEGIN
	RETURN (@lbs * .454)
	END
