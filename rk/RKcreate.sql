use [master]
GO

-- Если бд уже существуем, дропаем ее
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'dbRK')
DROP DATABASE dbRK
GO

-- Create database dbRK utf8_general_ci;
CREATE DATABASE [dbRK]
GO

USE [dbRK]
GO

CREATE TABLE candy
(

		[idcandy][int] IDENTITY(1,1)NOT NULL,
		[namecandy][varchar](32) PRIMARY KEY,
		[filling][varchar](32),
		[description][varchar](32) 
)

GO

CREATE TABLE dealers
(

		[iddealer][int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
		[namecandy][varchar](32),
		[INN][int],
		[adr][varchar](32),
		FOREIGN KEY (namecandy) REFERENCES candy(namecandy)
)

GO

CREATE TABLE shops
(

		[idshop][int] IDENTITY(1,1) PRIMARY KEY,
		[namecandy][varchar](32),
		[adr][varchar](32),
		[rate][int],
		FOREIGN KEY (namecandy) REFERENCES candy(namecandy)
)
GO

select namecandy, adr, rate
from shops
where rate > 3

select 
