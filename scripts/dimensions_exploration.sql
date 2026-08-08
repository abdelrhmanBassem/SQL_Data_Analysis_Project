
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

--Explore dim of dim_customer
 --Explore dim of country
 SELECT DISTINCT country  FROM Gold.dim_customer 
  --Explore dim of category 
SELECT  DISTINCT category,subcategory,product_name FROM Gold.dim_products
order by 1,2,3
