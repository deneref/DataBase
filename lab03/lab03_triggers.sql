
create trigger DenyInsert_exch
on exch instead of insert
as 
begin
	RAISERROR('No insertions in exchenges', 10, 1)
end
go

insert into exch values(100, 100, 100, 100)
drop trigger DenyInsert_exch
go

create trigger low_cost on exch
after insert 
as
if exists 
	(
		select * 
		from exch join inserted as i on exch.cost = i.cost
		where exch.cost < 1000
	)
begin
RAISERROR ('Cost is too low', 16, 1)
ROLLBACK TRANSACTION
return
end
go
insert into exch values(100,100,100,100)
go
create trigger show_change on exch
after update as
	select *
	from deleted as d join inserted as i on i.idSt = d.idSt

update exch set cost = 1001 
where idSt = 1


