--Data Exploration Project by ABHINAV WADHWA

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers' 

--Dimension Exploration

SELECT DISTINCT country FROM dbo.[gold.dim_customers]

SELECT DISTINCT category, subcategory, product_name FROM dbo.[gold.dim_products]

--Dates Exploration

SELECT ORDER_DATE FROM dbo.[gold.fact_sales];

--How many years and months of sale is available

SELECT MIN (ORDER_DATE) AS first_order_date,
MAX (ORDER_DATE) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM dbo.[gold.fact_sales];

--youngest and oldest customers

SELECT
MIN (birthdate) AS oldest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX (birthdate) AS youngest_birthdate,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM dbo.[gold.dim_customers];


--Measures Exploration
--total Sales, Sold Items, AVG Selling Price and No of Orders
SELECT 
SUM(sales_amount) AS Total_Sales, 
SUM(quantity) AS Total_Quantity, 
AVG(price) AS Avg_Price,
COUNT(DISTINCT order_number) AS Total_Orders 
FROM [gold.fact_sales]

--total number of products
SELECT COUNT(product_key) AS Total_Products FROM [gold.dim_products]
SELECT COUNT(DISTINCT product_key) AS Total_Products FROM [gold.dim_products]

--total number of customers
SELECT COUNT(DISTINCT customer_key) AS Total_Customers FROM [gold.dim_customers];

--total number of customers who have placed an order
SELECT COUNT(DISTINCT customer_key) as Total_Customers_Who_placed_orders FROM [gold.fact_sales];
--The count is same for both This means all our customers placed an order



--Report showing key metrics
SELECT 'Total Sales' AS Metric, SUM(sales_amount) AS Value FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM [gold.fact_sales]
UNION ALL
SELECT 'Average Price', AVG(Price) FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_key) FROM [gold.dim_products]
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_key) FROM [gold.dim_customers]


--Magnitude Analysis
 --total customers by country
 SELECT 
 country,
 COUNT (customer_key) AS Total_Customers
 FROM [gold.dim_customers]
 GROUP BY country
 ORDER BY Total_Customers DESC

 --customers by gender
  SELECT 
 gender,
 COUNT (customer_key) AS Total_Customers
 FROM [gold.dim_customers]
 GROUP BY gender
 ORDER BY Total_Customers DESC

 --total products by category
 SELECT
 category,
 COUNT (Product_key) AS Total_Products
 FROM [gold.dim_products]
 GROUP BY category
 ORDER BY Total_Products DESC

 --average cost in each category
 SELECT 
 category,
 AVG(cost) AS Average_Cost
 FROM [gold.dim_products]
 GROUP BY category
 ORDER BY Average_Cost DESC

 --total revenue for each category
 SELECT 
 p.category,
 SUM(f.sales_amount) Total_Revenue
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_products] p
 ON p.product_key = f.product_key
 GROUP BY p.category
 ORDER BY Total_Revenue DESC

 --total revenue by each customer
 SELECT 
 c.customer_key,
 c.first_name,
 c.last_name,
 SUM(f.sales_amount) AS Total_Revenue
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_customers] c
 ON c.customer_key = f.customer_key
 GROUP BY
 c.customer_key,
 c.first_name,
 c.last_name
 ORDER BY Total_Revenue DESC

 --distribution of sold items across countries
 SELECT 
 c.country,
 SUM(f.quantity) AS Total_items_sold
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_customers] c
 ON c.customer_key = f.customer_key
 GROUP BY
 c.country
 ORDER BY Total_items_sold DESC


 --Ranking Analysis
 --top 5 products
 SELECT TOP 5
 p.product_name,
 SUM(f.sales_amount) AS Total_Revenue
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_products] p
 ON p.product_key = f.product_key
 GROUP BY p.product_name
 ORDER BY Total_Revenue DESC

 --5 worst performing products
  SELECT TOP 5
 p.product_name,
 SUM(f.sales_amount) AS Total_Revenue
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_products] p
 ON p.product_key = f.product_key
 GROUP BY p.product_name
 ORDER BY Total_Revenue

 --Top 10 Customers who generated highest revenue
 SELECT TOP 10
 c.customer_key,
 c.first_name,
 c.last_name,
 SUM(f.sales_amount) AS Total_Revenue
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_customers] c
 ON c.customer_key = f.customer_key
 GROUP BY
 c.customer_key,
 c.first_name,
 c.last_name
 ORDER BY Total_Revenue DESC

 --3 customers with fewest orders
 SELECT TOP 3
 c.customer_key,
 c.first_name,
 c.last_name,
 COUNT(DISTINCT order_number) AS Total_Orders
 FROM [gold.fact_sales] f
 LEFT JOIN [gold.dim_customers] c
 ON c.customer_key = f.customer_key
 GROUP BY
 c.customer_key,
 c.first_name,
 c.last_name
 ORDER BY Total_Orders