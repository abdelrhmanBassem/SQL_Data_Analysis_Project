/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH CTE_V AS(
SELECT 
	product_key,
	product_id,
	product_number,
	product_name,
	product_cost,
	product_line,
	CASE
	WHEN product_cost <=(AVG(product_cost) OVER() ) THEN 'Low'
	WHEN product_cost >= (AVG(product_cost) OVER()) AND product_cost <= (3*AVG(product_cost) OVER() ) THEN 'Medium'
	ELSE 'High'
	END Product_segmentation
FROM Gold.dim_products
WHERE product_cost >0 
)

SELECT
	V.Product_segmentation,
	COUNT(V.Product_segmentation) TotalSegmentation
FROM CTE_V V
GROUP BY V.Product_segmentation;
GO
/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH CTE_CustmerDetails AS (
SELECT 
	c.first_name,
	c.last_name,
	MIN(order_date) customerFirstOrder,
	MAX(order_date) LastCustomerOrder,
	DATEDIFF(MONTH,MIN(order_date) ,MAX(order_date)) customerhistory,
	SUM(f.price) TotalPriceForCustomer
FROM Gold.fact_sales f
LEFT JOIN Gold.dim_customer c 
ON c.customer_key = f.customer_key
GROUP BY c.first_name,
	c.last_name
)

SELECT	
	*,
	CASE
	WHEN customerhistory >=12 AND TotalPriceForCustomer >5000 THEN 'VIP'
	WHEN customerhistory >=12 AND TotalPriceForCustomer <5000 THEN 'Regular'
	WHEN customerhistory <12  THEN 'New'
	END
FROM CTE_CustmerDetails
