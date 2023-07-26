## INTRODUCTION

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/introduction.png)

This is a data analytics project on a pizza sales data set using SQL and Tableau. 

## THE TASK 

A Pizza shop owner in the United states wants to see how sales have been moving so far throughout the year in all his outlets within the United States. so he contracted a data analyst (I) to clean, analyse and visualize the data so he can know which products that are doing well and those that aren't so he can easily make decisions.

## TASK WITH SQL

### VIEWING THE DATA

`select * from pizza_sales;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/first_view_time.png)

## DATA CLEANING
When I viewed the dataset, I found out that the date column and time column are not in the right format. The time column had the Year 1899 in it and the date column had a lot of zeros behind it. so I need to get them cleaned by creating a new column and update it with them with the clean time and date.

### GETTING A CLEAN TIME
* creating time column, updating it an viewing to see changess

`Alter Table pizza_sales`
   `Add order_Timess time;`

* updating the time column

`update pizza_sales`
`set order_Timess = cast(order_time as time);`

* viewing for the new column

`select * from pizza_sales;`

| Adding Order_Timess                   |     updating the column                            |   Viewing the new Table                    |
| ------------------------------------ |--------------------------------------------------- | ------------------------------------------ |
|     ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Alter%20table%20adding%20time%20column.png)                     |         ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Updating%20the%20new%20column%20with%20time%20only.png)                              |         ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/first_view_time.png)                      |

*NB* _**please don't worry about the zeros behind the time I will clean them at the final state of my cleaning which is the rearranging stage**_

### GETTING A CLEAN DATE

* Creating the new date column

`Alter Table pizza_sales`
`Add order_dates date;`

* Updating the new column with date

`update pizza_sales`
`set order_dates = cast(order_date as date);`

* Viewing table for new date column
`select * from pizza_sales;`

| Adding Order_dates                    |     updating the column                            |   Viewing the new Table                    |
| ------------------------------------ |--------------------------------------------------- | ------------------------------------------ |
|     ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Creating%20new%20column%20Date.png)                     |         ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/updating%20the%20date%20column%20with%20only%20date.png)                              |         ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/viewing%20updated%20date%20column.png)                      |


### REARRANGING THE TABLE TO A NEAT FORMAT

`select  pizza_id , order_id ,`
`pizza_name_id , quantity , order_dates,`
`left(cast (order_Timess as time),8) as order_times, unit_price,`
`total_price, pizza_size , pizza_category ,`
`pizza_ingredients , pizza_name from pizza_sales;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Rearranging%20the%20table%20and%20making%20the%20time%20format%20appear%20nice.png)

## TOTAL REVENUE

In calculating the Total Revenue I used two methods. 

**Calculating without the currency format.**

`select sum(total_price) as Total_Revenue from pizza_sales`

**Calculatiing with the currency format.**

`select format(sum(total_price),'c') as Total_Revenue from pizza_sales;`

![Alt Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Total%20Revenue.png)

**NB** _**Please, when doing calculation that involve ordering numerical values, do not use the currency format because, it sometimes don't order the values properly**_

## AVERAGE ORDER VALUE

* total price/total orders

`select (sum(total_price)/count(distinct(order_id)))`
 `as Average_order_value from pizza_sales`

 ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Average%20Order%20value.png) 

## TOTAL PIZZA SOLD

`select sum(quantity) as Total_Pizza_sold from pizza_sales;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Total%20Pizza%20sold.png) 

## TOTAL ORDERS


 `select count(distinct(order_id)) as Total_order from pizza_sales;`

 ![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Total_orders.png) 


## AVERAGE PIZZA PER ORDER

* Total quantity/Total orders

**without the decimal part**

 `select count(quantity)/count(distinct(order_id)) as Average_pizza_Per_Order`
 `from pizza_sales;`

**with the decimal part**


 `select cast(cast(count(quantity) as decimal(10,2))/cast(count(distinct(order_id))`
 `as decimal(10,2)) as decimal(10,2)) as Average_pizza_Per_Order from pizza_sales;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Average%20pizza%20per%20order.png)                      |

## SALES PER WEEKDAY


`select datename(weekday,order_dates) as order_days,`
`count(distinct(order_id)) Total_day_orders from pizza_sales`
 `group by datename(weekday,order_dates);`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/orders%20per%20weekday.png)

## ORDER PER HOUR


`select DATEPART(HOUR,left(cast (order_Timess as time),8) ) as order_hours,`
`count(distinct(order_id)) as Total_orders`
`from pizza_sales`
`group by DATEPART(HOUR,left(cast (order_Timess as time),8))`
`order by order_hours;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/orders%20per%20hour.png)

## PERCENTAGE SALES PER CATEGORY

`select pizza_category, concat(round((sum(total_price) *100)/`
`(select sum(total_price)from pizza_sales),2),' %')`
`as sum_cat from pizza_sales`
`group by pizza_category;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Propotion%20per%20pizza%20category.png)

## PERCENTAGE SALES PER PIZZA SIZE


`select pizza_size, concat(round((sum(total_price) *100)/`
`(select sum(total_price)from pizza_sales),2),' %')`
`as sum_cat from pizza_sales`
`group by pizza_size;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Propotion%20per%20size.png)

## TOTAL PIZZA PER CATEGORY


`select pizza_category, sum(quantity) as Total_cat from pizza_sales`  
`group by pizza_category;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Total%20Pizza%20per%20category.png)

## TOP SELLING PRODUCTS

`select top(5) pizza_name, sum(quantity)`
 `as total_pizza_name from pizza_sales`
 `group by pizza_name`
 `order by total_pizza_name desc;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/top%205%20sellers.png)

## BOTTOM SELLING PRODUCTS

`select top(5) pizza_name, sum(quantity)`
 `as total_pizza_name from pizza_sales`
 `group by pizza_name`
 `order by total_pizza_name asc;`

![Alt_Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Bottom%20sellers.png)




## THE DASHBOARD


![Alt Text](https://github.com/Mario-Gozie/Pizza-sales-Data-Analysis/blob/main/Images/Dashboard%20.png)


To View the dashboard on Tableau public, please use this [Link](https://public.tableau.com/app/profile/chigozirim.nwasinachi.oguedoihu/viz/AYearBusinessDashboard/Dashboard)


## GENERAL INSIGHTS

* 