USE [AdventureWorks2012]
GO

CREATE TABLE dbo.FILES(
ID int,
FileFullPath NVARCHAR(150),
CreationTime DATETIME
)

GO

--DROP TABLE dbo.FILES;

SELECT * FROM dbo.FILES