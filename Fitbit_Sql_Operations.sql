use projectdb;
show tables;
select distinct * from projectdb.attributedataset where dress_id in (select  dress_id from projectdb.attributedataset);
select count(*) from projectdb.attributedataset;
(select count(distinct dress_id) from projectdb.attributedataset);
select dress_id, count(*) from projectdb.attributedataset
group by dress_id
having count(*) > 2;

select * from projectdb.dresssale;
select * from projectdb.fitbit_data;
select * from   projectdb.fitbit_data;
load data  infile 'D://Study//Data Science//Python//ineuron//Data_Set//FitBit_Data.csv' into table FitBit_Data fields terminated by ';'  Enclosed by '" "'  IGNORE 1 ROWS;

select id, ActivityDate, STR_TO_DATE(ActivityDate, '%m/%d/%YY%HH%MM%SS') as new_activity_date from fitbit_data;
SELECT distinct(ID) FROM fitbit_data
group by ID
having sum(TotalSteps) > 0;

SELECT id, sum(Calories) FROM fitbit_data
group by ID
order by sum(Calories)



SELECT COUNT(distinct(ID)) FROM fitbit_data
group by ID
having sum(TotalSteps) = 0;

SELECT ID, totalsteps FROM fitbit_data group by ID 
having TotalSteps = 0;

create view if not exists sum_total_steps as
SELECT id, sum(TotalSteps) as total_steps_sum FROM fitbit_data
group by ID
order by sum(TotalSteps) desc ;

drop view sum_total_steps;

select * from sum_total_steps;

select max(total_steps_sum) from sum_total_steps;


SELECT id, sum(TotalSteps) as total_steps_sum FROM fitbit_data
group by ID
order by sum(TotalSteps) desc 
 limit 2,1;
 
 
SELECT id, avg(Calories) 
FROM fitbit_data 
group by ID  having avg(Calories) > 2200
order by sum(Calories);

SELECT id, total_steps_sum FROM sum_total_steps AS sum1   
WHERE 3-1 = (SELECT COUNT(DISTINCT total_steps_sum) FROM sum_total_steps AS sum2   
WHERE sum2.total_steps_sum > sum1.total_steps_sum);  