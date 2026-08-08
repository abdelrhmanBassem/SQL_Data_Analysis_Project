/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

SELECT
	MIN(order_date) First_Order_date,
	MAX(order_date) Last_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) order_date_range
FROM Gold.fact_sales

SELECT 
MAX(birthdate) AS youngest_customer,
DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS youngest_customer_age ,
MIN(birthdate) AS oldest_customer,
DATEDIFF(YEAR,MAX(birthdate),GETDATE()) AS oldest_customer_age
FROM Gold.dim_customer 
