USE [dbEXCHANGES]
GO

BULK INSERT [dbEXCHANGES].[dbo].[lanShl]
FROM 'C:\Users\danii\Desktop\Database\lab01\schools.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ' :', 
ROWTERMINATOR = '\n',CHECK_CONSTRAINTS);

GO


BULK INSERT [dbEXCHANGES].[dbo].[stud]
FROM 'C:\Users\danii\Desktop\Database\lab01\students.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ' :', 
ROWTERMINATOR = '\n', CHECK_CONSTRAINTS);

GO

BULK INSERT [dbEXCHANGES].[dbo].[univ]
FROM 'C:\Users\danii\Desktop\Database\lab01\univercities.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ' :', 
ROWTERMINATOR = '0x0a', CHECK_CONSTRAINTS );

GO

BULK INSERT [dbEXCHANGES].[dbo].[exch]
FROM 'C:\Users\danii\Desktop\Database\lab01\exchanges.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ' :', 
ROWTERMINATOR = '\n', CHECK_CONSTRAINTS);
