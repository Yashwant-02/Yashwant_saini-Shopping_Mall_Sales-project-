SELECT * FROM sales_database.sales_dataset;


# what percentage of total orders were shipped on same date?
select count(*) as TotalOrders,
sum(case when Ship_Date=Order_Date then 1 else 0 end) as SameShippedOrders,
(sum(case when Ship_Date=Order_Date then 1 else 0 end)/count(*))*100 as PercentageOfTotalOrders
from sales_dataset;

# Name top 3 customers with highest total quantities of orders

select Customer_Name as Top3_Customers, count(*) as Total_Orders
from sales_dataset
group by Customer_Name
order by Total_Orders desc
limit 3;

# Find the top 5 items/Products with highest average sales

select Product_Name as Top5_items, round(avg(Sales),2) as average_sales
from sales_dataset
group by Product_Name
order by average_sales desc
limit 5;

# find the average order value for each customer, and rank the customer by there average order value.

select Customer_Name, avg_sales,
		Rank() Over (order by avg_sales desc) as Customer_Rank
from (select Customer_Name,
			round(avg(Sales),2)as avg_sales
			from sales_dataset
			group by Customer_Name) as Subquery;
            
            
# Most demand sub-category in overall dataset?
select Sub_Category, sum(Quantity) as Total_Quantity
from sales_dataset
group by Sub_Category
order by Total_Quantity desc;

# Most demand sub-category in east region?
select Sub_Category, sum(Quantity) as Total_Quantity
from sales_dataset
where Region = "East"
group by Sub_Category
order by Total_Quantity desc;

# which order has highest numbers of items?
select * from sales_dataset
where Quantity = (select max(Quantity) from sales_dataset)
limit 1;

# which order segment order is more likely to be shipped via first class.
select Segment, count(*) as total_segment from sales_dataset
where Ship_mode = "First class"
group by Segment
order by total_segment desc;

# which order has the highest cumulative value.
select Order_Id, sum(Sales) as total_sales
from sales_dataset
group by Order_ID
order by total_sales desc;



# Top Customers by Sales and Profit
select Customer_ID, Customer_Name,
sum(Sales) as TotalSales,
sum(profit) as TotalProfit
from sales_dataset
group by Customer_ID, Customer_Name
order by TotalProfit Desc;

# Average Profit Margin per Product Categories
select Category, round(avg(Profit/Sales)*100,2) as Avg_Profit_Margin
from sales_dataset
group by Category
order by Avg_Profit_Margin desc;

# Regional Sales Distribution
select Region,
sum(Sales) as TotalSales
from sales_dataset
group by Region
order by TotalSales;
# Impact of Discounts on Profit => orders with high discount and low profit
select * from sales_dataset
where Discount = (select max(Discount) from sales_dataset);

# Customer Segment Performance by Sales
select Segment,
sum(Sales) as TotalSales
from sales_dataset
group by Segment
order by TotalSales desc;

# Customer Segment Performance by Profit
select Segment,
sum(Profit) as TotalProfit
from sales_dataset
group by Segment
order by TotalProfit desc;

# Monthly Sales Trends
select month(Order_Date) as `Month`,
round(sum(Sales),2 )as TotalSales
from sales_dataset
group by `Month`
order by `Month` ;

# Top Cities by Profit
select City,
sum(Profit) AS TotalProfit
from sales_dataset
group by City
order by TotalProfit desc;

# Average Shipping Time
select Ship_Mode,
round(avg(datediff(Ship_Date,Order_Date)),0) as Avg_Ship_Days
from sales_dataset
group by Ship_Mode
order by Avg_Ship_Days; 

# Low Profit Margin Products
select Product_Name,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit,
(sum(Sales)/sum(Profit))*100 aS Profit_Margin
from sales_dataset
group by Product_Name
order by Profit_Margin
limit 10;
