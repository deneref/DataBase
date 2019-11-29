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

--���������� �������
SELECT 
	SUM(cost)/COUNT(exch.idSt) as 'Avrg cost'
FROM 
	(
		SELECT NameUni, cost
		FROM univ JOIN exch ON univ.idUni = exch.idUni 
		WHERE countryUni = 'RUSSIA'
		GROUP BY cost, NameUni
	) AS sd
	GROUP BY cost, exch.idSt
	

--��������� ����������

--������� ����� �� �����������
SELECT NameShl , 
	CASE WHEN cost < 1000 THEN '�������'
	WHEN cost < 5000 and cost >= 1000 THEN '�����������'
	ELSE '���������������'
	END cost
FROM lanShl JOIN exch on lanShl.idShl = exch.idShl

--temp table
SELECT NameShl, exch.idShl, cost
INTO tempShl
FROM lanShl JOIN exch ON lanShl.idShl = exch.idShl
	
--select * from tempShl

--
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