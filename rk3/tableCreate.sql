USE tempdb;
GO
drop table person
drop table org
CREATE TABLE org
(
	orgID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	companyName varchar(40) NOT NULL,
	adres varchar(40) NOT NULL,
	phoneNum varchar(40) 
);

GO
CREATE TABLE person
(
	personID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	personName nvarchar(40) NOT NULL,
	cumple date NOT NULL,
	depart nvarchar(40) NOT NULL,
	orgID int,
	FOREIGN KEY (orgID) REFERENCES org(orgID)
);

insert org(companyName, adres, phoneNum)
values ('Московский Филиал (ГО)', 'Герцена, 5', '456-78-23'),
('Новосибирский доп.офис', 'Пролетарская, 8', '543-62-34'),
('Саратовский доп.офис', 'Шухова, 44', '452-56-11'),
('Томский филиал', 'Герцена, 7', '987-46-74')


insert person(personName, cumple, depart, orgID)
values ('Иванов Иван Иванович', '25-09-1990', 'ИТ', 1),
('Петров Петр Петрович', '12-11-1987', 'Бугалтерия', 3),
('Петров Петр Петрович2', '12-10-1987', 'аудит', 2),
('Петров Петр Петрович3', '13-11-1987', 'Бугалтерия', 3),
('Петров Петр Петрович4', '14-11-1987', 'аудит', 2)
go

CREATE FUNCTION LeastWorkers()
RETURNS int
BEGIN
	--Сколько всего отделов
	declare @lenorg int = (select count(orgID) from org)
	--Принимаем людей в первом отделе за минимальную величину
	declare @min_len int = (select count(orgID) from person where orgID = 1 group by orgID)
		--проходим по каждому отделу и находим сколько там людей
		while @lenorg > 0 
		begin
			declare @cur_len int = (select count(orgID) from person where orgID = @lenorg group by orgID)
			--ли если NULL присваиваем ноль
			if @cur_len = NULL begin set cur_lent = 0 end
			--если нашли меньше - присваиваем
			if @min_len>@cur_len
			begin set @min_len = @cur_len end
			set @lenorg = @lenorg - 1
		end
	RETURN @min_len;
END
GO
