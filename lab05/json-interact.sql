use dbEXCHANGES
go

-- FIRST --
select * from stud
declare @temp nvarchar(4000)
set @temp =
(SELECT NameSt AS [Name], Nlanguage AS [NLang], LLanguage AS [LLabg]
FROM stud
FOR JSON PATH, ROOT('Students'))

select @temp

-- SECOND --

declare @temp2 nvarchar(4000)
set @temp2 = (
SELECT * FROM OPENROWSET(BULK N'C:\Users\danii\Desktop\Database\DataBase\lab05\data.json', SINGLE_CLOB) AS Contents
)
select @temp2


SELECT *
FROM OPENJSON(@temp2, N'$.Logistic')
WITH (
    car_clients      VARCHAR(200)    N'$.car.client',
    tranport_date_car        DATETIME        N'$.car.date',
    track_cargos    VARCHAR(200)    N'$.track.cargo',
    transport_date_track    DATETIME        N'$.track.date'
)
