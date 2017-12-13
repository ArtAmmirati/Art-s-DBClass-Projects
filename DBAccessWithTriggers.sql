USE MASTER;

if (select count(*) 
    from sys.databases where name = 'JobSearch') > 0
BEGIN
    DROP DATABASE JobSearch;
END
	CREATE DATABASE JobSearch
GO
	USE JobSearch
GO
CREATE TABLE Activities 
	(
	ActivityID int not null identity(1,1),
	LeadID int not null,
	ActivityDate date not null default getdate(),
	ActivityType varchar(25) not null,
	ActivityDetails varchar(255) null,
	Complete bit not null default (0), 
	ReferenceLink varchar(255) null, 
	ModifiedDate datetime NULL DEFAULT GETDATE(),
    
	PRIMARY KEY (ActivityID),
	CONSTRAINT Ck_ACTIVITYTYPE Check ([ACTIVITYTYPE] IN ('Inquiry','Application','Contact','Interview','Follow-up','Correspondence','Documentation','Closure','Other'))
	)
	GO
	
	Print 'Activities Table Created'
	GO
	Create Trigger Trg_afteractivitymodified on Activities  After insert,update 
	AS
	Begin
	update		A
	set			A.ModifiedDate = getdate()
	From		Activities A
	Inner Join	inserted i
	on			i.ActivityID = A.ActivityID
	end
	Print 'AfterActivityModified Trigger created';
GO
CREATE TABLE Sources
	(
	SourceID int not null identity(1,1),
	SourceName varchar(75) not null,
	SourceType varchar(35) null,
	SourceLink varchar(255) null,
	Descript varchar(255) null
	PRIMARY KEY (SourceID)
	)
	print 'Sources Table Created'
	GO
CREATE TABLE Leads
	(
	LeadID int not null identity(1,1),
	RecordDate Date not null default getdate(),
	JobTitle varchar(75) not null,
	Descript varchar(255) null,
	EmploymentType varchar(25) null,
	Location varchar(50) null,
	Activity bit default (-1),
	CompanyId int null, 
	AgencyID int null, 
	ContactID int null,
	SourceID int null,
	Selected bit default (0),
	ModifiedDate datetime NULL DEFAULT GETDATE(),
  
	PRIMARY KEY (LeadID),
	CONSTRAINT CK_RecordedDate CHECK ([RecordDate] <= GETDATE()),
	CONSTRAINT Ck_EmploymentType Check ([EmploymentType] IN ('Full-time','Part-time','Contractor','Temporary','Seasonal','Intern','Freelance','Volunteer'))
	)
    Print 'Leads Table Created'

	GO
	Create Trigger Trg_afterLeadmodified on Leads  After insert,update 
	AS
	Begin
	update		L
	set			L.ModifiedDate = getdate()
	From		Leads L
	Inner Join	inserted i
	on			i.LeadID = L.LeadID
	end

	Print 'AfterLeadModified Trigger created';
	GO
CREATE TABLE Contacts
	(
	ContactID int not null identity(1,1),
	CompanyID int not null ,
	CourtesyTitle varchar(25)  null,
	ContactFirstName varchar(50) null,
	ContactLastName varchar(50) null,
	Title varchar(50) null,
	Phone varchar (14) null,
	Extension varchar(10) null, 
	Fax varchar (14) null, 
	Email varchar(50) null,
	Comments varchar (255) null,
	Active bit default (-1) 

	PRIMARY KEY (ContactID),
	CONSTRAINT Ck_COURTESYTITLE Check ([COURTESYTITLE] IN ('Mr.','Ms.','Miss','Mrs.','Dr.','Rev.'))
	)

	Print 'Contacts Table Created'
GO
CREATE TABLE Companies 
	(
	CompanyID int not null identity(1,1),
	CompanyName varchar(75) not null,
	Address1 varchar(75)  null,
	Address2 varchar(75) null,
	City varchar(50) null,
	State varchar(2) null,
	Zip varchar (10) null,
	Phone varchar(14) null, 
	Fax varchar (14) null, 
	Email varchar(50) null,
	Website varchar (50) null,
	Discript varchar (255) null,
	BusinessType varchar(255) null,
	Agency bit default (0)

	PRIMARY KEY (CompanyID)
	)	
	Print 'Companies Table Created'
	GO
	
CREATE TABLE BusinessTypes
	(
	BusinessType varchar(255)
	Primary Key (BusinessType)
	)
	Print 'BusinessTypes Table Created'

-- INDEXES
CREATE INDEX idx_activities ON Activities (LeadID,ActivityDate,ActivityType);
	Print 'Index idx_activities created';

CREATE Unique Index idx_BusinessType ON BusinessTypes(BusinessType);
	Print 'Unique index idx_BusinesType created';

CREATE  Index idx_Companies ON Companies (City,state,zip);
	Print 'Index idx_Companies created';

CREATE  Index idx_Contacts ON Contacts (CompanyID,ContactLastName,Title);
	Print 'Index idx_Contacts created';

CREATE  Index idx_Leads ON Leads (RecordDate,EmploymentType,Location,CompanyID,AgencyID,ContactID,SourceID);
	Print 'Index idx_Leads created';

CREATE  Index idx_Sources ON Sources (SourceName,SourceType);
	Print 'Index idx_Sources created';
	
----FOREIGN KEYS ADDED

--	ALTER TABLE Activities ADD FOREIGN KEY(LeadID) REFERENCES leads; PRINT 'FK LeadID Added';
--	ALTER TABLE Leads ADD FOREIGN KEY(SourceID) References Sources; PRINT 'FK SourceID Added'
--	ALTER TABLE Leads ADD FOREIGN KEY(ContactID) References Contacts; PRINT 'FK ContactID Added'
--	ALTER TABLE Leads ADD FOREIGN KEY(CompanyID) References Companies; PRINT 'FK CompanyID Added'
--	ALTER TABLE Contacts  ADD FOREIGN KEY(CompanyID) References Companies; PRINT 'FK CompanyID Added'
--	ALTER TABLE Companies ADD FOREIGN KEY(BusinessType) References BusinessTypes; PRINT 'FK BusinessType Added'


--TRIGGER CREATION

-- INSERT Activities
go
CREATE TRIGGER trgCheckLeadidactivities
ON ACTIVITIES
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT LeadID
		FROM inserted
		WHERE LeadID  NOT IN (SELECT LeadID FROM Leads )
	)

BEGIN
	RAISERROR ('LeadID DOES NOT EXIST ON LEADS TABLE',16,1)
END;

GO
CREATE TRIGGER trgdeleteleadactivities
ON ACTIVITIES
AFTER DELETE
AS
	IF EXISTS
	(
		SELECT LeadID
		FROM deleted
		WHERE LeadID IN (SELECT LeadID FROM Activities )
	)

BEGIN
	RAISERROR ('LEADID CANNOT BE DELETED FROM ACTIVITIES',16,1)
	ROLLBACK TRANSACTION
END;

GO
--- Trigger  companies leads
GO
CREATE TRIGGER trgCheckCompaniesIDLEADS
ON LEADS
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT CompanyId
		FROM inserted
		WHERE CompanyId  NOT IN (SELECT CompanyId FROM Companies )
	)


BEGIN
	RAISERROR ('CompanyID DOES NOT EXIST ON LEADS TABLE',16,1)
END

GO

CREATE TRIGGER trgdeleteCompaniesIDLEADS
ON leads
AFTER Delete
AS
	IF EXISTS
	(
		SELECT CompanyId
		FROM deleted
		WHERE CompanyId   IN (SELECT CompanyId FROM leads )
	)

BEGIN
	RAISERROR ('CompanyID can not be deleted from LEADS TABLE',16,1)
	ROLLBACK TRANSACTION
END

GO

CREATE TRIGGER trgCheckcontactIDLEADS
ON leads
AFTER INSERT, UPDATE
AS

	IF EXISTS
	(
		SELECT ContactID
		FROM inserted
		WHERE ContactID  NOT IN (SELECT ContactID FROM Contacts )
	)

BEGIN
	RAISERROR ('ContactID DOES NOT EXIST ON LEADS TABLE',16,1)
END
go
CREATE TRIGGER trgdeletecontactIDLEADS
ON LEADS
AFTER DELETE
AS
	IF EXISTS
	(
		SELECT ContactID
		FROM deleted
		WHERE ContactID  IN (SELECT ContactID FROM leads )
	)

BEGIN
	RAISERROR ('ContactID cannot be deleted from LEADS TABLE',16,1)
	ROLLBACK TRANSACTION
END

GO
CREATE TRIGGER trgCheckSourceIDLEADS
ON LEADS
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT SourceID
		FROM inserted
		WHERE SourceID  NOT IN (SELECT SourceID FROM Sources )
	)
BEGIN
	RAISERROR ('SourceID DOES NOT EXIST ON SOURCE TABLE',16,1)
END

GO
CREATE TRIGGER trgdeleteSourceIDLEADS
ON LEADS
AFTER DELETE
AS
	IF EXISTS
	(
		SELECT SourceID
		FROM deleted
		WHERE SourceID  IN (SELECT SourceID FROM leads )
	)
BEGIN
	RAISERROR ('SourceID CANNOT BE DELETED FORM LEADS TABLE',16,1)
	ROLLBACK TRANSACTION
END

GO

CREATE TRIGGER trgCheckCompanyIDcontacts
ON Contacts
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT CompanyId
		FROM inserted
		WHERE CompanyId  NOT IN (SELECT CompanyId FROM Contacts )
	)

BEGIN
	RAISERROR ('CompanyID DOES NOT EXIST ON COMPANIES TABLE',16,1)
END;
GO
CREATE TRIGGER trgDELETECompanyIDcontacts
ON CONTACTS
AFTER DELETE
AS
	IF EXISTS
	(
		SELECT CompanyId
		FROM DELETED
		WHERE CompanyId  IN (SELECT CompanyId FROM COMPANIES )
	)

BEGIN
	RAISERROR ('CompanyID CANNOT BE DELETED FROM COMPANIES TABLE',16,1)
	ROLLBACK TRANSACTION
END;

GO
CREATE TRIGGER trgCheckBUSINESSTYPECOMPANIES
ON COMPANIES
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT BusinessType
		FROM inserted
		WHERE BusinessType  NOT IN (SELECT BusinessType FROM BusinessTypes )
	)

BEGIN
	RAISERROR ('BusinessType DOES NOT EXIST ON BUSINESSTYPES TABLE',16,1)
END;

GO

CREATE TRIGGER trgdeleteBUSINESSTYPECOMPANIES
ON COMPANIES
AFTER DELETE
AS
	IF EXISTS
	(
		SELECT BusinessType
		FROM deleted
		WHERE BusinessType IN (SELECT BusinessType FROM BusinessTypes )
	)

BEGIN
	RAISERROR ('BUSINESSTYPE CANNOT BE DELETED FROM BUSINESSTYPES TABLE ',16,1)
	ROLLBACK TRANSACTION
END;

GO

--INSERTS

INSERT INTO [BusinessTypes]
           ([BusinessType])
     VALUES
('Accounting'),
('Advertising/Marketing'),
('Agriculture'),
('Architecture'),
('Arts/Entertainment'),
('Aviation'),
('Beauty/Fitness'),
('Business Services'),
('Communications'),
('Computer/Hardware'),
('Computer/Services'),
('Computer/Software'),
('Computer/Training'),
('Construction'),
('Consulting'),
('Crafts/Hobbies'),
('Education'),
('Electrical'),
('Electronics'),
('Employment'),
('Engineering'),
('Environmental'),
('Fashion'),
('Financial'),
('Food/Beverage'),
('Government'),
('Health/Medicine'),
('Home & Garden'),
('Immigration'),
('Import/Export'),
('Industrial'),
('Industrial Medicine'),
('Information Services'),
('Insurance'),
('Internet'),
('Legal & Law'),
('Logistics'),
('Manufacturing'),
('Mapping/Surveying'),
('Marine/Maritime'),
('Motor Vehicle'),
('Multimedia'),
('Network Marketing'),
('News & Weather'),
('Non-Profit'),
('Petrochemical'),
('Pharmaceutical'),
('Printing/Publishing'),
('Real Estate'),
('Restaurants'),
('Restaurants Services'),
('Service Clubs'),
('Service Industry'),
('Shopping/Retail'),
('Spiritual/Religious'),
('Sports/Recreation'),
('Storage/Warehousing'),
('Technologies'),
('Transportation'),
('Travel'),
('Utilities'),
('Venture Capital'),
('Wholesale')


Print 'Insert into BusinessTypes completed'



INSERT INTO [dbo].[Sources]([SourceName],[SourceType],[SourceLink])
     VALUES('EmployFlorida','Online','https://www.employflorida.com/jobbanks/joblist.asp?'),
			('JobSeeker','Online','https://www.jobseeker.com/jobbank/joblist.asp?')


INSERT INTO [dbo].[Companies]([CompanyName],[BusinessType])
     VALUES('Pinnacle Executive Search','Computer/Software'),
			('Sentry Data Systems', 'Computer/Software')


INSERT INTO [dbo].[Contacts]([CompanyID])
     VALUES (1),(2)


INSERT INTO [dbo].[Leads]
           
           ([JobTitle],[EmploymentType],[Location],[Activity],[CompanyId],[ContactID]
           ,[SourceID],[Selected])
     VALUES('Software Developer','full-time','Oviedo,Fl',1,1,1,1,1),
			('Software Developer','full-time','Deerfield Beach,Fl',1,2,2,2,1)

INSERT INTO [dbo].[Activities]([LeadID],[ActivityType],[Complete])
		VALUES (1,'CONTACT',0),
				(2,'CONTACT',0)






