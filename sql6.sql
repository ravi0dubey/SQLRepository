
-- Task 1: Create a loop for table to insert a record into a table for two columns in first column value and 
-- Task 2 : create a user defined function to find out a date difference in number or days
-- Task 3: Create a UDF to find out log base 10 of any given number
-- Task 4: create a UDF which will check a total number of records in your table
-- Task 5: create  a procedure to find out second 5th hightes profit in your sales table without using windowing or rank function


use analyticsdb;
show tables;

select * from sales;

-- Create function to get a new status flag to determine the type the sales done
Delimiter //
create function add_sales_count2(sales_count DECIMAL(38,0))
returns VARCHAR(15)
deterministic
begin
	declare sales_status varchar(15);
    if sales_count > 0 and sales_count< 100 then
		set sales_status = "Low Sales";
	elseif sales_count > 100 and sales_count < 300 then
		set sales_status = "Moderate Sales";
	elseif sales_count > 400 and sales_count < 600 then
		set sales_status = "Good Sales";
	else 
		set sales_status = "Excellent Sales";
	End if;
    return sales_status;
end//

-- This will display  a new column sales_status which will hold values returned from function add_sales_count which accepts sales parameters
select order_id,sales, add_sales_count(sales) as sales_status from sales;



-- Create new function to caculate Net_profit
desc sales;

Delimiter //
create function net_profit_1( sales_val decimal(38,0), discount_val decimal(38,3),shipping_cost_val decimal(38,2), profit_val decimal(38,8))
returns decimal(38,8)
begin
	declare total_profit_val decimal(38,8);
    set total_profit_val = 0;
    set total_profit_val = profit_val - shipping_cost_Val - (discount_val * sales_val);
    return total_profit_val;
end//

select order_id, sales, discount,shipping_cost, profit , net_profit_1(sales, discount,shipping_cost, profit) as net_profit from sales;

drop procedure add_net_profit1;
drop procedure add_net_profit2;
drop table net_profit_1;

Procedure
Delimiter //
create procedure add_net_profit19()
begin
	create table net_profit_1 (order_id varchar(15), net_profit_1f decimal(38,8));
    insert into net_profit_1
    select order_id, net_profit_1(sales, discount,shipping_cost, profit)  from sales;

end//

call add_net_profit19();
select * from net_profit_1;
select * from sales;
desc sales;
-- Procedure
Delimiter //
create procedure add_net_profit22()
begin
	-- alter table sales add column (net_profit decimal(38,8));
    insert into sales(net_profit) values(select  b.net_profit_1f  from  net_profit_1 b  , sales a where a.order_id= b.order_id);
    
end//

call add_net_profit2();

insert into sales(net_profit) values(select  b.net_profit_1f  from  net_profit_1 b  , sales a where a.order_id= b.order_id);



insert into sales column(net_profit) 
values(
select n.net_profit_1f
from net_profit_1 n join sales s 
on n.order_id= s.order_id);

select count(*) from sales;

insert into sales column(net_profit) 
values(
select n.net_profit_1f
from net_profit_1 n );

select * from net_profit_1 n ;
delete  from net_profit_1;



Delimiter //
create procedure add_net_profit12()
begin
	-- create table net_profit_1 (order_id varchar(15), net_profit_1f decimal(38,8));
    insert into net_profit_1(order_id)
    select order_id from sales;
end//

call add_net_profit11();


insert into net_profit_1(order_id)
select order_id from sales;
    
insert into sales(net_profit)
select  b.net_profit_1f  
from  net_profit_1 b  , sales a 
where a.order_id= b.order_id;

select net_profit from sales;

insert into sales(net_profit);
select  * 
from  net_profit_1 
order by order_id desc
limit 1  ;

alter table net_profit_1 add column order_id varchar(15);   


create view  view1 as
(
select order_id ,  count(*) from sales
group by order_id
having count(*) > 1);

delete from sales where order_id in (
select order_id from view1);

select distinct net_profit from sales;
where net_profit is not null;


update sales s
set s.net_profit =  (Select n.net_profit_1f   from net_profit_1 n where n.order_id = s.order_id) ;