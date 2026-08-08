/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/
--Analyze performance by comparing current sales by avg and last year's sales
SELECT 
	t.product_name,
	t.YearOfOrder,
	t.totalOrderByYear,
	AVG(t.totalOrderByYear) OVER(PARTITION BY  t.product_name ORDER BY t.product_name,t.YearOfOrder) AvgOrderByYear,
	CASE
      WHEN (t.totalOrderByYear - AVG(t.totalOrderByYear) OVER(PARTITION BY  t.product_name ORDER BY t.product_name,t.YearOfOrder))  >0 THEN 'Above Average'
	  WHEN (t.totalOrderByYear - AVG(t.totalOrderByYear) OVER(PARTITION BY  t.product_name ORDER BY t.product_name,t.YearOfOrder))  < 0  THEN 'Below Average'
	  ELSE 'Avg'
	  END avg_performanceOfeachProduct,
	  CASE 
	  WHEN (t.totalOrderByYear - LAG(t.totalOrderByYear) OVER(PARTITION BY t.product_name ORDER BY t.YearOfOrder))>0 THEN 'Increase'
	  WHEN (t.totalOrderByYear - LAG(t.totalOrderByYear) OVER(PARTITION BY t.product_name ORDER BY t.YearOfOrder)) < 0 THEN 'Decrease'
	   ELSE 'no change'
	  END total_performanceOfeachProduct
FROM(
SELECT 
p.product_name,
YEAR(order_date) YearOfOrder,
SUM(price) AS totalOrderByYear
FROM Gold.fact_sales f
LEFT JOIN Gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY p.product_name,YEAR(order_date)
)t
ORDER BY t.product_name,t.YearOfOrder
