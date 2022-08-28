use analyticsdb;

create table course(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int,
course_discount int,
create_date date);

drop table course;

create table course_update(
course_mentor varchar(50),
course_price_update int,
course_discount_update int
);

drop table course_update;

-- Trigger 

delimiter $$
create trigger course_before_insert
before insert 
on course for each row
begin
	declare user_val varchar(50);
	set new.create_date = sysdate();
    select user() into user_val;
    set new.user_update= user_val;
end; $$

 delimiter $$
create trigger course_before_insert2
before insert 
on course for each row
begin
	set new.create_date = sysdate();
    set new.user_update= user();
end; $$

insert into course (course_id,course_desc, course_mentor,course_price,course_discount) values(103,'FSDS','Sushanshu',1000,10);
select * from course;

create table course(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int,
course_discount int,
create_date date);

alter table course add column(user_update varchar(50));


create table ref_course(
record_insert_date date,
record_insert_user varchar(50)
);

drop trigger course_before_insert;

 delimiter $$
create trigger course_before_insert3
before insert 
on course for each row
begin
	set new.create_date = sysdate();
    set new.user_update= user();
    insert into ref_course values(sysdate(),user());
end; $$


insert into course (course_id,course_desc, course_mentor,course_price,course_discount) values(103,'FSDS','Sushanshu',1000,10);
select * from course;
select * from ref_course;


create table test1(a varchar(20), date1 date, empid int);
create table test2(a varchar(20), date1 date, empid int);
create table test3(a varchar(20), date1 date, empid int);

drop trigger before_insert;

delimiter ##
create trigger before_insert
before insert on test1 for each row
begin
	insert into test2 values("abc",sysdate(),111);
    insert into test3 values("abc",sysdate(),111);
end;##

select * from test1;
select * from test2;
delete from test3;
select * from test3;
insert into test1 values("Rank",sysdate(),147);

update test1
set a = "Peter";




-- UPDATE TRIGGER
delimiter $$
create trigger update_triggger
after update on test1 for each row
begin
	update test2 set empid = 100;
    insert into test3 values("abc",sysdate(),100);
    delete from test3 where empid = 111;
end;
$$


-- DELETE TRIGGER
delimiter ^^
create trigger after_delete
after delete on test1 for each row
begin
	insert into test3 values('after delete operation', sysdate(),1111);
end;

delimiter ^^
create trigger before_delete
before delete on test1 for each row
begin
	insert into test3 values('after delete operation', sysdate(),1111);
end;

delimiter ^^
create trigger before_delete
before delete on test1 for each row
begin
	insert into test2 values('after delete ', sysdate(),1111);
end;


delete from test1 where empid = 145;

select * from test1;
select * from test2;
delete from test3;
select * from test3;

----



create table test11(
c1 varchar(50),
c2 date,
c3 int)




create table test12(
c1 varchar(50),
c2 date,
c3 int )




create table test13(
c1 varchar(50),
c2 date,
c3 int )


delimiter //
create trigger to_delete_others_before_observation3
before delete on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //






insert into test11 values("sudh" , sysdate(), 435456);
select * from test11


delete from test11 where c1 = 'sudh'


select * from test12




delimiter //
create trigger to_delete_others_before_observation4
after delete on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //


delete from test11 where c1 = 'sudhanshu'




delimiter //
create trigger to_upate_others
after update on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //


select * from test11;


insert into test11 values("sudh",sysdate(),234354)


update test11 set c1 = "after update" where c1 = "after delete"




select * from  test12;


delimiter //
create trigger to_upate_others_before
before update on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(new.c1, new.c2,new.c3);
end; //


update test11 set c1 = "insert new" where c1 = "sudh"


