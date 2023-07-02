-- viewing the table
select * from pizza_sales;

-- Data cleaning of date and time column
-- Time and date does not appear in the right format.
-- let me clean it 

Alter Table pizza_sales
Add order_Timess time;

-- updating the new column
update pizza_sales
set order_Timess = cast(order_time as time);

select * from pizza_sales;

-- extracting only the date

Alter Table pizza_sales
Add order_dates date;

-- updating the date
update pizza_sales
set order_dates = cast(order_date as date);

-- viewing table
select * from pizza_sales;

--Rearranging the Tables, putting the time column in a neat format 
-- Pizza_sales_cleaned table.

select  pizza_id , order_id , 
pizza_name_id , quantity , order_dates,
left(cast (order_Timess as time),8) as order_times, unit_price, 
total_price, pizza_size , pizza_category ,
pizza_ingredients , pizza_name from pizza_sales;

-- Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales
-- in currency format
select format(sum(total_price),'c') as Total_Revenue from pizza_sales;

--Average order value
-- this is given by Total Revenue/Total Number of orders placed

select (sum(total_price)/count(distinct(order_id)))
 as Average_order_value from pizza_sales

  --Total Pizza Sold
 select sum(quantity) as Total_Pizza_sold from pizza_sales;

 
 --Total Order
 select count(distinct(order_id)) as Total_order from pizza_sales;

  -- Average Pizza per order

 select count(quantity)/count(distinct(order_id)) as Average_pizza_Per_Order
 from pizza_sales;

  -- to get the decimals of Average Pizza per order I used this 

 select cast(cast(count(quantity) as decimal(10,2))/cast(count(distinct(order_id))
 as decimal(10,2)) as decimal(10,2)) as Average_pizza_Per_Order from pizza_sales;

  -- orders per weekday (daily trend)

select datename(weekday,order_dates) as order_days, 
count(distinct(order_id)) Total_day_orders from pizza_sales
 group by datename(weekday,order_dates);

  -- Hourly Rate
select DATEPART(HOUR,left(cast (order_Timess as time),8) ) as order_hours,
count(distinct(order_id)) as Total_orders
from pizza_sales
group by DATEPART(HOUR,left(cast (order_Timess as time),8))
order by order_hours;

-- Percentage of Sales by Category

select pizza_category, concat(round((sum(total_price) *100)/
(select sum(total_price)from pizza_sales),2),' %')
as sum_cat from pizza_sales
group by pizza_category;
go
-- Percentage of Sales by size

select pizza_size, concat(round((sum(total_price) *100)/
(select sum(total_price)from pizza_sales),2),' %')
as sum_cat from pizza_sales
group by pizza_size;

-- Total Pizza per category

select pizza_category, sum(quantity) as Total_cat from pizza_sales
group by pizza_category;

-- Top 5 sellers by pizza Name

select top(5) pizza_name, sum(quantity)
 as total_pizza_name from pizza_sales
 group by pizza_name
 order by total_pizza_name desc;

  -- Bottom 5 sellers by pizza_name

 select top(5) pizza_name, sum(quantity)
 as total_pizza_name from pizza_sales
 group by pizza_name
 order by total_pizza_name asc;




