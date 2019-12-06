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
if OBJECT_ID(N'get_country_uni', N'IF') is not NULL
	drop function get_country_uni
GO
create function dbo.get_country_uni(@country varchar(32)) returns table as
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
if OBJECT_ID(N'get_students', N'FN') is not NULL
	drop function get_students
GO
create function dbo.get_students(@country varchar(32))
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
CREATE FUNCTION dbo.CalculateFactorial1 (@n int = 1) RETURNS float
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
      DECLARE @result float;
        SET @result = NULL;
    IF @n > 0 BEGIN
            SET @result = 1.0;
            WITH Numbers (num)
            AS
            (
                  SELECT 1
                  UNION ALL
                  SELECT num + 1
                  FROM Numbers
                  WHERE num < @n
            )
            SELECT @result = @result * num
            FROM Numbers;
END;
      RETURN @result;
END;
GO
SELECT dbo.CalculateFactorial1 (6);