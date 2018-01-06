DECLARE
    @Number INT,
    @Divisor INT,
    @count INT

SET @Number = 1
WHILE (@Number <= 1000)
    BEGIN
        SET @count = 0
        SET @Divisor = 1

WHILE (@Divisor <= @Number)
     BEGIN
     IF (@Number % @Divisor = 0) 
         SET @count = @count + 1
         SET @Divisor = @Divisor + 1
     END

     IF (@count = 2) 
            PRINT @Number
        SET @Number = @Number + 1
    END 