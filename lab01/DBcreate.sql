use [master]
GO

-- Если бд уже существуем, дропаем ее
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'dbEXCHANGES')
DROP DATABASE dbEXCHANGES
GO

-- Create database dbEXCHANGESOLLATE utf8_general_ci;
CREATE DATABASE [dbEXCHANGES]
GO

USE [dbEXCHANGES]
GO

--Create table of language schools
CREATE TABLE [dbo].[lanShl]
(

		[idShl][int] IDENTITY(1,1) NOT NULL,
		--Название школы
		[NameShl][varchar](32) NOT NULL,
		--страна, где нахдится школа
		[countryShl][varchar](32) NOT NULL,
		--Преподаваемый язык
		[TLanguage][varchar](32) NOT NULL
)

GO

--Create table of studensts
CREATE TABLE [dbo].[stud]
(

		[idSt][int] IDENTITY(1,1) NOT NULL,
		--Имя студента
		[NameSt][varchar](100) NOT NULL,
		--Родной язык
		[NLanguage][varchar](32) NOT NULL,
		--Изучаемый язык
		[LLanguage][varchar](32) NOT NULL
)

GO

--Create table of Universities
CREATE TABLE [dbo].[univ]
(

		[idUni][int] IDENTITY(1,1) NOT NULL,
		--Название университета
		[NameUni][varchar](100) NOT NULL,
		--Страна
		[countryUni][varchar](32) NOT NULL,
		--Основной язык преподавания
		[MLanguage][varchar](64) NOT NULL
)

GO

--Create table of exchanging programms
CREATE TABLE [dbo].[exch]
(
		[idSt][int] NOT NULL,
		[idShl][int] NOT NULL,
		[idUni][int] NOT NULL,
		--Стоимость обучения
		[cost][float] NOT NULL
)

GO