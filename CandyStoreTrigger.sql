USE CandyStore
Go

-- TRIGGER 1     
create TRIGGER CheckPhoneNumber
 on CustomerPhoneNumber
 INSTEAD of INSERT
 as 
 declare @PhoneNumber varchar(15);
 set @PhoneNumber = (select PhoneNumber from inserted)
  insert into CustomerPhoneNumber 
  select CustomerId,concat('+',@PhoneNumber)
  from inserted 


insert into CustomerPhoneNumber values(39,'49-2300000000')
insert into CustomerPhoneNumber values(39,'230000000000')
insert into CustomerPhoneNumber values(39,'49-2330')
select * from CustomerPhoneNumber


-- TRIGGER 2
alter TRIGGER CheckNationalCode
 on Manager
 AFTER INSERT
 AS
 declare @nationalCode varchar(20);
 set @nationalCode = (select NationalCode from inserted)

 if (SUBSTRING(@nationalCode,1,1) <> 0)
    set @nationalCode = CONCAT('0',@nationalCode)

 UPDATE Manager
 set NationalCode = CONCAT(SUBSTRING(@nationalCode,1,3),CONCAT('-',SUBSTRING(@nationalCode,4,len(@nationalCode))))
 where ManagerId = (select ManagerId from inserted)


