use analyticsdb;
show tables;

create table ineuron_students(
student_id int,
student_batch varchar(40),
student_name varchar(40),
student_stream varchar(30),
student_marks int,
student_mail_id varchar(50)
);

desc ineuron_students;
insert into ineuron_students values(101,'FSDA','Ravi', 'CS',500,'r@gmail.com');
insert into ineuron_students values(102,'FSDA','ASTHA', 'CS',501,'A@gmail.com');
insert into ineuron_students values(103,'FSDA','LIKA', 'CS',502,'L@gmail.com');
insert into ineuron_students values(104,'FSDA','ILLISHA', 'EE',503,'I@gmail.com');
insert into ineuron_students values(105,'FSDS','RANJAN', 'EE',504,'ra@gmail.com');
insert into ineuron_students values(106,'FSDS','TRIVEDI', 'EE',505,'TI@gmail.com');
insert into ineuron_students values(107,'FSDS','IDubey', 'EE',506,'ID@gmail.com');
insert into ineuron_students values(108,'FSDS','LDUBEY', 'EL',507,'LDr@gmail.com');

insert into ineuron_students values(109,'DA','KUMAR', 'EL',508,'K@gmail.com');
insert into ineuron_students values(110,'DA','RANJANDUBEY', 'IT',509,'RRDr@gmail.com');
insert into ineuron_students values(111,'DA','Ravi2', 'IT',510,'r2@gmail.com');
insert into ineuron_students values(112,'DA','Ravi3', 'IT',520,'r3@gmail.com');
insert into ineuron_students values(113,'NLP','Ravi4', 'IT',530,'r4@gmail.com');
insert into ineuron_students values(114,'NLP','Ravi5', 'IT',540,'r5@gmail.com');
insert into ineuron_students values(115,'NLP','Ravi6', 'CS',550,'r6@gmail.com');
insert into ineuron_students values(116,'NLP','ASTHA1', 'CS',560,'a1@gmail.com');
insert into ineuron_students values(117,'ML','ASTHA2', 'EE',570,'a2@gmail.com');
insert into ineuron_students values(118,'ML','ILLISHA2', 'EE',580,'i2@gmail.com');
insert into ineuron_students values(119,'ML','ILLISHA3', 'EL',590,'i3@gmail.com');

insert into ineuron_students values(120,'ML','LIKA4', 'EL',600,'l4@gmail.com');


delete  from ineuron_students;

-- Aggregate based group function

select student_batch,sum(student_marks) from ineuron_students
group by student_batch;

select student_batch,min(student_marks) from ineuron_students 
group by student_batch;

select student_batch,count(student_marks) from ineuron_students 
group by student_batch;

select student_batch,count(*) from ineuron_students 
group by student_batch;

-- Analytical based window function
select * from ineuron_students;

drop view ineuron_student_view;
create view ineuron_student_view as
select student_batch, max(student_marks) as marks_max from ineuron_students
group by student_batch;

select * from ineuron_student_View;

select * from ineuron_students as s1 join ineuron_student_view sv
on s1.student_batch = sv.student_batch
where s1.student_marks= sv.marks_max;


-- Analytical based window function
select * from ineuron_students;

select row from ineuron_students;

select student_id, student_batch, student_stream,student_marks,student_mail_id ,
row_number() over(order by student_marks) as 'row_number'
from ineuron_students;


#get me topper of all batch
select * from 	
(select student_id, student_batch, student_stream,student_marks,student_mail_id , row_number() over(partition by student_batch order by student_marks desc) as 'row_num'
from ineuron_students) as test_sql
where row_num = 1;

#rank fuction

select student_id, student_batch, student_stream,student_marks,student_mail_id , 
rank() over(order by student_marks desc) as 'row_rank'
from ineuron_students

select * from 	
(select student_id, student_batch, student_stream,student_marks,student_mail_id , rank() over(order by student_marks desc) as 'row_rank'
from ineuron_students) as test_sql
where row_rank = 1;