 USE AdventureWorks2012
 GO
 SELECT E.BusinessEntityID, (P.LastName + ', '+ p.FirstName) [Full Name],e.Gender,e.JobTitle, e.HireDate
 INTO #CurrentEmployeesTempTable1
 FROM [HumanResources].[Employee] E
 JOIN [Person].[Person] P
 ON E.BusinessEntityID = P.BusinessEntityID
 WHERE  CurrentFlag = 1
 Order by e.HireDate desc
 
 Select Distinct(BusinessEntityID),max([RateChangeDate]) RateChangeDate,max([Rate])Rate
 INTO #CurrentRateChangeDateTempTbl
 From HumanResources.EmployeePayHistory
 Group by BusinessEntityID
 Order by BusinessEntityID asc

 
SELECT a.BusinessEntityID, a.[Full Name], a.Gender, a.JobTitle, a.HireDate,b.RateChangeDate,b.Rate
FROM #CurrentEmployeesTempTable1 a,#CurrentRateChangeDateTempTbl b
WHERE a.BusinessEntityID = b.BusinessEntityID