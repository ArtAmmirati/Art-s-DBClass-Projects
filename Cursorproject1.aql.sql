

DECLARE @Status INT

DECLARE SalesStatusCursor CURSOR SCROLL 

	FOR SELECT TOP 1000 [Status] FROM [Sales].[SalesOrderHeader]

OPEN SalesStatusCursor
 
	FETCH NEXT FROM SalesStatusCursor
		INTO @Status

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
			PRINT @STATUS

			SELECT FLOOR(RAND()*(4-1)+1 )

			FETCH NEXT FROM SalesStatusCursor	
					INTO @Status	
		END
CLOSE SalesStatusCursor
DEALLOCATE SalesStatusCursor







				
