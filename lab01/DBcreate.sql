use [master]
GO

-- ���� �� ��� ����������, ������� ��
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
		--�������� �����
		[NameShl][varchar](32) NOT NULL,
		--������, ��� �������� �����
		[countryShl][varchar](32) NOT NULL,
		--������������� ����
		[TLanguage][varchar](32) NOT NULL
)

GO

--Create table of studensts
CREATE TABLE [dbo].[stud]
(

		[idSt][int] IDENTITY(1,1) NOT NULL,
		--��� ��������
		[NameSt][varchar](100) NOT NULL,
		--������ ����
		[NLanguage][varchar](32) NOT NULL,
		--��������� ����
		[LLanguage][varchar](32) NOT NULL
)

GO

--Create table of Universities
CREATE TABLE [dbo].[univ]
(

		[idUni][int] IDENTITY(1,1) NOT NULL,
		--�������� ������������
		[NameUni][varchar](100) NOT NULL,
		--������
		[countryUni][varchar](32) NOT NULL,
		--�������� ���� ������������
		[MLanguage][varchar](64) NOT NULL
)

GO

--Create table of exchanging programms
CREATE TABLE [dbo].[exch]
(
		[idSt][int] NOT NULL,
		[idShl][int] NOT NULL,
		[idUni][int] NOT NULL,
		--��������� ��������
		[cost][float] NOT NULL
)

GO