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
values ('���������� ������ (��)', '�������, 5', '456-78-23'),
('������������� ���.����', '������������, 8', '543-62-34'),
('����������� ���.����', '������, 44', '452-56-11'),
('������� ������', '�������, 7', '987-46-74')


insert person(personName, cumple, depart, orgID)
values ('������ ���� ��������', '25-09-1990', '��', 1),
('������ ���� ��������', '12-11-1987', '����������', 3),
('������ ���� ��������2', '12-10-1987', '�����', 2),
('������ ���� ��������3', '13-11-1987', '����������', 3),
('������ ���� ��������4', '14-11-1987', '�����', 2)
go

CREATE FUNCTION LeastWorkers()
RETURNS int
BEGIN
	--������� ����� �������
	declare @lenorg int = (select count(orgID) from org)
	--��������� ����� � ������ ������ �� ����������� ��������
	declare @min_len int = (select count(orgID) from person where orgID = 1 group by orgID)
		--�������� �� ������� ������ � ������� ������� ��� �����
		while @lenorg > 0 
		begin
			declare @cur_len int = (select count(orgID) from person where orgID = @lenorg group by orgID)
			--�� ���� NULL ����������� ����
			if @cur_len = NULL begin set cur_lent = 0 end
			--���� ����� ������ - �����������
			if @min_len>@cur_len
			begin set @min_len = @cur_len end
			set @lenorg = @lenorg - 1
		end
	RETURN @min_len;
END
GO
