Create database WalmartSales;
use WalmartSales;

select * from Sales;

----------- feature Engineering ----------------
-- time of day

select  time,
        ( CASE 
		     WHEN 'time' BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			 WHEN 'time' BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
			 ELSE 'Evening'
		END) as time_of_date
from Sales;

SELECT 
    time,
    (CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) as time_of_day
FROM Sales;


-- ALTER TABLE Sales ADD COLUMN time_of_day VARCHAR(20); => works in sql workbench

ALTER TABLE Sales
ADD time_of_day VARCHAR(20);

Update Sales 
set time_of_day = (CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);

-- day_name

-- select date DAYNAME(date) from Sales;

SELECT FORMAT(date, 'dddd') AS day_of_week
FROM Sales;

ALTER TABLE Sales
ADD day_name VARCHAR(20);

Update Sales 
set day_name = (FORMAT(date, 'dddd'));

-- month_name

select date, format(date,'MMMM') as month_name from Sales;

---create another column month_name and update it--
ALTER TABLE Sales 
ADD month_name VARCHAR(20);

Update Sales 
set month_name = (FORMAT(date, 'MMMM'));

-------------------------------------------
-------------------GENERIC-----------------

--How many unique cities does the data have?

select distinct city from Sales order by city;

--How many branch we have ?

select distinct branch from Sales order by branch;

select DISTINCT city, branch from Sales order by city;

----------------PRODUCT--------------------------
-- How many unique product lines does the data have 
select distinct Product_line from Sales;
--OR--
select count(distinct Product_line) from Sales;

--What is the most common payment method?

select Payment,count(payment) as cnt_of_payment_method_used 
from Sales
group by payment order by cnt_of_payment_method_used desc;

-- what is the most selling product line?
select product_line, count(product_line) as count_product_line 
from Sales 
group by Product_line 
order by count_product_line desc;

--what is the totl revenue by month?
select month_name as month , sum(total) as total_revenue from Sales
group by month_name
order by total_revenue DESC;

-- what month had the largest COGS (cost of goods sold)?
select * from Sales;

select month_name as month, round(sum(cogs),2) as cogs 
from Sales
group by month_name 
order by cogs DESC;

-- what product line had the largest revenue?
select * from Sales;

select Product_line, sum(total) as revenue 
from Sales
group by Product_line 
order by revenue DESC;

-- What is the city with the largest revenue?
select city,branch,sum(total) as revenue 
from Sales 
group by city, branch
order by revenue DESC;

-- what is the product line has the largest VAT?
select Product_line, round(AVG(Tax_5),2) as avg_tax from Sales
group by Product_line 
order by avg_tax DESC;

-- which branch sold more products than average product sold??
SELECT 
     branch, sum(quantity) as qty 
from Sales
group by branch
having sum(quantity) > (select avg(quantity) from Sales);

-- what is the most product line by gender?
select Gender,Product_line ,COUNT(Gender) as total_cnt from Sales
group by Gender, Product_line
order by total_cnt DESC;

-- What is the average rating of each product line?
select Product_line, round(AVG(rating),2) as avg_rating 
from Sales
group by Product_line
order by avg_rating desc;

------------------Sales-----------------------------------
-- Number of sales made in each time of the day per weekday
select 
    time_of_day,
	COUNT(*) as total_sales
from Sales
where day_name = 'Monday'
GROUP BY time_of_day
order by total_sales Desc;

-- which of the customer types brings the most revenue?

select Customer_type, round(sum(total),0) as revenue
from Sales 
group by Customer_type
order by revenue desc;

-- Which city has the largest tax percent/ VAT(VALUE Added Tax)?
select city, round(avg(Tax_5),1) as VAT 
from Sales 
Group by city
Order by VAT desc; 

-- which customer type pays the most in VAT?
select Customer_type, round(avg(Tax_5),1) as VAT
from Sales
Group by Customer_type
order by VAT desc;

-- How many unique customer types does the data have?

select distinct Customer_type from Sales;

-- How many unique customer types does the data have?

select Distinct customer_type from Sales;

-- which customer type buys the most?
select Customer_type, COUNT(*) AS cstm_cnt 
from Sales
Group by Customer_type
Order by cstm_cnt desc;

-- What is the gender of most of the customers?
select Gender, COUNT(*) as gender_cnt
from Sales
Group By Gender
Order by gender_cnt desc;

-- What is the gender distribution per branch?
select Branch,Gender, COUNT(Gender) as gender_cnt
from Sales
Group By Branch, Gender
order by gender_cnt desc, Branch;

-- What time of the day do customers give most ratings?
select time_of_day, AVG(Rating) as AVG_ratings from Sales
group by time_of_day 
order by AVG_ratings desc;

-- Which time of the day do customers give most ratings per branch?
select time_of_day, AVG(Rating) as AVG_ratings from Sales
where Branch = 'B'
group by time_of_day
order by AVG_ratings desc;

select time_of_day, AVG(Rating) as AVG_ratings from Sales
where Branch = 'C'
group by time_of_day
order by AVG_ratings desc;

-- Which day of the week has the best avg ratings?
select day_name, AVG(Rating) as avg_ratings from Sales
group by day_name
order by avg_ratings desc;

-- Which day of the week has the best avergae ratings per branch?
select day_name, AVG(Rating) as avg_ratings from Sales
where Branch = 'A'
group by day_name
order by avg_ratings desc;

select day_name, AVG(Rating) as avg_ratings from Sales
where Branch = 'B'
group by day_name
order by avg_ratings desc;

select day_name, AVG(Rating) as avg_ratings from Sales
where Branch = 'C'
group by day_name
order by avg_ratings desc;

-- 












