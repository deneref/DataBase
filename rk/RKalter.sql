USE [dbRK]
GO

ALTER TABLE [dbo].[candy] ADD
CONSTRAINT [PK_candy_id] PRIMARY KEY ([idcandy])
GO

ALTER TABLE [dbo].[dealers] ADD
CONSTRAINT [PK_dealre_id] PRIMARY KEY ([iddealer], [namecandy]),
CONSTRAINT [FK_namec] FOREIGN KEY ([namecandy]) REFERENCES [dbo].[candy]([namecandy])
GO

ALTER TABLE [dbo].[shops] ADD
CONSTRAINT [PK_shops_id] PRIMARY KEY ([idshop]), 
--CONSTRAINT [PK_shop] PRIMARY KEY ([namecandy], [adr]),
CONSTRAINT [FK_namec] FOREIGN KEY ([namecandy]) REFERENCES [dbo].[candy]([namecandy]),
CONSTRAINT [FK_dealer_s] FOREIGN KEY ([adr]) REFERENCES [dbo].[dealers]([adr])
GO
