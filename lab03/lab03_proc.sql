--хранимая процедура без параметров
create or alter procedure dbo.SelectRussians as
begin
	select NameSt
	from stud
	where NLanguage = 'Russian'
end
go
exec SelectRussians
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

go
--процедура доступа к метаданным
create or alter procedure ScalarShow as
begin
	select distinct sys.objects.object_id
	from sys.objects join sys.parameters 
	on sys.objects.object_id = sys.parameters.object_id
	where [type] = 'FN'
end
exec ScalarShow