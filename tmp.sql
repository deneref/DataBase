if exists (select name from sys.databases where name = N'jobs')
drop database jobs
go

create database jobs
go

use jobs
go

create table t (
	num int
)
insert t values(1), (2), (4), (6), (12)

select *  from t
go
create function dbo.get_interv() 
returns @ret table(st int, en int) as
begin
	select num from t
return
end
go

select case when a != NULL then a-lead(a,1)over(order by a) end from
(select case when lead(num,1)over(order by num)-num>1 then num 
end as a from t)


select num, lead(num)over(order by num) from t