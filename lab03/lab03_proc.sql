--хранимая процедура без параметров
if OBJECT_ID (N'dbo.SelectRussians', 'P') is not null
	drop procedure dbo.SelectRussians
go
create procedure dbo.SelectRussians @amount int output as
begin
	select NLanguage
	from stud
	where NLanguage = 'Russian'
	Set @amount = @@ROWCOUNT
Return (select avg(cost) from stud join exch on exch.idSt = stud.idSt)
end
go

declare @outParm int, @retVal int
exec @retVal = dbo.SelectRussians @OutParm OUTPUT
select @outParm "Количество русских", @retVal "Средняя цена обучения для них"

--рекурсивная функция
go
create or alter procedure dbo.Recursion(@id int = 1)
as
begin
	if @id > 10
	begin 
		return
	end
else begin
	select * 
	from dbo.stud
	where idSt = @id
	set @id = @id + 1
	exec dbo.Recursion @id
end
end
go
exec Recursion 5

--Хранимая процедура с курсором
create table #spanish (nlang varchar(32), cost int, name varchar(32))
go
create or alter procedure increase_cost(@target_l int = 0, @target_h int = 1000) as
declare @nlang varchar(32)
declare @cost int
declare @name varchar(32) 
declare @cur cursor
set @cur = cursor scroll
	for select Nlanguage, cost, NameSt
	from exch join stud on exch.idSt = stud.idSt
	where cost between @target_l and @target_h;
begin
	open @cur;
	fetch next from @cur into @nlang, @cost, @name
	while @@FETCH_STATUS = 0
	begin
			if @nlang = 'Spanish'
			begin
				set @cost = @cost + 100
				insert into #spanish values(@nlang, @cost, @name);
			end
	fetch next from @cur into @nlang, @cost, @name
end;
close @cur
end
go

select * from stud join exch on stud.idSt = exch.idSt where NLanguage = 'Spanish' and cost < 1000 and cost > 100
exec increase_cost @target_l = 100, @target_h = 1000;
select * from #spanish

