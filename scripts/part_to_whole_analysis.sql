/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
WITH CTE_pr AS (
SELECT 
	p.category,
    SUM(f.price) TotalPriceByCategory
FROM Gold.fact_sales f
LEFT JOIN Gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category)


SELECT 
	pr.category,
	pr.TotalPriceByCategory,
	FORMAT(CAST(pr.TotalPriceByCategory AS FLOAT ) /CAST(SUM(pr.TotalPriceByCategory ) OVER() AS FLOAT),'p') precentageOfeachproduct

FROM CTE_pr pr
