USE [dbEXCHANGES]
GO

--��������� ����������� ������� �������� ���� [lanShl] ����� ����������
--���������� ����� ������������
ALTER TABLE [dbo].[lanShl] ADD
CONSTRAINT [PK_Shl_id] PRIMARY KEY ([idShl])
GO

--��������� ����������� ������� ��������� [stud] ����� ����������
--���������� ����� ������������
ALTER TABLE [dbo].[stud] ADD
CONSTRAINT [PK_Stud_id] PRIMARY KEY ([idSt])
GO

--��������� ����������� ������� ������������� [univ] ����� ����������
--���������� ����� ������������ � ����� ������������
ALTER TABLE [dbo].[univ] ADD
CONSTRAINT [PK_Univ_id] PRIMARY KEY ([idUni]),
CONSTRAINT [Unique_Univ_name] UNIQUE ([NameUni])
GO

--��������� ���������� ������� ������� ��������� [exch] �����
--���������� ���������� ����� � ������� ������

ALTER TABLE [dbo].[exch] ADD
CONSTRAINT [PK_exch] PRIMARY KEY ([idSt], [idShl], [idUni]),
CONSTRAINT [FK_exch_shl] FOREIGN KEY ([idSt]) REFERENCES [dbo].[stud]([idSt]),
CONSTRAINT [FK_exch_stud] FOREIGN KEY ([idShl]) REFERENCES [dbo].[lanShl]([idShl]),
CONSTRAINT [FK_exch_uni] FOREIGN KEY ([idUni]) REFERENCES [dbo].[univ]([idUni])
GO

--��������� ������ ����� ��������� ����������� CHECK
ALTER TABLE [dbo].[stud] ADD
CONSTRAINT [Language_check] CHECK ([NLanguage] != [LLanguage] )
GO


ALTER TABlE [dbo].[exch] ADD
CONSTRAINT [Price_check] CHECK ([cost] >= 0)
GO