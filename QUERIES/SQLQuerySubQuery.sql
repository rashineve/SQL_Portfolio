--SUBQUERY
  USE  BikeStores
  GO 
  --1 
  SELECT product_name, list_price, 
   (		SELECT MAX(list_price)
			FROM production.products 
			AS HIGHEST )
	FROM production.products 
--2
SELECT * 
FROM production.products
WHERE list_price > (
			SELECT MIN(list_price)
			FROM production.products
			WHERE brand_id = 1 )
--3
-- tamam haro ro bia ye majmooyeh ddar nazar begir
SELECT *
FROM production.products
-- TAMAM MAHSULATI KE AZ BRAND ID 2 LIST PRICE BISHTARE 
WHERE list_price > (
				SELECT MAX(list_price)
				FROM production.products 
				WHERE brand_id = 2 )
				-- ba ALL ? 
SELECT * 
FROM production.products 
WHERE list_price > ALL (
				SELECT list_price
				FROM production.products
				WHERE brand_id = 2 
				) 
--4
SELECT *
FROM production.products 
WHERE NOT EXISTS (
				SELECT * 
				FROM sales.order_items
				WHERE products.product_id = order_items.product_id
				)
				--5**؟؟؟؟؟؟؟؟؟؟؟؟
--6
--ALL 
SELECT * 
FROM production.products AS A 
JOIN production.brands AS B 
		ON  A.brand_id = B.brand_id 
WHERE A.list_price  = (
					SELECT MAX(C.list_price)
					FROM production.products AS C 
					WHERE C.brand_id = A.brand_id)

--7
SELECT DISTINCT B.*
FROM sales.orders AS A 
JOIN sales . customers AS B 
	ON A.customer_id = B.customer_id
	WHERE A.order_date >= DATEADD(YEAR,-7 , GETDATE())

	-- اوکیه هیچ رکوردی نده ؟ اره چون اخرین سفارشش میثکه 2018 بوده 

SELECT MIN(order_date), MAX(order_date)
FROM sales.orders
