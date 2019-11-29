USE [dbEXCHANGES]
GO

--Изменение определения таблицы языковых школ [lanShl] путем добавления
--первичного ключа уникальности
ALTER TABLE [dbo].[lanShl] ADD
CONSTRAINT [PK_Shl_id] PRIMARY KEY ([idShl])
GO

--Изменение определения таблицы студентов [stud] путем добавления
--первичного ключа уникальности
ALTER TABLE [dbo].[stud] ADD
CONSTRAINT [PK_Stud_id] PRIMARY KEY ([idSt])
GO

--Изменение определения таблицы университетов [univ] путем добавления
--первичного ключа уникальности и ключа уникальности
ALTER TABLE [dbo].[univ] ADD
CONSTRAINT [PK_Univ_id] PRIMARY KEY ([idUni]),
CONSTRAINT [Unique_Univ_name] UNIQUE ([NameUni])
GO

--изменение определени таблицы обменов студентов [exch] путем
--добавления первичного ключа и внешних ключей

ALTER TABLE [dbo].[exch] ADD
CONSTRAINT [PK_exch] PRIMARY KEY ([idSt], [idShl], [idUni]),
CONSTRAINT [FK_exch_shl] FOREIGN KEY ([idSt]) REFERENCES [dbo].[stud]([idSt]),
CONSTRAINT [FK_exch_stud] FOREIGN KEY ([idShl]) REFERENCES [dbo].[lanShl]([idShl]),
CONSTRAINT [FK_exch_uni] FOREIGN KEY ([idUni]) REFERENCES [dbo].[univ]([idUni])
GO

--Изменение таблиц путем добавлния ограничений CHECK
ALTER TABLE [dbo].[stud] ADD
CONSTRAINT [Language_check] CHECK ([NLanguage] != [LLanguage] )
GO


ALTER TABlE [dbo].[exch] ADD
CONSTRAINT [Price_check] CHECK ([cost] >= 0)
GO