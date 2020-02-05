--вариант второй

if exists (select name from sys.databases where name = N'jobs')
drop database jobs
go

create database jobs
go

use jobs
go

create table person (
	pid int identity(1,1) not null,
	pname varchar(32) not null,
	pbirth date not null,
	pexp int not null,
	pphone varchar(32) not null,
	primary key (pid)
)

create table hire (
	hid int identity(1,1) not null,
	hname varchar(32) not null,
	hbirth date not null,
	hexp int not null,
	hphone varchar(32) not null,
	primary key (hid)

)

create table job (
	jid int identity(1,1) not null,
	jname varchar(32) not null,
	jcost int not null,
	jreq varchar(200),
	primary key (jid)
)

create table pj (
	pjid int identity(1,1) not null,
	pid int references person (pid),
	jid int references job (jid),
	primary key (pjid)
)

create table ph (
	phid int identity(1,1) not null,
	pid int references person (pid),
	hid int references hire (hid),
	primary key (phid)
	
)

create table hj (
	hjid int identity(1,1) not null,
	hid int references hire (hid),
	jid int references job (jid),
	primary key (hjid)
)

insert person values ('Ваня', '01.01.1979', 5, '555-341-32')
insert person values ('Изя', '01.01.1980', 10, '555-341-32')
insert person values ('Ада', '01.01.1981', 23, '555-341-32')
insert person values ('Даня', '01.01.1982', 54, '555-341-32')
insert person values ('Руслан', '01.01.1983', 15, '555-341-32')
insert person values ('Костя', '01.01.1984', 523, '555-341-32')
insert person values ('Ваня', '01.01.1985', 56, '555-341-32')
insert person values ('Ваня', '01.01.1985', 56, '555-341-32')
insert person values ('Ваня3', '01.01.1987', 57, '555-341-32')
insert person values ('Ваня4', '01.01.1988', 58, '555-341-32')

select count(*) - (select count(*) as a from 
(select distinct *  from mytable) as s) as dupl from mytable

select count(*) as a from 
(select distinct *  from person) as s

select *,
          row_number() over (partition by all) as row_number
   from person

go
insert hire values ('Саня', '01.01.1980', 5, '555-341-25')
insert hire values ('Валя', '01.01.1981', 57, '565-371-32')
insert hire values ('Галя', '01.01.1982', 53, '555-240-32')
insert hire values ('Соня', '01.01.1983', 51, '523-341-32')
insert hire values ('Лиза', '01.01.1979', 59, '511-361-72')

insert job values ('job1', 590, 'this')
insert job values ('job1', 590, 'this2')
insert job values ('job1', 590, 'this3')
insert job values ('job1', 590, 'this')
insert job values ('job2', 600, 'this1')
insert job values ('job3', 133, 'this2')
insert job values ('job4', 345, 'this3')
insert job values ('job5', 5900, 'this4')
insert job values ('Лиза', 59, 'this')
insert job values ('Лиза1', 60, 'this')
insert job values ('Лиза', 61, 'this')

insert pj values (1, 4)
insert pj values (2,1)
insert pj values (2, 2)
insert pj values (3,1)

insert ph values (1,1)
insert ph values (4,1)
insert ph values (3,2)
insert ph values (3,3)

insert hj values (4,1)
insert hj values (1,1)
insert hj values (2,2)
insert hj values (3,3)

-- Выводит заказчиков со стажем > 5 лет
select hname, hexp from hire where hexp > 5

-- Нумерует однотипные работы 
SELECT jid, jname, jcost, jreq, 
		ROW_NUMBER() OVER
			(	
				PARTITION BY jname
				ORDER BY jid
			) as num
		FROM job

-- Выводит заказчиков и работающих на них исполнителей
select hname, pname from hire h join (
select pname, j.pid, hid from person p join ph as j on p.pid = j.pid ) as o on o.hid = h.hid

select * from hire
go
--выводит индексы таблицы по имени датабазы и имени таблицы
create procedure get_index(@databaseName varchar(32), @tableName varchar(32))
as begin 
SELECT     *
FROM         sysobjects JOIN
         sysindexes ON sysobjects.id = sysindexes.id
WHERE     sysobjects.name = @tableName
ORDER BY sysobjects.name, sysindexes.indid
end

drop procedure get_index
select * from sysobjects
select * from sysindexes 
select * from sysdatabases
SELECT * FROM information_schema.tables
exec get_index @databaseName = 'jobs', @tableName = 'hire'
