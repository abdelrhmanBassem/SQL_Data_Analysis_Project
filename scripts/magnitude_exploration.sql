/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/
--find total customers by countries
SELECT
country,
COUNT(customer_key) total_customer_by_country
FROM Gold.dim_customer
GROUP BY country
--find total customers by gender
SELECT
gender,
COUNT(customer_key) total_customer_by_gender
FROM Gold.dim_customer
GROUP BY gender
--find total product by category 
SELECT 
category,
COUNT(product_key)
FROM Gold.dim_products
GROUP BY category
--total revenu generated for each product
SELECT 
p.category,
SUM(f.sales_amount) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_products  p
ON p.product_key=f.product_key
GROUP BY p.category
ORDER BY total_revenu DESC

--total revenu generated for each customer
SELECT 
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_customer  c
ON c.customer_key=f.customer_key
GROUP BY c.customer_key,c.first_name,
c.last_name
ORDER BY total_revenu DESC
--distribution of sold in each country 
SELECT 
c.country,
SUM(f.sales_amount) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_customer  c
ON c.customer_key=f.customer_key
GROUP BY c.country
ORDER BY total_revenu DESC
