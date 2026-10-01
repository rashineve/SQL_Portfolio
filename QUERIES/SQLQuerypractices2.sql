USE BikeStores
go 
--1
SELECT *
FROM sales.customers
WHERE phone IS NOT NULL
AND city <> 'Texas'
--2
SELECT *
FROM production.products
WHERE list_price > 1000 
AND brand_id <> 1 
--3
SELECT *
FROM sales.orders
WHERE store_id <> 2 
--4 
SELECT * 
FROM sales.customers 
WHERE phone LIKE '512%'
--5
--چون اطلاعاتم از دو جدول میاد باید با  با جوین به هم وصلشون ککنم 

SELECT *
FROM production.products AS A
JOIN sales.order_items AS B 
	ON A.product_id = B.product_id
WHERE product_name LIKE '%Trek%'
AND  quantity >= 5
--6
SELECT * 
FROM sales.orders 
WHERE year(shipped_date) = 2018
AND order_status= 4 
--7
SELECT * 
FROM production.brands AS a 
JOIN production.stocks AS b 
	ON a.brand_id = b .product_id
WHERE b.quantity = 0
--8
SELECT * 
FROM sales.orders AS O
JOIN sales.customers AS Z
	ON  O.customer_id=Z.customer_id
WHERE email is NULL 
--9
SELECT *
FROM production.brands AS A
JOIN production.products AS B
	ON A.brand_id= B.brand_id
LEFT JOIN sales.order_items AS C
	ON C.product_id =B.product_id
WHERE A.brand_id = 9 
AND C.product_id IS NULL
--10
SELECT * 
FROM sales.order_items AS A
JOIN production.products as B 
	ON A.product_id = B.product_id
WHERE B.list_price <= 500
--11
SELECT *
FROM production.products AS A 
JOIN production.categories AS B 
	ON A.category_id = B.category_id
where product_name LIKE '%Electra%'
AND A.category_id BETWEEN  2 AND 5
--12
SELECT * 
FROM sales.customers
WHERE street + city LIKE '%Apt %'
		OR street + city LIKE '%Suite%'
--13
SELECT * 
FROM sales.staffs AS A 
JOIN sales.orders AS B 
	ON A.staff_id = B.staff_id
WHERE B.customer_id IS NULL -- از طریق مشتریان بفهمیم چون هیچ اردری نیست بدون مشتری که 
--14
SELECT *
FROM production.products AS M
JOIN production.stocks AS A 
	ON A.product_id = M.product_id
JOIN sales.stores AS B 
	ON B.store_id =A.store_id
WHERE B.store_name = ''-- har store ro bekhaim in bain mizarim 
--15
SELECT * 
FROM sales.orders AS A 
JOIN sales.customers AS B 
	ON A.customer_id = B.customer_id
WHERE B.email  NOT  LIKE  '%gmail.com%'
OR		 B.email NOT LIKE '%yahoo.com%'
--16
/*SELECT * 
FROM production.brands
WHERE brand_id IN (
				SELECT DISTINCT brand_id
				FROM production.products
				WHERE product_id NOT IN (
										SELECT product_id 
										FROM sales.order_items
										WHERE quantity > 1)
				AND product_id IN (
								SELECT product_id 
								FROM sales.order_items 
								)*/
--GROUP BY 1
USE BikeStores 
go
SELECT order_status ,
COUNT(*) as [OrderCount]
FROM sales.orders
GROUP BY order_status
--2 
SELECT category_id ,
COUNT(*)
FROM production.products
GROUP BY category_id 
-- 3 
SELECT B.brand_name , 
AVG(list_price)	AS [AVERAGE PRICE]
FROM production.products AS P
JOIN production.brands AS B 
	ON P.brand_id = B.brand_id
GROUP BY B.brand_name -- esm brand haro neshoon bede 

SELECT brand_id , AVG(list_price) AS [AVERAGE PRICE]
FROM production.products 
GROUP BY brand_id --esm nist faght id 
--4 
SELECT brand_id, MAX(list_price) AS [MAXIIMOM PRICE ]
FROM production.products
GROUP BY brand_id
--5 
SELECT staff_id , COUNT(*) AS [Orders]
FROM sales.orders
GROUP BY staff_id
--6
SELECT customer_id , COUNT(*) AS [NUMBER OF ORDERS] 
FROM sales.orders 
GROUP BY customer_id 
--7
SELECT year(order_date) AS [YEAR]
, COUNT(*) AS [NUMBER OF ORDERS ]
FROM sales.orders
GROUP BY  year(order_date)
--8
SELECT MONTH(order_date)  AS [ MONTH ]
,COUNT(*) AS [ORDERS ]
FROM sales.orders 
WHERE YEAR(order_date)= 2017
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)
--9
--تعداد سفارش اول 
SELECT  TOP 1 customer_id , COUNT(*) AS [ORDERS ]
FROM sales.orders
GROUP BY customer_id 
ORDER BY COUNT(*) DESC 

--10
select store_id , COUNT(*) AS [NUMBERS OF SOLDS]
FROM sales.orders
WHERE order_status	 =	 4 
GROUP BY store_id
--AGE MANZOOR GHEIMAT BASHE CHI ?
 SELECT o.store_id,
       SUM(oi.quantity * oi.list_price) AS [COMBINE]
FROM sales.orders AS o
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.store_id