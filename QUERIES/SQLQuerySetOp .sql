--SET OP 
USE BikeStores 
GO 
--1
SELECT  product_id
FROM sales.order_items AS A 
JOIN sales . orders AS B 
	on A.order_id =B.order_id
WHERE B.store_id =1 
INTERSECT
SELECT  product_id
FROM sales.order_items AS A 
JOIN sales . orders AS B 
	on A.order_id =B.order_id
WHERE B.store_id = 2

--2
--EXCEPT؟؟؟؟؟؟؟؟ 
--3
--ONLY
--SELECT *
--FROM production.brands except 
--JOIN production.categories  as A 
SELECT brand_id
FROM production.brands
EXCEPT
SELECT brand_id
FROM production.products
WHERE category_id = 1 
--4
 -- UNION 
 SELECT customer_id
 FROM sales.customers 
 UNION 
 SELECT store_id
 FROM sales.stores 
 WHERE store_id = 1 OR store_id = 2 
--5
--except
--6
--EXCEPT 
