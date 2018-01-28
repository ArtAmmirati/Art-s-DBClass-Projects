USE MASTER;
--EXISTANCE OF VETERINARY DATABASE CHECKED
	GO
	DROP DATABASE IF EXISTS [VeterinaryDB]
	Print 'VeterinaryDB Dropped'

--SYSTEM LOGINS EXISTANCE CHECKED AND DROPPED

IF (select count(*) 
    from sys.syslogins where name = 'VetManager') > 0

	DROP Login [VetManager]
	Print 'VetManager Login Dropped'
	
IF (select count(*) 
	from sys.syslogins where name = 'VetClerk') > 0

	Drop Login VetClerk
	Print 'VetClerk Login Dropped'

--VETERUBARY DATABASE CREATED

	CREATE DATABASE VeterinaryDB
	Print 'VeterinaryDB created'

--------------------------------------------------------------------------------

Go
USE VeterinaryDB
BEGIN
	DROP USER IF EXISTS [VetClerk]
	PRINT 'VETCLERK USER DROPPED'
	DROP USER IF EXISTS [VetManager]
	PRINT 'VETMANAGER USER DROPPED'
END
------------------------------------------Table AnimalTypeReference
CREATE TABLE AnimalTypeReference
	(
	AnimalTypeID INT NOT NULL IDENTITY(1,1)
	,Species varchar(35) NOT NULL
	,Breed varchar(35) NOT NULL
	
	PRIMARY KEY (AnimalTypeID)
	)
PRINT 'ANIMAL TYPE TABLE'

insert into AnimalTypeReference (Species, Breed) values ('DOG', 'Italian Grayhound');
insert into AnimalTypeReference (Species, Breed) values ('DOG', 'Neopolitian Mastiff');
insert into AnimalTypeReference (Species, Breed) values ('DOG', 'Volpino Italiano');
insert into AnimalTypeReference (Species, Breed) values ('CAT', 'Siamese Cat');
insert into AnimalTypeReference (Species, Breed) values ('CAT', 'Bengal Cat');
insert into AnimalTypeReference (Species, Breed) values ('REPTILE', 'Ball Python');
insert into AnimalTypeReference (Species, Breed) values ('REPTILE', 'Boa Constrictor');

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
PRINT 'BILLING TABLE'

insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 1, 1, 100);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 2, 2, 200);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 3, 3, 300);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 4, 4, 400);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 5, 5, 500);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 6, 6, 600);
insert into Billing (BillDate, ClientID, VisitID, Amount) values (getdate(), 7, 7, 700);

-------------------------------------------Table ClientContacts
CREATE TABLE ClientContacts
	(
	AddressID INT NOT NULL IDENTITY(1,1)
	,ClientID INT NOT NULL
	,AddressType INT NOT NULL
	,AddressLine1 varchar(50) NOT NULL
	,AddressLine2 varchar(50)  NULL
	,City varchar(35) NOT NULL
	,StateProvince varchar(25) NOT NULL
	,PostalCode varchar(15) NOT NULL
	,Phone varchar(15) NOT NULL
	,AltPhone varchar(15)  NULL
	,EMail varchar(35)  NULL

	PRIMARY KEY (AddressID)
	)
PRINT 'CLIENT CONTACTS TABLE'

insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (1,1, '005 Surrey Trail', 0, 'Jacksonville', 'Florida', '32220', '(904) 2815086', '(850) 2471846', '1@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (2,1, '607 Pawling Street', 0, 'Seminole', 'Florida', '34642', '(941) 4510320', '(407) 2653839', '2@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (3,1, '0 Novick Hill', 0, 'Orlando', 'Florida', '32819', '(407) 1551789', '(863) 6456315', '3@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (4,1, '74 Mitchell Hill', 0, 'Tampa', 'Florida', '33686', '(813) 7218991', '(727) 5548128', '4@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (5,1, '439 Bultman Avenue', 0, 'Miami', 'Florida', '33185', '(305) 3281576', '(305) 6303179', '5@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (6,1, '5112 La Follette Crossing', 0, 'Pensacola', 'Florida', '32595', '(850) 9315333', '(904) 6520783', '6@gmail');
insert into ClientContacts (ClientID, AddressType, AddressLine1 , AddressLine2, City, StateProvince, PostalCode, Phone, AltPhone, EMail ) values (7,1, '84208 Namekagon Point', 0, 'Port Charlotte', 'Florida', '33954', '(941) 3850999', '(352) 3412614', '7@gmail');

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
PRINT 'CLIENT TABLE'

insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Silva', 'Pennini', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Gusti', 'Ould', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Gaylene', 'Mallock', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Charo', 'Tourry', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Deva', 'Elstow', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Kathy', 'De Minico', null, getdate());
insert into Clients (FirstName , LastName, MiddleName, CreateDate) values ('Luce', 'Gergely', null, getdate());
------------------------------------------------Table EmployeeContactInfo

CREATE TABLE EmployeeContactInfo
(
	
	AddressID INT NOT NULL IDENTITY(1,1)
	,EmployeeID INT NOT NULL
	,AddressType INT NOT NULL
	,AddressLine1 varchar(50) NOT NULL
	,AddressLine2 varchar(50)  NULL
	,City varchar(35) NOT NULL
	,StateProvince varchar(25) NOT NULL
	,PostalCode varchar(15) NOT NULL
	,Phone varchar(15) NOT NULL
	,AltPhone varchar(15)  NULL
	,EMail varchar(50)  NULL

	PRIMARY KEY (AddressID)
	)
PRINT 'EMPLOYEE CONTACT TABLE'

insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (1, 1, '02 Acker Place', 'Clearwater', 'Florida', '34615', '727-429-0367');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (2, 1, '6 Comanche Park', 'Miami', 'Florida', '33283', '305-567-5043');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (3, 1, '4 Granby Lane', 'Panama City', 'Florida', '32412', '850-223-0623');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (4, 1, '88631 Scoville Drive', 'Miami', 'Florida', '33190', '786-672-1722');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (5, 1, '5 Logan Road', 'Daytona Beach', 'Florida', '32123', '386-305-0104');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (6, 1, '80 Roth Road', 'Clearwater', 'Florida', '33763', '727-749-7084');
insert into employeecontactinfo (EmployeeID, AddressType, AddressLine1 , City, StateProvince, PostalCode, Phone) values (7, 1, '0 Veith Pass', 'Fort Lauderdale', 'Florida', '33320', '754-385-8162');

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
PRINT 'EMPLOYEES TABLE'

insert into employees (LastName, FirstName, HireDate, Title) values ('Sillars', 'Page', '7/20/2017', 'Senior Veterinarian');
insert into employees (LastName, FirstName, HireDate, Title) values ('Hamley', 'Dulcie', '12/5/2017', 'Veterinarian');
insert into employees (LastName, FirstName, HireDate, Title) values ('Cheng', 'Jaynell', '10/23/2017', 'Veterinarian Resident');
insert into employees (LastName, FirstName, HireDate, Title) values ('Duprey', 'Cathi', '8/6/2017', 'Manager');
insert into employees (LastName, FirstName, HireDate, Title) values ('Rakes', 'Rod', '3/2/2017', 'Vet Assistant');
insert into employees (LastName, FirstName, HireDate, Title) values ('Catley', 'Frederica', '5/20/2017', 'Clerk');
insert into employees (LastName, FirstName, HireDate, Title) values ('Vasenkov', 'Camel', '10/28/2017', 'Kennel Supervisor');
-----------------------------------------------Table Patients
CREATE TABLE Patients
	(
	PatientID INT NOT NULL IDENTITY(1,1)
	,ClientID INT NOT NULL
	,PatientName varchar(35) NOT NULL
	,AnimalType INT NOT NULL
	,Color varchar(25) NULL
	,Gender varchar(2) NOT NULL
	,BirthYear varchar(4) NULL
	,[Weight] decimal(3) NOT NULL
	,[Description] varchar(1024)
	,GeneralNotes varchar(2048) NOT NULL
	,Chipped Bit NOT NULL
	,RabiesVaccine datetime NULL

	PRIMARY KEY (PatientID)
	)
PRINT 'PATIENTS TABLE'

insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (1, 'Mirta', 1, 'F', 50, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (2, 'Macus', 2, 'M', 100, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (3, 'Treat', 3, 'M', 45, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (4, 'Petro', 4, 'M', 10, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (5, 'Henry', 5, 'M', 11, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (6, 'Foxy', 6, 'F', 12, 'None', 1);
insert into patients (ClientID, PatientName, AnimalType, Gender, Weight, GeneralNotes, Chipped) values (7, 'Guna', 7, 'F', 15, 'None', 1);
--------------------------------------------Table Payments
CREATE TABLE Payments
(
	PaymentID INT NOT NULL IDENTITY(1,1)
	,PaymentDate date NOT NULL
	,BillID INT NOT NULL
	,Notes varchar(2048) NULL
	,Amount decimal NOT NULL
	
	PRIMARY KEY (PaymentID)
	)
PRINT 'PAYMENT TABLE'

insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 1, 100);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 2, 200);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 3, 300);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 4, 400);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 5, 500);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 6, 600);
insert into Payments (PaymentDate, BillID, Amount) values (getdate(), 7, 700);
-----------------------------------------------Table Visits
CREATE TABLE Visits
(
	VisitID INT NOT NULL IDENTITY(1,1)
	,StartTime datetime NOT NULL
	,Endtime datetime NOT NULL
	,Appointment BIT NOT NULL
	,DiagnosisCode varchar(12) NOT NULL
	,ProcedureCode varchar(12) NOT NULL 
	,VisitNotes varchar(2048) NOT NULL
	,PatientID INT NOT NULL
	,EmployeeID INT NOT NULL
	
	PRIMARY KEY (VisitID)
	)
 PRINT 'VISITS TABLE'

 
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '94-422-3796', '90-980-7968', 'none', 1, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '13-986-2771', '94-182-0114', 'none', 2, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '54-252-9459', '94-184-8447', 'none', 3, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '29-841-5573', '23-132-7034', 'none', 4, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '69-114-2686', '47-693-5595', 'none', 5, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '02-526-7817', '11-743-1147', 'none', 6, 6);
insert into Visits (StartTime, Endtime, Appointment, DiagnosisCode, ProcedureCode, VisitNotes, PatientID, EmployeeID) values (GETDATE(), dateadd(hour,1,getdate()), 1, '69-949-9815', '12-283-7812', 'none', 7, 6);
--Constraints---------------------

	ALTER TABLE ClientContacts ADD CONSTRAINT Clients_fk  FOREIGN KEY (ClientID) REFERENCES Clients (ClientID);

	ALTER TABLE Patients ADD CONSTRAINT Client_fk FOREIGN KEY (ClientID) REFERENCES Clients (ClientID);

	ALTER TABLE Patients  ADD CONSTRAINT AnimalTypeReference_fk FOREIGN KEY (AnimalType) REFERENCES AnimalTypeReference(AnimalTypeID);

	ALTER TABLE EmployeeContactInfo  ADD CONSTRAINT Employee_fk FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

	ALTER TABLE Visits ADD CONSTRAINT Employees_fk FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

	ALTER TABLE Visits ADD CONSTRAINT Patient_fk  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

	ALTER TABLE Billing ADD CONSTRAINT Client1_fk  FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);

	ALTER TABLE Billing  ADD CONSTRAINT Visit_fk  FOREIGN KEY (VisitID) REFERENCES Visits(VisitID);

	ALTER TABLE Payments  ADD CONSTRAINT Bill_fk FOREIGN KEY (BillID) REFERENCES Billing(BillID);


---CHECKS------------------------------------------

	ALTER TABLE Visits ADD CONSTRAINT CHK_TimeCheck CHECK (EndTime>StartTime);
	ALTER TABLE Payments ADD CONSTRAINT CHK_PayDate CHECK (PaymentDate<= getdate());
	ALTER TABLE Billing ADD CONSTRAINT CHK_BillDate CHECK (BillDate <= getdate());
	ALTER TABLE ClientContacts ADD CONSTRAINT CHK_Addrestype CHECK (AddressType = 1 or AddressType = 2);
---------------------------end Checks--------------------------------------------------------------

---LOGINS

-- Creates the login User with password.  
	CREATE LOGIN VetManager  
    WITH PASSWORD = '1234'  
	PRINT 'VetManager1 Login/Password Created'
	
	CREATE LOGIN VetClerk  
    WITH PASSWORD = '1234'  
	PRINT 'VetClerk1 Login/Password Created'
	 
-- Creates a database user for the login created above.  
	CREATE USER VetManager FOR LOGIN VetManager 
	PRINT 'VetManager1 User Created'

	CREATE USER VetClerk FOR LOGIN VetClerk
	PRINT 'VetClerk1 User Created'

--Alter Roles
 
	ALTER ROLE db_datawriter ADD MEMBER [VetManager]  Print 'VetManager Role Altered to Writer'  
	ALTER ROLE db_datareader ADD MEMBER [VetManager]  Print 'VetManater Role Altered to Reader'

	ALTER ROLE db_datareader ADD MEMBER [VetClerk] Print 'VetClerk Role Altered to Reader'  

	DENY SELECT ON ClientContacts TO VetClerk Print 'VetClerk denied Client Contacts'
	DENY SELECT ON EmployeeContactInfo TO VetClerk Print 'VetClerk denied Employee Contacts Info'

EXECUTE sp_changedbowner 'sa'
PRINT 'INITIALIZED DATABASE DIAGRAM'

--Stored Procedures TO BE DROPPED
BEGIN
	DROP PROCEDURE IF EXISTS sp_OwnersInfoBySpecies
	PRINT 'sp_OwnersInfoBySpecies DROPPED'
END

BEGIN
	DROP PROCEDURE IF EXISTS sp_OwnersInfoByBreed
	PRINT 'sp_OwnersInfoByBreed DROPPED'
END

BEGIN
	DROP PROCEDURE IF EXISTS sp_BillPayReportFromClientID
	PRINT 'sp_BillPayReportFromClientID DROPPED'
END

BEGIN
	DROP PROCEDURE IF EXISTS sp_EmpMailListByEmpID
	PRINT 'sp_EmpMailListByEmpID DROPPED'
END


--Stored Procedures TO CREATE

GO
Create Procedure sp_OwnersInfoBySpecies
(
@species  varchar(35)
)
As
Begin
	 SELECT P.PatientName, AT.Breed, CONCAT(C.FirstName,  '   ' , C.LastName) [Full Name], CC.AddressLine1,cc.City,cc.StateProvince, cc.PostalCode, CC.Phone, CC.EMail
	FROM [dbo].[ClientContacts] CC
	JOIN[dbo].[Clients] C
	ON CC.ClientID = C.ClientID
	JOIN[dbo].[Patients] P
	ON C.ClientID = P.ClientID
	JOIN [dbo].[AnimalTypeReference] AT
	ON P.AnimalType = AT.AnimalTypeID    
	Where at.Species = @species
End
GO
	PRINT 'sp_OwnersInfoBySpecies CREATED'
GO
Create Procedure sp_OwnersInfoByBreed
(
@breed  varchar(35)
)
As
Begin
	SELECT P.PatientName, AT.Species, CONCAT(C.FirstName,  '   ' , C.LastName) [Full Name],			 CC.AddressLine1,cc.City,cc.StateProvince, cc.PostalCode, CC.Phone, CC.EMail
	FROM [dbo].[ClientContacts] CC
	JOIN[dbo].[Clients] C
	ON CC.ClientID = C.ClientID
	JOIN[dbo].[Patients] P
	ON C.ClientID = P.ClientID
	JOIN [dbo].[AnimalTypeReference] AT
	ON P.AnimalType = AT.AnimalTypeID    
	Where at.breed Like '%'+ @breed +'%'	
End
GO
	PRINT 'sp_OwnersInfoByBreed CREATED'
GO
Create Procedure sp_BillPayReportFromClientID
(
@ClientID int
)
As
Begin
		SELECT  CAST(V.StartTime as date) AS 'Date Of Visit',P.PaymentDate,B.Amount  
		FROM Payments P
		JOIN Billing B
		ON P.BillID = B.BillID
		JOIN Visits V
		ON B.VisitID = V.VisitID
		WHERE B.ClientID = @ClientID
End
GO
	PRINT 'sp_BillPayReportFromClientID CREATED'
GO
CREATE PROCEDURE sp_EmpMailListByEmpID

(
@employeeID int
)

AS
BEGIN
	SELECT (E.FirstName + ', '+ E.LastName) AS [Full Name], ec.AddressLine1,ec.AddressLine2
		   ,ec.City,ec.PostalCode,ec.Phone
	FROM [dbo].[EmployeeContactInfo] EC
	JOIN [dbo].[Employees] E
	ON EC.EmployeeID = E.EmployeeID
	where e.EmployeeID = @employeeID
END
GO	
PRINT 'sp_EmpMailListByEmpID CREATED'

--Grant Permission to VetClerk to Access Stored Procedures

USE VeterinaryDB
GO
GRANT EXECUTE ON sp_OwnersInfoBySpecies  
    TO VetClerk; 
GRANT EXECUTE ON sp_OwnersInfoByBreed
    TO VetClerk;
GRANT EXECUTE ON sp_BillPayReportFromClientID  
    TO VetClerk; 
GRANT EXECUTE ON sp_EmpMailListByEmpID
    TO VetClerk; 
	
	PRINT 'GRANT EXECUTED FOR VETCLERK X4'

GO
CREATE PROCEDURE sp_NewClient
(
@FirstName varchar(25)
,@MiddleName Varchar(25)
,@LastName Varchar(25)
,@AddressType int
,@AddressLine1 Varchar(50)
,@AddressLine2 varchar (50)
,@City varchar (25)
,@StateProvince varchar(25)
,@postalcode varchar(25)
,@Phone varchar(15)
,@AltPhone varchar(15)
,@EMail varchar(35)
,@ClientID int OUTPUT
)
AS
BEGIN

    INSERT INTO Clients(FirstName,MiddleName,LastName ) 
       VALUES (@FirstName,@MiddleName,@LastName)

    SELECT @clientID=@@IDENTITY

    INSERT INTO ClientContacts(ClientID, AddressType,AddressLine1, AddressLine2, City,StateProvince,PostalCode,Phone)
        VALUES (@ClientID,@AddressType,@AddressLine1,@AddressLine2, @City,@StateProvince,@PostalCode,@Phone)  

END
GO
 PRINT 'sp_NewClient CREATED'
GO
 CREATE PROCEDURE sp_NewHire
(
@FirstName varchar(25) 
,@MiddleName Varchar(25)
,@LastName Varchar(25)
,@HireDate date
,@Title varchar (50)
,@AddressType int
,@AddressLine1 Varchar(50)
,@AddressLine2 varchar(50)
,@City varchar (25)
,@StateProvince varchar(25)
,@postalcode varchar(25)
,@Phone varchar(15)
,@AltPhone varchar(15)
,@EMail varchar(35)
,@EmployeeID int OUTPUT
)
AS
BEGIN

    INSERT INTO Employees(FirstName,MiddleName,LastName,HireDate,Title ) 
       VALUES (@FirstName,@MiddleName,@LastName,@HireDate,@Title)

    SELECT @EmployeeID=@@IDENTITY

    INSERT INTO EmployeeContactInfo(EmployeeID, AddressType,AddressLine1, AddressLine2, City,StateProvince,PostalCode,Phone,AltPhone,EMail)
        VALUES (@EmployeeID,@AddressType,@AddressLine1,@AddressLine2, @City,@StateProvince,@PostalCode,@Phone,@AltPhone,@EMail)  

END
GO
 PRINT 'sp_NewHire CREATED'


 

