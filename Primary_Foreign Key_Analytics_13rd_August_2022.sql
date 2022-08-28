use analyticsdb;

create table ineuron(
course_id int not Null,
course_name varchar(60),
course_status varchar(40),
number_of_enrollment int,
primary key(course_id));

desc ineuron;
drop table ineuron;

insert into ineuron values(01,'FSDA','Active',100);
insert into ineuron values(02,'FSDS','Not-Active',50);
insert into ineuron values(03,'SDA','Active',60);

select * from ineuron;

create table students_ineuron(
student_id int,
course_name varchar(60),
student_mail varchar(60),
student_status varchar(40),
s_course_id int,
foreign key (s_course_id) references ineuron (course_id) );
desc students_ineuron;

insert into students_ineuron values(101,'FSDA','r@gmail.com','Active',01);
insert into students_ineuron values(102,'FSDA','a@gmail.com','Active',01);
insert into students_ineuron values(103,'FSDA','i@gmail.com','Active',01);
insert into students_ineuron values(104,'FSDA','l@gmail.com','Active',02);
select * from students_ineuron;

create table payment(
course_name varchar(60),
p_course_id int,
course_live_status varchar(60),
course_launch_date varchar(60),
foreign key(p_course_id) references ineuron(course_id));

insert into payment values('FSDA', 1, 'Active','7th Aug');

create table class(
course_id int ,
class_name varchar(60),
class_topic varchar(60),
class_duration int ,
primary key(course_id),
foreign key(course_id) references ineuron(course_id));

alter table ineuron add constraint test_prim primary key(course_id, course_name);