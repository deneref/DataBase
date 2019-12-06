USE [dbEXCHANGES]
GO

--�������� ������������ �� ������
SELECT *
FROM univ
WHERE countryUni = 'Russia'
ORDER BY NameUni

--�������� ����� � ������������, ��������� �� ���������� ������ ����� 4000 � 5000
SELECT idShl, idUni, cost
FROM exch
WHERE cost BETWEEN 4000 AND 5000

--������� ����� � �� ������, ��� �������� ����� �������� 'po'
SELECT * 
FROM lanShl JOIN exch ON lanShl.idShl = exch.idShl
WHERE NameShl LIKE '%po%'

--�������� ����� ���������, ����������� ����� ��� �� 3000
SELECT stud.NameSt, exch.cost
FROM stud JOIN exch ON stud.idSt = exch.idSt
WHERE exch.idSt IN
	(
		SELECT idSt
		FROM exch
		WHERE cost <= 3000
	)


SELECT *
FROM exch
WHERE EXISTS
	(
		SELECT *
		FROM exch
		WHERE cost <= 3000
	)

--�������� ��� ������, �������, ��� � �����
SELECT *
FROM stud JOIN exch ON stud.idSt = exch.idSt
WHERE cost < ALL
	(
		SELECT cost
		FROM univ JOIN exch ON univ.idUni = exch.idUni 
		WHERE NameUni = 'Omsk State University'
	)

--���������� ������� - �������� ����������� ���� �� �������
SELECT 
	countryUni,
	MIN(cost) as 'Min cost'
FROM 
	(
		SELECT countryUni, cost
		FROM univ JOIN exch ON univ.idUni = exch.idUni 
	) AS sd
GROUP BY countryUni
	

--��������� ���������� 
SELECT univ.countryUni,
	(
		SELECT AVG(cost)
		FROM univ JOIN exch ON univ.idUni = exch.idUni 
	) as AvgCost
FROM univ JOIN exch on univ.idUni = exch.idUni
GROUP BY countryUni

--simple CASE
SELECT NameUni,
	CASE countryUni
		WHEN 'Russia' THEN '������'
		ELSE '����������'
		END AS country
FROM univ
		

--������� ����� �� �����������
SELECT NameShl , 
	CASE 
	WHEN cost < 1000 THEN '�������'
	WHEN cost < 5000 and cost >= 1000 THEN '�����������'
	ELSE '���������������'
	END cost
FROM lanShl JOIN exch on lanShl.idShl = exch.idShl

--temp table
SELECT NameShl, exch.idShl, cost
INTO #tempShl
FROM lanShl JOIN exch ON lanShl.idShl = exch.idShl
	
--select * from tempShl

--��������� ��������������� �������
SELECT lanShl.NameShl, uniNexch.countryUni
FROM lanShl JOIN
	(
		SELECT NameUni, idShl, cost,countryUni
		FROM univ RIGHT JOIN exch ON univ.idUni = exch.idUni
	)AS uniNexch ON uniNexch.idShl = lanShl.idShl
ORDER BY lanShl.NameShl

--��������, ������� ������ � ������
select NameSt
from stud
where idSt in
(
	select distinct stud.idSt
	from stud join exch on stud.idSt = stud.idSt
	where cost in
	(
		select cost
		from univ join exch on exch.idUni = univ.idUni
		where univ.idUni in
		(
				select idUni
				from univ
				where countryUni = 'Russia'
		)
	)
)

--������� ���� �� �������
SELECT countryUni,
		CAST(AVG(cost) as int) as AvgCost
FROM univ JOIN exch ON univ.idUni = exch.idUni
GROUP BY countryUni

--������� ���� �� ������� ������ 5�
SELECT countryUni,
		CAST(AVG(cost) as int) as AvgCost
FROM univ JOIN exch ON univ.idUni = exch.idUni
GROUP BY countryUni
HAVING CAST(AVG(cost) as int) > 5000

--�������
INSERT lanShl(NameShl, countryShl, TLanguage)
VALUES ('English and Donuts', 'Latvia', 'Spanish')

--select * from lanShl where countryShl = 'Latvia'

Declare @cur_uni TABLE (cost int, country varchar(20), language varchar(20));
INSERT @cur_uni(cost, country, language)
SELECT(
	SELECT Max(cost)
	FROM univ join exch ON univ.idUni = exch.idUni
	WHERE countryUni = 'Spain' 
	), 'Spain', 'spanish'
FROM univ join exch ON univ.idUni = exch.idUni
WHERE countryUni = 'Spain'
select * from @cur_uni

--Update
UPDATE exch
SET cost = cost - 100
WHERE idSt = 1

UPDATE exch
SET cost = 
	(
		SELECT AVG(cost)
		FROM exch
		WHERE idSt > 500 and idSt < 600
	)
WHERE idSt = 1

DELETE exch
WHERE idSt = 666

DELETE FROM exch
WHERE idSt in
	(
		SELECT idSt 
		FROM exch JOIN stud ON exch.idSt = stud.idSt
		WHERE cost < 5000
	)

--���������� ��������� ���������
WITH  CTE(coutryUni, cost)
AS
(
	SELECT countryUni, cost
	FROM univ JOIN exch ON exch.idUni = exch.idUni
	WHERE cost < 4000
)
SELECT AVG(cost) AS '�� ����'
FROM CTE

--������� �������
SELECT NameUni, countryUni,
	AVG(cost) OVER (PARTITION BY countryUni) as AvgCost,
	Min(cost) OVER (PARTITION BY countryUni) as MinCost,
	MAX(cost) OVER (PARTITION BY countryUni) as MaxCost
FROM univ JOIN exch ON univ.idUni = exch.idUni


--rec otv
CREATE TABLE dbo.Example
(
	SomeID smallint NOT NULL,
	MoreID int NULL,
	SomeNumber int
	CONSTRAINT PK_SomeID PRIMARY KEY (SomeID ASC)
);
GO
 
INSERT dbo.Example VALUES(1,NULL,355);
INSERT dbo.Example VALUES(2,1,3324);
INSERT dbo.Example VALUES(3,2,345);
INSERT dbo.Example VALUES(4,3,122);
GO

WITH RecOTV(MoreID, SomeID, SomeNumber, Level)
AS
(
	SELECT e.MoreID, e.SomeID, e.SomeNumber, 0 AS Level
	FROM dbo.Example AS e
	WHERE MoreID IS NULL
	
	UNION ALL

	SELECT e.MoreID, e.SomeID, e.SomeNumber, Level + 1
	FROM dbo.Example AS e INNER JOIN RecOTV AS d ON e.MoreID = d.SomeID
	)

Select MoreID, SomeID, SomeNumber, level
FROM RecOTV;

--row_number
--drop table #tmp
create table #tmp (id int, countryUni varchar(20), MLanguage varchar(20))
GO

insert #tmp (id, countryUni, MLanguage)
select idUni, countryUni, MLanguage
from univ
go

--select  * from #tmp

DELETE #tmp
WHERE id in 
	(
		SELECT id
		FROM 
			(
				SELECT id, countryUni, MLanguage,
				ROW_NUMBER() over
				(
					Partition by countryUni, MLanguage
					order by id
				) as uniq
				FROM #tmp
			) as a
		WHERE a.uniq <> 1
)
select * from #tmp