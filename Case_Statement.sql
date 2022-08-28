select * from ineuron_Students;

select *,
case
	when student_batch = 'fsda' then "Data Analytics"
    when student_batch =' FSDS' then "Datascience"
    else "Non-DataScience"
end as statement,
case
	when student_stream = 'cs' then "Computer Science"
    when student_stream = 'ECE' then "Electronics"
    when student_stream = 'me' then "Mechanical Engineering"
    when student_stream = 'ee' then "Electronics Engineering"
    ELSE "Non Computers"
end as student_stream_importance
from ineuron_Students;


update ineuron_Students 
set  student_mail_id =
case
when student_stream = 'cs' then 'computers@gmail.com'
when student_stream = 'CI' then 'ComputersInfotech@gmail.com'
else student_mail_id
end;

select * from ineuron_Students;


update ineuron_students
set student_mail_id = 'raja@gmail.com';