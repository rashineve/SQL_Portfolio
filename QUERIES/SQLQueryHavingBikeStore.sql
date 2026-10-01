--HAVING 
--1
Use BikeStores
GO 
--orderitems <product id > 
SELECT A.product_id,A.product_name, COUNT (*)
AS ordersCount
FROM production.products AS A 
JOIN sales.order_items AS B
	ON A.product_id= B.product_id
GROUP BY A.product_id, A.product_name
HAVING COUNT (*)>20

--2 
SELECT A.customer_id, A.first_name ,A.last_name ,
		COUNT(B.order_id) AS ordersCOunt
FROM sales.customers AS A 
JOIN sales.orders AS B 
	ON A.customer_id = B.customer_id
GROUP BY A.customer_id , A.first_name , A.last_name
HAVING COUNT (B.order_id) >2 

--3 
SELECT order_id , SUM (discount) AS total_dis
FROM sales.order_items
GROUP BY order_id
HAVING SUM(discount)>2000

--4 
SELECT A.brand_name , 
		COUNT (B.product_id) AS numbers
FROM production.brands AS A 
JOIN production.products  AS B 
	ON A.brand_id = B.brand_id
 GROUP BY A.brand_name 
 HAVING ( COUNT (B.product_id)) > 10
 --4.2 
 --mikham sorat join ro befahmam 
  SELECT brand_id , COUNT (*) AS products
  FROM production.products
  GROUP BY brand_id
  HAVING COUNT (*) > 10
  --SORAT RO PAEEN MIARE :(
  --5 
  SELECT staff_id  , COUNT (*)  AS NUMBERS
  FROM sales.orders
  WHERE YEAR(order_date) = 2016 
  GROUP BY staff_id
  HAVING  COUNT(*) > 200
   --6 
SELECT customer_id , 
	COUNT (customer_id) AS [ORDERS]
FROM sales.orders
GROUP BY customer_id 
HAVING COUNT(*) = 1
ORDER BY customer_id desc
--7 
SELECT store_id, 
		COUNT (order_id) as [tedad] 
FROM sales.orders
GROUP BY store_id
HAVING COUNT (order_id) <200 

--8
SELECT staff_id , 
	COUNT ( DISTINCT customer_id ) AS [TEDAD]
FROM sales.orders 
GROUP BY staff_id 
HAVING COUNT (DISTINCT customer_id) <100

--9 
--تاریخ میخواد ازم order date 
--شرطش ؟ توی یه تاریخ 6 تا سفارش بیشتر  
SELECT order_date , COUNT(order_date) as [-]
FROM sales.orders
GROUP BY order_date 
HAVING COUNT(order_date)>=6

--10
--ازم فروشگاه میخاد 
-- شرطش ؟
--تعداد مشتریانش توی سال ها بیشتر از 100 باشن 
SELECT store_id, COUNT ( DISTINCT customer_id) 
,				YEAR(order_date) as OrderYear
FROM sales.orders 
GROUP BY store_id, YEAR(order_date)
having COUNT (DISTINCT customer_id) >100








