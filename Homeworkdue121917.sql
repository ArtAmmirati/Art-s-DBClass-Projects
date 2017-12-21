
USE MASTER;
IF EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = N'HOMEWORK')
BEGIN
DROP DATABASE [HOMEWORK]
END
CREATE DATABASE Homework
GO
USE Homework
GO
PRINT 'Homework Database created'
GO
CREATE TABLE Countries
(
CountryID INT NOT NULL identity(1,1),
CountryName VARCHAR(50),
Population BIGINT,  
Currency varchar(50) 
CONSTRAINT PK_COUNTRY PRIMARY KEY(COUNTRYID) 
);
PRINT 'Countries Table Created'

CREATE TABLE Cities
(
CityID INT identity(1,1) PRIMARY KEY,
CityName VARCHAR(50), 
CountryID INT, 
Population BIGINT,
)
Print 'Cities Table Created'
PRINT 'PK_Country Added'

CREATE TABLE Books
(
ISBN VARCHAR(15) NOT NULL,
DatePurchased DATE ,
Title VARCHAR(255), 
AuthorID INT,
CONSTRAINT PK__CompositPKBooks PRIMARY KEY NONCLUSTERED (ISBN, DatePurchased)
)
PRINT 'Books Table Created'
PRINT 'PK_CompositPKBooks Created'

ALTER TABLE Books
DROP CONSTRAINT[PK__CompositPKBooks]
GO
PRINT 'PK_CompositPKBooks Dropped'

GO
ALTER TABLE Books 
ADD BookID INT PRIMARY KEY
PRINT 'PK_BooksID Added using Alter Table'

select * from sys.key_constraints
go
ALTER TABLE Cities
ADD CONSTRAINT FK_CitiesCountry
FOREIGN KEY (CountryID) 
REFERENCES Countries(CountryID)
ON DELETE CASCADE;

Print 'FK_CitiesCountry'


--Added Indexes
CREATE INDEX IDX_CountryName
ON Countries(CountryName)

PRINT 'IDX_CountryName added'

CREATE INDEX IDX_CityCountry
ON Cities (CityName, CountryID)
Print 'IDX_CityCountry added'

CREATE INDEX IDX_TitleAuthorID
ON Books (Title, AuthorID)
Print 'IDX_TitleAuthorID added'

USE [Homework]
GO

INSERT INTO [dbo].[Countries]
           ([CountryName]
           ,[Population]
           ,[Currency])
     VALUES ('China',1409517397,'Chinese Yuan Renmibi')
			,('India',1339180127,'Indian Rupee')
			,('United States',324459463, 'US Dollar')
go
INSERT INTO [dbo].[Cities]
           ([CityName]
           ,[CountryID]
           ,[Population])
     VALUES
           ('New York',3, 17800000)
		   ,('Shanghai',1, 10000000)
		   ,('Mumbai',2, 143500000)
GO
INSERT INTO [dbo].[Books]
           ([ISBN]
           ,[DatePurchased]
           ,[Title]
           ,[AuthorID], [BookID])
     VALUES
           (9781936876518,'12-19-2017','Shadow Run Fifth Edition', 1,1)
		   ,(9781418479275,'12-19-2017','Flying the Hump to China',2,2)
		   ,(9780872169050,'12-19-2017', 'Horrors',2,3)
GO

Update cities set Population= (Population*1.15) where CityName = 'New York'
Print 'New York population increased by 15%'
Update cities set Population= (Population*1.15) where CityName = 'Shanghai'
Print 'Shanghai population increased by 15%'
Update cities set Population= (Population*1.15) where CityName = 'Mumbai'
Print 'Mumbai population increased by 15%'