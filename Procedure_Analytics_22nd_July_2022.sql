use ravibank;

SHOW TABLES;
SHOW VARIABLES LIKE "secure_file_priv"; 


load data  local infile 'D://Study//Data Science//Python//ineuron//bank1.csv' into table bank_details4
fields terminated by ';'  Enclosed by '"' Terminated by '\n'  IGNORE 1 ROWS;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\bank.csv' into table bank_details4
fields terminated by ';'  Enclosed by '"' Terminated by '\n'  IGNORE 1 ROWS;



load data  infile 'D://bank2.csv' into table bank_details4
fields terminated by ';'  Enclosed by '"'  IGNORE 1 ROWS;

desc bank_Details4;
select count(*) from bank_Details4;
delete from bank_Details4;

select marital, education,max(Age), sum(balance), count(housing) from bank_details4 group by marital, education;

select education, char_length(education), balance, length(Balance) from bank_details4;
select * from bank_Details  where job  like 'a%m_%_';
update bank_details set job=  'ammin.' where age = 29;

select count(*)  from bank_Details4;

#Task 1: Try to find out average of Balance
select avg(balance) from bank_Details4;

#Task 2: Try to find who has mininum Balance
select * from bank_Details4 where balance = (select min(balance) from bank_Details4);
#alternate way provided we have only 1 person with minimum balance
select * from bank_details4
order by balance 
limit 1;


#Task 3: Try to find who is has maximum balance
select * from bank_Details4 where balance = (select max(balance) from bank_Details4);
 #other way provided we have only 1 person with maximum balance
select * from bank_details4
order by balance desc
limit 1;

#Task 4: Try to prepare a lit of all the person who is having a loan
select * from bank_Details4 where upper(loan) = upper('yes');

#Task 5 : try to find out average balance for all the people whose job  role is admin
select avg(balance) from bank_details4 where job = 'admin.';

#Task 6: Try to find out a record without job whose age is below 45
select * from bank_details4 where age < 45 and upper(job) = upper('unknown');

#Task 7: Try to find out a record where education is primary and person is jobless;
select * from bank_details4 where upper(education) = upper('primary') and upper(job) = upper('unemployed');

#Task 8: Try to find out a record whose bank account is having a negative balance;
select * from bank_details where  balance < 0;


#Task 9 : Try to find out a record who is not having house at all despite, 
select age, balance,housing  from bank_details where upper(housing) = upper('no');


#Procedure
DELIMITER //
create procedure get_bank_details_bal()
begin
select * from bank_details4 where  balance < 0;
End //

call get_bank_details_bal();

drop procedure IF EXISTS  get_bank_details();


#Procedure to get details based on job
DELIMITER //
create procedure get_details_job(in job_name varchar(30))
begin
select * from bank_details4 where  job = job_name;
End //


#Procedure to get details based on job
DELIMITER //
create procedure get_details_job1(in job_name varchar(30))
begin
if job_name = ' '
	then 
		select * from bank_details4 where  job = 'unknown';
	else	
		select * from bank_details4 where  job = job_name;
	end if;
End //

drop procedure get_details_job1;

procedure based on Education and Jobtype
Delimiter $$
create procedure get_education_job(in education1 varchar(30), in job1 varchar(30))
begin
select * from bank_details4 where upper(education) = upper(education1) and upper(job) = upper(job1);
end $$

drop procedure get_education_job;


use ravibank;
call select_min_balance();
call get_details_job('technician');
select * from bank_Details4;
call get_details_job1('technician');
call get_details_job1(' ');

call get_education_job('primary', 'unemployed');


#need to check
-- delimiter $$
-- create definer ='root'@'localhost' procedure 'avg_bal_jobrole(in education1 varchar(30), in job1 varchar(30))'
-- begin
-- select * from bank_details4 where upper(education) = upper(education1) and upper(job) = upper(job1);
-- end

-- Views 

use ravibank;
select * from bank_details;

create view bank_view3 as
select age, job, marital,education,balance,loan from bank_details4 where  job = 'unknown';

select * from bank_view3;
select * from ravibank.bank_view3 where age < 45 and upper(job) = upper('unknown');


