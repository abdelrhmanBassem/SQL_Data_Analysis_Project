/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

--find total sales
SELECT 
SUM(sales_amount) as total_sales
FROM Gold.fact_sales
--find how many items are sold
SELECT 
SUM(quantity) total_quantatity
FROM Gold.fact_sales
--find avarage selling price
SELECT 
AVG(price) avarage_price
FROM Gold.fact_sales
-- find total numbers of orders
SELECT 
COUNT( DISTINCT order_name) AS total_order
FROM Gold.fact_sales
--find total number of products
SELECT 
COUNT(product_number) total_product
FROM Gold.dim_products
--find total number of customers
SELECT 
COUNT(customer_number) total_customer
FROM Gold.dim_customer
--find total customer placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customer
FROM Gold.fact_sales
--Generate report 
SELECT 
SUM(sales_amount) as total_sales
FROM Gold.fact_sales
SELECT 'Total Sales' AS measure_name ,SUM(sales_amount) as total_sales FROM Gold.fact_sales
UNION ALL 
SELECT 'Total Quantatity',SUM(quantity) total_quantatity FROM Gold.fact_sales
UNION ALL
SELECT 'AVG Price',AVG(price) avarage_price FROM Gold.fact_sales
UNION ALL
SELECT 'Total Orders',COUNT( DISTINCT order_name) AS total_order FROM Gold.fact_sales
UNION ALL 
SELECT 'Total Products' ,COUNT(product_number) total_product FROM Gold.dim_products
UNION ALL
SELECT 'Total Customers ',COUNT(customer_number) total_customer FROM Gold.dim_customer
UNION ALL
SELECT 'Total customer Who placed an order ', COUNT(DISTINCT customer_key) AS total_customer FROM Gold.fact_sales
