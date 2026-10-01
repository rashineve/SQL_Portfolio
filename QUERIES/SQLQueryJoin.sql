--JOIN 
USE BikeStores 
GO 
--1 
SELECT * 
FROM production.categories AS A 
JOIN production.products AS B
	ON A.category_id = B.category_id 
JOIN sales.order_items AS C
	ON b.product_id = C.product_id
--2
-- HICH SEFARESHI RO NADASHTAN 
SELECT P.* 
FROM production.products AS P 
LEFT JOIN sales.order_items AS O 
	ON P.product_id = O.product_id 
WHERE O.order_id IS NULL 
--3 
SELECT DISTINCT  A.*
FROM production.products AS A 
INNER JOIN production.stocks AS B 
		ON A.product_id = B.product_id 
WHERE B.quantity > 0
--4
SELECT 
    A.first_name,
    A.last_name,
    COUNT(B.order_id) AS [num]
FROM sales.customers AS A
INNER JOIN sales.orders AS B
    ON A.customer_id = B.customer_id
GROUP BY 
    A.customer_id,
    A.first_name,
    A.last_name
HAVING COUNT(B.order_id) = 1
--5
--brand id 9 
SELECT product_name
FROM sales.order_items AS A 
FULL JOIN production.products AS B
    ON A.product_id= B.product_id
  WHERE B.brand_id = 9 

--6 
-- BAYAD LEFT RO MENHAYE ESHTERAK 
-- LEFT VA RIGHT KONIM 
SELECT * 
FROM production.stocks AS A 
 LEFT JOIN sales.order_items AS B 
  ON A.product_id = B.product_id
EXCEPT
SELECT * 
FROM production.stocks AS A 
 INNER JOIN sales.order_items AS B 
 ON A.product_id = B.product_id
 
 --6
 SELECT A.*
FROM production.stocks AS A
LEFT JOIN sales.order_items AS B
    ON A.product_id = B.product_id
WHERE B.product_id IS NULL 

--7
SELECT 
    A.first_name,
    A.last_name,
    B.store_name,
    COUNT(C.order_id) AS [num_orders]
FROM sales.staffs AS A
INNER JOIN sales.stores AS B
    ON A.store_id = B.store_id
LEFT JOIN sales.orders AS C
    ON A.staff_id = C.staff_id
GROUP BY 
    A.first_name,
    A.last_name,
    B.store_name

--8
--IIF?
--EXIST ?
SELECT
    B.brand_name,
    C.category_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM production.products AS P
            WHERE P.brand_id = B.brand_id
              AND P.category_id = C.category_id)
                                THEN 'YES'
                                 ELSE 'NO'
    END AS [Has Product]
FROM production.brands AS B
CROSS JOIN production.categories AS C
--9

--10
--SELF JOIN ]
SELECT
    A.first_name AS [Employee First Name],
    A.last_name AS [Employee Last Name],
    B.first_name AS [Manager First Name],
    B.last_name AS [Manager Last Name]
FROM sales.staffs AS A
LEFT JOIN sales.staffs AS B
    ON A.manager_id = B.staff_id

