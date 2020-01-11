--разрешение clr
sp_configure 'show advanced option', 1
GO
RECONFIGURE
GO
sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO
sp_configure 'clr strict security', 0
GO 
RECONFIGURE
GO

--Скалярная функция
CREATE ASSEMBLY SqlServerUDF
AUTHORIZATION dbo
FROM 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task1.dll'
WITH PERMISSION_SET = SAFE
GO

CREATE FUNCTION GetRandomNumber ()
RETURNS INT
AS
EXTERNAL NAME
SqlServerUDF.[SqlServerUDF].GetRandomNumber
GO

select dbo.GetRandomNumber() as random
go

--Агрегатная функция
create assembly Mult
authorization dbo
from 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task2.dll'
with PERMISSION_SET = SAFE
GO

create aggregate Mult (@input int) returns int 
external NAME Mult.Mult;  
 
select dbo.Mult(A.cost) from (select cost from exch where (idSt between 1 and 5) and cost < 2000) as A;  

drop aggregate Mult
drop assembly Mult
go

--Табличная функция
create assembly interval from 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task3.dll';  
go
create function dbo.interval(@a int)
returns table (pow int)
as
external name interval.[pow2.TableValuedFunction].GenerateInterval
go

select * from dbo.interval(20)

drop function interval
drop assembly interval
go
--хранимая процедура
CREATE ASSEMBLY sumramproc FROM 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task4.dll';  
GO

CREATE PROCEDURE RamSum (@sum int OUTPUT)  
AS EXTERNAL NAME sumramproc.StoredProcedures.RamSum
Go

drop procedure RamSum
drop assembly sumramproc

declare @rets int
exec RamSum @rets output
select @rets
SELECT idSt FROM exch where cost < 1000

--trigger
CREATE ASSEMBLY sometrigger FROM 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task5.dll';  
GO

create trigger think on stud instead of delete as
EXTERNAL NAME sometrigger.CLRTriggers.DropTableTrigger
go

delete from stud where idSt = 1
select * from stud where idSt = 1

--определяемый тип данных
CREATE ASSEMBLY point FROM 'C:\Users\danii\Desktop\Database\DataBase\lab04\cs\task6.dll';  
GO

CREATE TYPE Point   
EXTERNAL NAME point.[Point];  

-- type test
CREATE TABLE dbo.Points 
( 
  id INT IDENTITY(1,1) NOT NULL, 
  point Point NULL 
);
GO

INSERT INTO dbo.Points(point) 
VALUES('0,0'),
	  ('1,1'),
	  ('1,5'),
	  ('5,6')
GO

select point.ToString() from Points