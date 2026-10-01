--CASE EXPRESSION 
USE BikeStores 
GO 
 --1
 SELECT 
		order_id,
		order_status,
	CASE order_status
			WHEN 1 THEN 'PENDING '
			WHEN 2 THEN 'PROCCESSING '
			WHEN 3 THEN 'REJECTED'
			WHEN 4 THEN 'COMPLETED '
		END AS status_name 
	FROM sales.orders
 --2 
SELECT 
		customer_id , 
		COUNT(customer_id) as [NUMS],
			CASE 
			WHEN COUNT(customer_id)  = 1 THEN 'NEW'
			WHEN COUNT(customer_id) = 2 THEN 'REGULAR'
			WHEN COUNT(customer_id) = 3 THEN 'LOYAL'
		END AS [cutomers_names]
FROM sales.customers
GROUP BY customer_id
--3
SELECT *,
	CASE
	WHEN quantity = 0 THEN 'OUT OF STOCK'
	WHEN quantity BETWEEN 1 AND 20 THEN 'LOW STOCK'
	WHEN quantity <20  THEN 'IN STOCK'
END AS srock_status
FROM production.stocks 

--4 -- AGE GHEIMAT BEKHAD ? 
SELECT *,
		CASE category_id 
		WHEN 1 THEN '10 PERCENT OFF'
		WHEN 2 THEN '5 PERCENT OFF'
		ELSE  '0 OFF'
	END AS OFFERS
FROM production.categories
 
