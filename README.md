# Sales Data Exploration – SQL Project
## Introduction

This project is a Sales Data Exploration exercise performed entirely in SQL, using a sample retail dataset. It focuses on exploring customer, product, and sales data to uncover key metrics, trends, and business insights.

### The queries were designed to:

- Understand database schema and relationships
- Explore dimensions (customers, products)
- Analyse order timelines and sales ranges
- Calculate KPIs and segment data (countries, genders, top customers/products)

<img src="outputs/key_metrics.png" alt="Key Metrics" width="600">

## About the Data

### The dataset simulates a retail business scenario and contains the following tables:

- dim_customers – Customer demographics (first name, last name, gender, country, birthdate)
- dim_products – Product details (category, subcategory, product name, cost, price)
- fact_sales – Sales transactions (order number, order date, quantity, sales amount)
Note: The data is sample/anonymized and created for learning purposes.

## Project Walkthrough
### 1. Understanding the Schema

Queries to explore tables and columns using INFORMATION_SCHEMA and verify field details.


### 2. Key Metrics & Business Snapshot

Calculated total sales, orders, customers, products, and average price using aggregation functions.

<img src="https://imgur.com/4UpachU.png" alt="Key Metrics" width="600">

### 3. Sales Timeline

Found first and last order dates and calculated the span of sales activity in months and years.

<img src="outputs/sales_timeline.png" alt="Sales Timeline" width="600">

### 4. Product & Customer Insights

- Top 5 best-selling products

- 5 least-performing products

- Customer distribution by country and gender

<img src="outputs/top_products.png" alt="Top Products" width="600"> <img src="outputs/customers_by_country.png" alt="Customers by Country" width="600">

### 5. High-Value Customers

- Identified top 10 customers by total revenue and those with fewest orders.

<img src="outputs/top_customers.png" alt="Top Customers" width="600">

## Tools Used

- SQL Server
- GitHub for documentation and version control



## About

This project was created by Abhinav Wadhwa as part of portfolio development to practice and demonstrate SQL skills in data exploration and business analytics.
Contact: abhinavwadhwa1404@gmail.com
