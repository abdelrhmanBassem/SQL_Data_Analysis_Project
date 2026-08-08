/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/
--Analyze sales performance over time
SELECT 
	t.Year_Of_Order,
	t.Month_Of_Order,
	SUM(t.TotalOrderByTime) OVER(ORDER BY t.Year_Of_Order ,t.Month_Of_Order) Total_Order_OVER_Time
FROM(
SELECT
	YEAR(order_date) Year_Of_Order,
	MONTH(order_date) Month_Of_Order,
	SUM(Price) TotalOrderByTime
FROM Gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
)t
