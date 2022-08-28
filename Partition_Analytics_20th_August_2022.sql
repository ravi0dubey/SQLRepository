use analyticsdb;

# PARTITION

create table ineuron_course(
course_name varchar(50),
course_id int(10),
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int
);

select * from analyticsdb.ineuron_course;

insert into ineuron_course values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019);
delete from ineuron_course;

insert into ineuron_course values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019),
								 ('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

;

select * from ineuron_course where course_launch_year = 2020;

drop table ineuron_course1;

create table ineuron_course1(
course_name varchar(50),
course_id int,
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int
) partition by	range (course_launch_year)
( partition p0 values less than (2019),
  partition p1 values less than (2020),
  partition p2 values less than (2021),
  partition p3 values less than (2022),
  partition p4 values less than (2023)
)
;

insert into ineuron_course1 values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019),
								 ('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

;

select * from ineuron_course1 where course_launch_year = 2020;

select partition_name, table_name, table_rows from information_schema.partitions ;
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course1';

-- dropping a partition
alter table ineuron_course1 drop partition P0;
-- Adding a partition
ALTER TABLE ineuron_course1 ADD PARTITION (PARTITION p0 VALUES LESS THAN (2019));

#Partition by Hash

create table ineuron_course2(
course_name varchar(50),
course_id int,
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int
) 
partition by	hash(course_launch_year)
partitions 5
;

select partition_name, table_name, table_rows from information_schema.partitions ;	

#Partition by Key

create table ineuron_course3(
course_name varchar(50),
course_id int primary key,
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int
) 
partition by	key()
partitions 10
;

insert into ineuron_course3 values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019),
								 ('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

;

select partition_name, table_name, table_rows from information_schema.partitions  where table_name = 'ineuron_course3'; 

-- keys are stored using MD5 hashing algorithm'
select MD5(101);
select MD5(102);
select MD5(103);
select MD5(104);
select MD5(105);
select MD5(106);

#Partition by multiple primary Key
drop table ineuron_course4;
create table ineuron_course4(
course_name varchar(50) not null,
course_id int not null,
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int,
primary key(course_id, course_name)
) 
partition by	key()
partitions 10
;
desc ineuron_course4;

insert into ineuron_course4 values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019),
								 ('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 
;

select partition_name, table_name, table_rows from information_schema.partitions  where table_name = 'ineuron_course4'; 

#Partion by List giving error list partition can only store integer

-- drop table ineuron_course5;
-- create table ineuron_course5(
-- course_name varchar(50) not null,
-- course_id int not null,
-- course_title varchar(60),
-- course_desc varchar(60),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int,
-- primary key(course_id, course_name)
-- ) 
-- partition by list(course_name)
-- (
-- partition p0 values in ('aiops','fsds','java'),
-- partition p1 values in ('fabe','MERN','DL','dlcvnlp'),
-- partition p2 values in('interview prep','big data','D1','data analytics')
-- )
-- ;

#Partion by List 
create table ineuron_course5(
course_name varchar(50) not null,
course_id int not null,
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int
-- primary key(course_name, course_id)
)
partition by list(course_launch_year)
 
(
partition p0 values in (2019,2020),
partition p1 values in (2030,2040),
partition p2 values in(2060,2070)
)
;

-- IN case we try to add values into table where partition values are not defined then it will give error
-- so we should give insert ignore clause to ignore records which has course_launch year which is not part of partition

insert ignore into ineuron_course5 values('Machine learning',101,'ML','This is ML course','2019-07-07',3450,'Sudhanshu',2019),
								 ('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 
;