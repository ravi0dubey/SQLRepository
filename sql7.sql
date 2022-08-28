use projectdb;
show tables;
CREATE TABLE `Superstore_USA_Orders` (
	`Row_ID` DECIMAL(38, 0) NOT NULL, 
	`Order_Priority` VARCHAR(13) NOT NULL, 
	`Discount` DECIMAL(38, 2) NOT NULL, 
	`Unit_Price` DECIMAL(38, 2) NOT NULL, 
	`Shipping_Cost` DECIMAL(38, 2) NOT NULL, 
	`Customer_ID` DECIMAL(38, 0) NOT NULL, 
	`Customer_Name` VARCHAR(28) NOT NULL, 
	`Ship_Mode` VARCHAR(14) NOT NULL, 
	`Customer_Segment` VARCHAR(14) NOT NULL, 
	`Product_Category` VARCHAR(15) NOT NULL, 
	`Product_Sub-Category` VARCHAR(30) NOT NULL, 
	`Product_Container` VARCHAR(10) NOT NULL, 
	`Product_Name` VARCHAR(98) NOT NULL, 
	`Product_Base Margin` DECIMAL(38, 2), 
	`Region` VARCHAR(7) NOT NULL, 
	`State_or_Province` VARCHAR(20) NOT NULL, 
	`City` VARCHAR(19) NOT NULL, 
	`Postal_Code` DECIMAL(38, 0) NOT NULL, 
	`Order_Date` VARCHAR(10) NOT NULL, 
	`Ship_Date` VARCHAR(10) NOT NULL, 
	`Profit` DECIMAL(38, 7) NOT NULL, 
	`Quantity_ordered_new` DECIMAL(38, 0) NOT NULL, 
	`Sales` DECIMAL(38, 2) NOT NULL, 
	`Order_ID` DECIMAL(38, 0) NOT NULL
);



SELECT *  FROM superstore_usa_orders;
desc  superstore_usa_orders;
select * from superstore_usa_returns;
select * from superstore_usa_regions;

load data  infile 'D://Study//Data Science//Python//ineuron//Data_Set//FitBit_Data.csv' into table superstore_usa_regions fields terminated by ','  Enclosed by '" "'  IGNORE 1 ROWS;

drop table superstore_usa_orders;
-- To ignore any data issues while load
set session sql_mode =  '' ;
load data  infile 'D://Study//Data Science//Python//ineuron//Data_Set//Superstore_USA_Orders.csv' into table superstore_usa_orders fields terminated by ',' IGNORE 1 ROWS;

select Order_Date, STR_TO_DATE(Order_Date, '%m/%d/%YY') as new_Order_Date,  Ship_Date, STR_TO_DATE(Ship_Date, '%m/%d/%YY') as new_Ship_Date from superstore_usa_orders;

drop table Superstore_USA_Returns;

CREATE TABLE `Superstore_USA_Returns` (
	`Order_ID` DECIMAL(38, 0) NOT NULL, 
	`Status` VARCHAR(8) NOT NULL
);

load data  infile 'D://Study//Data Science//Python//ineuron//Data_Set//Superstore_USA_Returns.csv' into table Superstore_USA_Returns fields terminated by ','   IGNORE 1 ROWS;

select * from superstore_usa_orders so join superstore_usa_returns sr on so.Order_ID = sr.Order_ID;

select Ship_Mode, count(Order_Id) from superstore_usa_orders group by Ship_Mode;

SELECT Ship_Mode, count(Ship_Mode) as count_ship_mode,
round(((count(Order_Id) * 100) / temp.total_count),2) AS Percentage_count
FROM superstore_usa_orders 
JOIN (SELECT count(Order_Id) AS total_count FROM superstore_usa_orders) temp
group by  Ship_Mode;




