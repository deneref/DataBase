use master
go

if exists (select name from sys.databases where name = N'optional')
drop database optional
go

create database optional
go

use optional
go

create table person (
	pid int identity(1,1) not null,
	pname varchar(32) not null,
	primary key (pid)
)

create table atype (
	atid int identity(1,1) not null,
	ades varchar(32) not null,
	primary key (atid)
)

create table pabsent (
	paid int identity(1,1) not null,
	pid int references person (pid),
	adate date not null,
	atid int references atype (atid),
	primary key (paid)
)

-----------------------------------------------

insert person values ('Ваня')
insert person values ('Егор')
insert person values ('Катя')
insert person values ('Данил')
insert person values ('Дмитрий')
insert person values ('Яна')

insert atype values ('план отпуск')
insert atype values ('декрет')
insert atype values ('болезнь')
insert atype values ('без ув п')

insert pabsent values (1,'25.06.2012',1)
insert pabsent values (1,'26.06.2012',1)
insert pabsent values (1,'27.06.2012',1)
insert pabsent values (1,'28.06.2012',1)
insert pabsent values (2,'27.06.2012',3)
insert pabsent values (2,'28.06.2012',4)
insert pabsent values (3,'10.06.2012',2)
insert pabsent values (3,'11.06.2012',2)
insert pabsent values (3,'12.06.2012',2)
insert pabsent values (3,'13.06.2012',2)

--------------------------------------------------

select * from person
select * from atype
select atid, pid, adate from pabsent group by atid, pid, adate

declare @cur table(atid int, pid int, adate date)
insert @cur(atid, pid, adate) select atid, pid, adate from pabsent group by atid, pid, adate
select * from @cur order by adate

go
--СРЕАТЕ ФУНКТИОН
create function dbo.get_abs()
returns @ret table(atid int, pid int, adate date, retdate date)  as 
begin
--tmp table
declare @cur table(atid int, pid int, adate date)
insert @cur(atid, pid, adate) select atid, pid, adate from pabsent group by atid, pid, adate
--declate cursor
declare @atid int
declare @pid int
declare @adate date
declare @cursor cursor
set @cursor = cursor scroll for select * from @cur;
begin
	open @cursor 
	fetch next from @cursor into @atid, @pid, @adate
		while @@FETCH_STATUS = 0
		begin
			--Проверяем, являются ли даты пограничными
			if (not exists(select adate from @cur where adate = DATEADD(day, 1, @adate) and atid = @atid and pid = @pid)) or
			not exists (select adate from @cur where adate = DATEADD(day, -1, @adate) and atid = @atid and pid = @pid)
			begin	
				if not exists(select adate from @cur where adate = DATEADD(day, -1, @adate) and atid = @atid and pid = @pid)
				begin
					insert into @ret values(@atid, @pid, @adate, @adate)
				end
				--дата конца прогулов
				else if not exists(select adate from @cur where adate = DATEADD(day, 1, @adate) and atid = @atid and pid = @pid)
				begin 
					update @ret set retdate = @adate where atid = @atid and pid = @pid
				end
			end
			fetch next from @cursor into @atid, @pid, @adate
		end
end
return 
end
go

drop function dbo.get_abs

declare @cur table(atid int, pid int, adate date)
insert @cur(atid, pid, adate) select atid, pid, adate from pabsent group by atid, pid, adate
select * from @cur order by adate
select * from dbo.get_abs()