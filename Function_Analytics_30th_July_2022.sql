use analyticsdb;
show tables;
drop table sales;

-- To create sql structure by running below script
-- csvsql --dialect mysql --snifflimit 100000 sales_data_final.csv > output_sales.sql

CREATE TABLE sales (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);
desc sales;

-- To ignore any data issues while load
set session sql_mode =  '' ;

load data  infile 'D://Study//Data Science//Python//ineuron//Data_Set//sales_data_final.csv' 
into table sales
fields terminated by ','  Enclosed by '"'  IGNORE 1 ROWS;
-- delete from sales;
select count(*) from sales;
select * from sales;
select * from sales_data_final;
select str_to_date(order_date,'%m/%d/%y') from sales;

alter table sales add column  order_date_new date after order_date;

update sales
set order_date_new = str_to_date(order_date,'%m/%d/%Y') ;

set session sql_mode =  'modes' ;

alter table sales 
add column ship_date_new date after ship_date;

update sales
set ship_date_new = str_to_date(ship_date,'%m/%d/%Y') ;

select * from sales where ship_date_new='2011-01-05';
select * from sales where ship_date_new > '2011-01-05';

-- #fetch sales record between 4 and 5
select * from sales
where month(ship_date_new) between 4 and 5;


select current_time();
#current date and time;
select now();
select current_timestamp();

-- #it will minus 1 week from current date and will give date
select date_sub(now(), interval 1 week);

select date_sub(now(), interval 30 day);

-- it will give day name
select dayname(now());
select dayname('2021-08-19');
select dayname('2022-08-19');
select dayname('2022-11-28');
select dayname('2022-12-04');

--  it will give day number
select day('2022-12-04');



-- #it will minus 1 week from current date and will give date
select * from sales where ship_date_new <  date_sub(now(), interval 1 week);

 
alter table sales 
add column flag_date date after order_id;


update sales
set flag_date = now() ;

select * from sales;

alter table sales
modify column year date;

desc sales;


alter table sales add column Year_New int after order_id;

alter table sales add column  Month_New int after Year_New;
alter table sales add column Day_New int after Month_New;

update sales
set Year_New = year(order_date_new) ;

update sales
set Month_New = month(order_date_new) ;

update sales
set Day_New = day(order_date_new) ;

-- average sales

select year_new, avg(sales) from sales
group by year_new;

select year_new, sum(sales) from sales
group by year_new;

select year_new,sum(quantity) from sales 
group by year_new;


select sales, discount, (discount * sales) as discount_amount, shipping_cost, ((discount * sales) +  shipping_cost) as CTC
from sales;

update sales
SET discount_Flag = IF(DISCOUNT > 0,'Yes','No') ;

select * from  sales;


alter table sales add column discount_flag varchar(5) after Discount;

SELECT ORDER_ID, DISCOUNT, IF(DISCOUNT > 0,'Yes','No') as Discount_Flag from Sales;

select count(product_id)
where discount_Flag = 'Yes';

select discount_flag, count(*) from sales
group by discount_flag;

create table online_retail (InvoiceNo int, StockCode varchar(10), Description varchar(10), Quantity int, InvoiceDate varchar(15), UnitPrice decimal(6,2), CustomerID varchar(7), Country Varchar(15));

Load data infile "D://Study//Data Science//Python//ineuron//Data_Set//Online_Retail.csv"  
into table online_retail
fields terminated by ','  Enclosed by '"'  IGNORE 1 ROWS;

select * from online_retail
where invoiceno > 0;


delete from online_retail;
--  200mb of data 200* 1048576
set global max_allowed_packet = 209715200;

-- create function add_to_col

DELIMITER $$
create function add_to_col(a INT)
returns INT
DETERMINISTIC
BEGIN
	DECLARE b int;
    set b = a + 10;
    return b;
end $$

drop function add_to_col;
select add_to_col(15);

select * from sales;

select quantity, add_to_col(quantity) from sales;


DELIMITER $$
create function add_to_col3(a INT)
returns INT 
DETERMINISTIC
BEGIN 
	DECLARE b int ;
	set b = a + 10 ;
	return b ;
end $$


select quantity , add_to_col(quantity) from sales;

DELIMITER //
create function final_profit_real1(profit decimal(20,6), discount decimal(20,6),sales decimal(20,6))
returns decimal(5,2)
DETERMINISTIC
BEGIN
	Declare  disc_value decimal;
    set disc_value = 100 * discount;
	return profit - sales - disc_value;
end//

select * from sales;

select order_id, profit, discount, sales, final_profit_real(profit,discount,sales) as final_profit1 from sales;


delimter //
create function integer_to_string(integer1 int)
returns varchar(30)
deterministic
begin
	declare string1 varchar(30);
    set string1 = integer1;
	return string1;
end //


select max(sales), min(sales) from sales;
1- 100 - Super Affordable
100-300 - Affordable
300-600 - Moderatedly priced
> 600 - Expensive


DELIMITER $$
create function add_to_col3(a INT)
returns INT 
DETERMINISTIC
BEGIN 
	DECLARE b int ;
	set b = a + 10 ;
	return b ;
end $$

select * from sales;

DELIMTER $$
CREATE FUNCTION MARK_SALES1(sales_value INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE SALES_FLAG VARCHAR(30);
    IF SALES_VALUE < 100 THEN
		SET SALES_FLAG = `Super Afforadable`;
	ELSEIF SALES_VALUE > 100 AND SALES_VALUE <= 300 THEN
    	SET SALES_FLAG = "Afforadable";  
	ELSEIF SALES_VALUE > 300 AND SALES_VALUE <= 600 THEN
    	SET SALES_FLAG = "Moderatedly Priced";   
	ELSE  
    	SET SALES_FLAG = "Expensive";          
	END IF;
    RETURN SALES_FLAG;
END $$212215
select * from sales;

set @var = 10;
generate_data : loop
set @var= @var + 1;
if @var = 100 then
	leave generate_data;
end if;
end loop generate_data;


create table loop_table(val int)

Delimiter $$
create procedure insert_data()
Begin
set @var  = 10 ;
generate_data : loop
insert into loop_table values (@var);
set @var = @var + 1  ;
if @var  = 100 then 
	leave generate_data;
end if ;
end loop generate_data;
End $$

select * from loop_table;
call insert_data();
select * from loop_table;

Delimiter $$
create procedure insert_data_div1()
Begin
set @var  = 10 ;
generate_data : loop
if @var %3 = 0 then 
	insert into loop_table values (@var);
	set @var = @var + 1  ;
end if ;
if @var  >= 100 then 
	leave generate_data;
end if ;
end loop generate_data;
End $$

delete from loop_table;
call insert_data_div();


-- Task 1: Create a loop for table to insert a record into a table for two columns in first column value and 
-- Task 2 : create a user defined function to find out a date difference in number or days
-- Task 3: Create a UDF to find out log base 10 of any given number
-- Task 4: create a UDF which will check a total number of records in your table
-- Task 5: create  a procedure to find out second 5th hightes profit in your sales table without using windowing or rank function