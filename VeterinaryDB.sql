USE MASTER;
if (select count(*) 
    from sys.databases where name = 'VeterinaryDB') > 0

BEGIN
    DROP DATABASE VeterinaryDB;
END	
	Print 'VeterinaryDB Dropped'

if (select count(*) 
    from sys.syslogins where name = 'VetManager1') > 0
Begin
	Drop Login VetManager1
End	
	Print 'VetManager1 Login Dropped'

if (select count(*) 
	from sys.syslogins where name = 'VetClerk1') > 0
Begin
	Drop Login VetClerk1 
End	
	Print 'VetClerk1 Login Dropped'
Begin
CREATE DATABASE VeterinaryDB
End
Print 'VeterinaryDB created'

Go
USE VeterinaryDB

------------------------------------------Table AnimalTypeReference
CREATE TABLE AnimalTypeReference
	(
	AnimalTypeID INT NOT NULL IDENTITY(1,1)
	,Species varchar(35) NOT NULL
	,Breed varchar(35)
	
	PRIMARY KEY (AnimalTypeID)
	)
-------------------------------------------Table Billing
CREATE TABLE Billing
(
	BillID INT NOT NULL IDENTITY(1,1)
	,BillDate date NOT NULL
	,ClientID INT NOT NULL
	,VisitID INT NOT NULL
	,Amount decimal NOT NULL

	PRIMARY KEY (BillID)
	)
-------------------------------------------Table ClientContacts
CREATE TABLE ClientContacts
	(
	AddressID INT NOT NULL IDENTITY(1,1)
	,ClientID INT NOT NULL
	,AddressType INT NOT NULL
	,AddressLine1 varchar(50) NOT NULL
	,AddressLine2 varchar(50) NOT NULL
	,City varchar(35) NOT NULL
	,StateProvince varchar(25) NOT NULL
	,PostalCode varchar(15) NOT NULL
	,Phone varchar(15) NOT NULL
	,AltPhone varchar(15) NOT NULL
	,EMail varchar(35) NOT NULL

	PRIMARY KEY (AddressID)
	)
---------------------------------------- Table Clients
CREATE TABLE Clients
	(
	ClientID INT NOT NULL IDENTITY(1,1)
	,FirstName varchar(25) NOT NULL
	,LastName varchar(25) NOT NULL
	,MiddleName varchar(25)  NULL
	,CreateDate date DEFAULT GETDATE()
	
	PRIMARY KEY (ClientID)
	)
------------------------------------------------Table EmployeeContactInfo
CREATE TABLE EmployeeContactInfo
(
	AddressID INT NOT NULL IDENTITY(1,1)
	,AddressType INT NOT NULL
	,AddressLine1 varchar(50) NOT NULL
	,AddressLine2 varchar(50) NOT NULL
	,StateProvince varchar(25) NOT NULL
	,PostalCode varchar(15) NOT NULL 
	,AltPhone varchar(15) NOT NULL
	,EmployeeID INT
	
	PRIMARY KEY (AddressID)
	)
--------------------------------------------------Table Employees
CREATE TABLE Employees
(
	EmployeeID INT NOT NULL IDENTITY(1,1)
	,LastName varchar(35) NOT NULL
	,FirstName varchar(35) NOT NULL
	,MiddleName varchar(35) NULL
	,HireDate date NOT NULL
	,Title varchar(50) NOT NULL 
	
	PRIMARY KEY (EmployeeID)
	)
-----------------------------------------------Table Patients
CREATE TABLE Patients
	(
	PatientID INT NOT NULL IDENTITY(1,1)
	,ClientID INT NOT NULL
	,PatientName varchar(35) NOT NULL
	,AnimalType INT NOT NULL
	,Color varchar(25)
	,Gender varchar(2) NOT NULL
	,BirthYear varchar(4)
	,[Weight] decimal(3) NOT NULL
	,[Description] varchar(1024)
	,GeneralNotes varchar(2048) NOT NULL
	,Chipped Bit NOT NULL
	,RabiesVaccine datetime

	PRIMARY KEY (PatientID)
	)
--------------------------------------------Table Payments
CREATE TABLE Payments
(
	PaymentID INT NOT NULL IDENTITY(1,1)
	,PaymentDate date NOT NULL
	,BillID INT NULL
	,Notes varchar(2048) NULL
	,Amount decimal NOT NULL
	
	PRIMARY KEY (PaymentID)
	)
-----------------------------------------------Table Visits
CREATE TABLE Visits
(
	VisitID INT NOT NULL IDENTITY(1,1)
	,StartTime datetime NOT NULL
	,Endtime datetime NOT NULL
	,Appointment BIT NOT NULL
	,DiagnosisCode varchar(12) NOT NULL
	,ProcedureCode varchar(12) NOT NULL 
	,VisitNotes varchar(2048)
	,PatientID INT
	,EmployeeID INT
	
	PRIMARY KEY (VisitID)
	)
----------------------------------end Tables--------------------------------

----------------Constraints---------------------

ALTER TABLE ClientContacts ADD CONSTRAINT Clients_fk  FOREIGN KEY (ClientID) REFERENCES Clients (ClientID);

ALTER TABLE Patients ADD CONSTRAINT Client_fk FOREIGN KEY (ClientID) REFERENCES Clients (ClientID);

ALTER TABLE Patients  ADD CONSTRAINT AnimalTypeReference_fk FOREIGN KEY (AnimalType) REFERENCES AnimalTypeReference(AnimalTypeID);

ALTER TABLE EmployeeContactInfo  ADD CONSTRAINT Employee_fk FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

ALTER TABLE Visits ADD CONSTRAINT Employees_fk FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

ALTER TABLE Visits ADD CONSTRAINT Patient_fk  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

ALTER TABLE Billing ADD CONSTRAINT Client1_fk  FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);

ALTER TABLE Billing  ADD CONSTRAINT Visit_fk  FOREIGN KEY (VisitID) REFERENCES Visits(VisitID);

ALTER TABLE Payments  ADD CONSTRAINT Bill_fk FOREIGN KEY (BillID) REFERENCES Billing(BillID);
--------------------------------------------end Constraints----------------------------

--------------------------CHECKS------------------------------------------
ALTER TABLE Visits ADD CONSTRAINT CHK_TimeCheck CHECK (EndTime>StartTime);
ALTER TABLE Payments ADD CONSTRAINT CHK_PayDate CHECK (PaymentDate<= getdate());
ALTER TABLE Billing ADD CONSTRAINT CHK_BillDate CHECK (BillDate <= getdate());
ALTER TABLE ClientContacts ADD CONSTRAINT CHK_Addrestype CHECK (AddressType = 1 or AddressType = 2);
---------------------------end Checks--------------------------------------------------------------
Begin
if (select count(*) 
    from sys.syslogins where name = 'VetManager1') > 0
Drop Login VetManager1

if (select count(*) 
	from sys.syslogins where name = 'VetClerk1') > 0
Drop Login VetClerk1 

END

--Logins----------

-- Creates the login User with password.  
CREATE LOGIN VetManager1  
    WITH PASSWORD = '1234';  
GO  
-- Creates a database user for the login created above.  
CREATE USER VetManager1 FOR LOGIN VetManager1;  
GO  

CREATE LOGIN VetClerk1  
    WITH PASSWORD = '1234';  
GO  
-- Creates a database user for the login created above.  
CREATE USER VetClerk1 FOR LOGIN VetClerk1;  
GO  
ALTER ROLE db_datawriter ADD MEMBER [VetManager1] ;  
GO
ALTER ROLE db_datareader ADD MEMBER [VetManager1] ;  
GO
ALTER ROLE db_datareader ADD MEMBER [VetClerk1] ;  
GO
DENY SELECT ON ClientContacts TO VetClerk1;
DENY SELECT ON EmployeeContactInfo TO VetClerk1;

