UPDATE Sales.SalesOrderHeader
    SET [Status] = (ABS(CHECKSUM(NewId())) % 3) + 1

	-- change the 3 to any number to get upper limit of the range of numbers

	select (ABS(CHECKSUM(NewId())) % 20) + 1