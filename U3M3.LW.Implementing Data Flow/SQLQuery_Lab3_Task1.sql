CREATE DATABASE HumanResources;
 USE HumanResources 
 GO
--DROP TABLE dbo.EmployeesExternal;

CREATE TABLE dbo.EmployeesExternal
(EmployeeID INT PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL, 
 JobTitle NVARCHAR(50) NOT NULL, 
 EmailAddress NVARCHAR(50) NULL, 
 City NVARCHAR(50) NOT NULL, 
 StateProvinceName NVARCHAR(50) NOT NULL, 
 CountryRegionName NVARCHAR(50) NOT NULL);

--DROP TABLE dbo.EmployeesAW;

CREATE TABLE dbo.EmployeesAW
(BusinessEntityID INT PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL,
 JobTitle NVARCHAR(50) NULL);

--DROP TABLE dbo.EmailAddressesAW;

CREATE TABLE dbo.EmailAddressesAW
(EmailAddressId INT PRIMARY KEY, 
 BusinessEntityID INT NOT NULL,
 EmailAddress NVARCHAR(50) NOT NULL);

 select * from dbo.EmployeesExternal;
 select * from dbo.EmployeesAW;
 select * from dbo.EmailAddressesAW;
 Go 

 USE AdventureWorks2012 
 GO

 truncate table dbo.EmployeesExternal;truncate table dbo.EmployeesAW;truncate table dbo.EmailAddressesAW;

 --1. 
 SELECT 
    e.[BusinessEntityID] AS [EmployeeID]
    ,p.[FirstName]
    ,p.[LastName]
    ,e.[JobTitle]  
    ,ea.[EmailAddress]
    ,a.[City]
    ,sp.[Name] AS [StateProvinceName] 
    ,cr.[Name] AS [CountryRegionName] 
FROM [HumanResources].[Employee] e
  INNER JOIN [Person].[Person] p
  ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Person].[PersonPhone] pp
    ON pp.BusinessEntityID = p.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
    ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID]
order by [EmployeeID],[FirstName],[LastName];

--2.  
select p.[BusinessEntityID],[FirstName],[LastName],[JobTitle]
from [Person].[Person] p
    inner join [HumanResources].[Employee] e
      on p.BusinessEntityID = e.BusinessEntityID
order by [BusinessEntityID],[FirstName],[LastName];
    
--3. 
select [EmailAddressID],p.[BusinessEntityID],[EmailAddress]
  from [Person].[EmailAddress] e
    inner join [Person].[Person] p
      on e.[BusinessEntityID] = p.BusinessEntityID
order by [EmailAddressID], [BusinessEntityID];

