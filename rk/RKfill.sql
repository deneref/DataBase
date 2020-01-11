USE [dbRK]
GO

BULK INSERT candy
FROM 'C:\Users\danii\Desktop\Database\DataBase\RK\candies.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ':', 
ROWTERMINATOR = '\n');

GO


BULK INSERT dealers
FROM 'C:\Users\danii\Desktop\Database\DataBase\RK\dealers.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ':', 
ROWTERMINATOR = '\n');

GO

BULK INSERT shops
FROM 'C:\Users\danii\Desktop\Database\DataBase\RK\shops.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ':', 
ROWTERMINATOR = '0x0a' );

GO