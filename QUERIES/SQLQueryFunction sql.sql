--FUNCTION 

USE BikeStores
GO 

--3
/* جدول های مورد نیاز ما اطلاعات مشتری 
و سفارش های مشتری
و ایتم های هر سفارش 
و مبلغ هر سفارش هستش
--DENCE RANK ?
 --PARTITION BY */
 WITH CustomerSales AS
(
    SELECT
        C.city,
        C.customer_id,
        C.first_name,
        C.last_name,
        SUM(OI.quantity * OI.list_price) AS TotalAmount
    FROM sales.customers AS C
    INNER JOIN sales.orders AS O
        ON C.customer_id = O.customer_id
    INNER JOIN sales.order_items AS OI
        ON O.order_id = OI.order_id
    GROUP BY
        C.city,
        C.customer_id,
        C.first_name,
        C.last_name
),
RankedCustomers AS
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY TotalAmount DESC
        ) AS RN
    FROM CustomerSales
)
SELECT *
FROM RankedCustomers
WHERE RN <= 3
--گزارش 
SELECT *
FROM dbo.Top3CustomersByCity()
--4
-- QUANTITY * list price 
--ROW NUMBER 
-- هر مشتری جدا پارتیشن بندی بشه 
--5
--سه تا محصولی که بیشترین تعداد توی ORDER ITEMS 
-- رو داشتن 
--YEAR(DATETIME )
--6
--7
--8
-- 3 دسته GROUP BY 
