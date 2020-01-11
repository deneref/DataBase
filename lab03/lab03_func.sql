--скалярная функция
create function dbo.get_cost(@id int) returns int as
begin
	return 
	(
		select exch.cost
		from exch
		where idUni = @id
	)
end;
GO
--select dbo.get_cost(exch.idUni) as cost
--from exch

GO

--подставляемая табличная функция
create or alter function dbo.get_country_uni(@country varchar(32)) returns table as
return
	(
		select NameUni, exch.cost
		from exch join univ on exch.idUni=univ.idUni
		where countryUni = @country
	)
;
GO
select * from dbo.get_country_uni('Russia')
GO 

--многооператорная табличная функция
create or alter function dbo.get_students(@country varchar(32))
returns @studentsByCountry table 
(
	NameStudent varchar(100),
	NameUniversity varchar(100),
	cost int
)
as begin
		insert into @studentsByCountry
		select NameSt, NameUni, cost
		from exch join univ on exch.idUni=univ.idUni join stud on exch.idSt=stud.idSt
		where countryUni = 'Estonia'
RETURN
end;
GO
select * from dbo.get_students('Estonia')
GO

--Рекурсивная функция
create or alter function dbo.CalculateFactorial1 (@n int = 1) returns int
with returns null on null input
as
begin
        declare @result int;
        set @result = NULL;
		if @n > 0 
		begin
            set @result = 1;
            with Numbers (num)
            as
            (
                  select 1
                  union all
                  select num + 1
                  from Numbers
                  where num < @n
            )
			select @result = @result * num
			from Numbers;
		
		end;
      return @result;
end;
GO
select dbo.CalculateFactorial1 (6) as 'Факториал';