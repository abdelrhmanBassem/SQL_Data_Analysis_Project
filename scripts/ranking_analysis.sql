/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
--top 5 products on sales price
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_products  p
ON p.product_key=f.product_key
GROUP BY p.product_name
ORDER BY total_revenu DESC

--Worst  5 products sales price
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_products  p
ON p.product_key=f.product_key
GROUP BY p.product_name
ORDER BY total_revenu ASC

--Top 10 customers generate high sales
SELECT TOP 10 
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

--TOP  customer make order placed 
SELECT  TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT( DISTINCT f.order_name) total_revenu
FROM  Gold.fact_sales f
LEFT JOIN Gold.dim_customer  c
ON c.customer_key=f.customer_key
GROUP BY c.customer_key,c.first_name,
c.last_name
ORDER BY total_revenu 
