--solving parctice book called sql problems 
USE SQLPracticeProblems57
GO 

--1
SELECT *
from Shippers

--2
SELECT CategoryName , Description 
FROM Categories 
 
--3 
SELECT FirstName , LastName , HireDate 
FROM Employees
WHERE  Title in ('Sales Representative')

--4 
SELECT FirstName , LastName , HireDate 
FROM Employees
WHERE  Title in ('Sales Representative') 
AND  Country in ('USA')

--5 
SELECT * 
FROM Orders
WHERE EmployeeID = 5 

--6 
SELECT SupplierID , ContactName , ContactTitle
from Suppliers 
WHERE ContactTitle  NOT IN  ('Marketing Manager')

--7
SELECT ProductID , ProductName
FROM Products 
WHERE ProductName Like  ('queso')

--8 
SELECT OrderID , CustomerID , ShipCountry
FROM Orders
WHERE ShipCountry in ('France') 
OR 
ShipCountry in ('Belgium')
--9
SELECT OrderID , CustomerID , ShipCountry
FROM Orders
WHERE 
ShipCountry in ('Brazil' )  OR 
ShipCountry in ('Mexico' )  OR 
ShipCountry in ('Argentina')  OR 
ShipCountry in ('Venezuela')  

--10 
SELECT FirstName , LastName , Title , BirthDate 
FROM Employees
order by birthdate 

--11
SELECT FirstName , LastName , Title , Convert( DATE , BirthDate ) as birthdate
FROM Employees
order by (Birthdate)

--12
SELECT FirstName ,
LastName ,
CONCAT (FirstName , '' ,LastName) 
						as  FULLname 
 FROM Employees 

 --13
 SELECT UnitPrice , OrderID , ProductID ,Quantity 
	, UnitPrice * QUANTITY AS TOTALPRICE
 FROM OrderDetails
 ORDER BY orderid  

 --14
 select  COUNT(*) as CustomerCOUNT  
 from Customers

--15 
SELECT top 1 OrderDate
FROM Orders    

--16 
select DISTINCT(Country)
from Customers

--17 
 SELECT COUNT(*) AS TotalCustomers
FROM Customers
 
--18
select ProductID , ProductName , CompanyName
from Suppliers AS A
join Products AS B 
	ON A.SupplierID = B.SupplierID

--19 
SELECT OrderID , OrderDate, ShipperID
FROM Orders AS A 
JOIN Shippers AS B	
	on A.ShipVia = B.ShipperID

--20
SELECT CategoryName , COUNT (B.ProductID) AS TOTAL  
FROM Categories   AS A 
JOIN Products  AS B 
	ON A.CategoryID = B.CategoryID
GROUP BY A.CategoryName 
ORDER BY TOTAL

--21 
SELECT Country , City , COUNT(*) as TOTAL    
FROM Customers   
GROUP BY Country , city 
order by Country , city 
--22
select ProductID
from Products
where UnitsInStock = 0 
--23
SELECT *
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel
AND Discontinued = 0

--24 
select CustomerID
from Customers
order by 
		CASE WHEN 
		Region IS NULL THEN 1 ELSE 0 
		END , 
					Region	ASC 

 
--25 
SELECT TOP 3
    ShipCountry,
    AVG(Freight) AS AverageFreight
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC;

--26 
SELECT TOP 3
    ShipCountry,
    AVG(Freight) AS AverageFreight
FROM Orders
WHERE YEAR(OrderDate) = 2015 
GROUP BY ShipCountry 
ORDER BY AverageFreight DESC; 

--27 
select  *
from orders
where 
	OrderDate >='20150101' and
	'OrderDate' < '20160101'
group by ShipCountry 

--28

select Dateadd (yy, -1 ,
(SELECT max(OrderDate) from Orders )) 
--29
select OrderID , ProductName , A.ProductID

from Products as A 
join OrderDetails  as B 
	on A.ProductID = B.ProductID
--
--30
select  a.CustomerID , b.CustomerID
FROM Customers as a 
 left JOIN Orders as b 
	on a.CustomerID = b.CustomerID
WHERE a.CustomerID is  null
--31
--117
select a.CustomerID , c.CustomerID
from Customers as a
 left join Orders as c 
	on a.CustomerID= c.CustomerID 
WHERE  c.CustomerID is null 
		and 
		c.CustomerID= 4
--32
--120

SELECT
    a.CustomerID,
    a.OrderID,
    SUM(b.UnitPrice * b.Quantity) AS TotalValue
FROM Orders AS a
JOIN OrderDetails AS b
    ON a.OrderID = b.OrderID
WHERE YEAR(a.OrderDate) = 2016
GROUP BY a.CustomerID, a.OrderID
HAVING SUM(b.UnitPrice * b.Quantity) >= 10000;

--33
use SQLPracticeProblems57
GO 
SELECT
    a.CustomerID,
    a.OrderID,
    SUM(b.UnitPrice * b.Quantity) AS TotalValue
FROM Orders AS a
JOIN OrderDetails AS b
    ON a.OrderID = b.OrderID
JOIN Customers as c 
	on a.CustomerID = c.CustomerID
WHERE a.OrderDate >= '20160101'
	and a.OrderDate <'20170101'
GROUP BY c.CustomerID, c.CompanyName
HAVING SUM(b.UnitPrice * b.Quantity) > 15000
order by TotalValue desc 
--34
Select
Customers.CustomerID
,Customers.CompanyName
,TotalsWithoutDiscount = SUM(Quantity * UnitPrice)
,TotalsWithDiscount = SUM(Quantity * UnitPrice * (1- Discount))
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
Having sum(Quantity * UnitPrice * (1- Discount)) > 10000
Order by TotalsWithDiscount DESC

--35
select  OrderDate
, EmployeeID
, OrderID 
FROM Orders AS orders 
where orders.OrderDate = EOMONTH(OrderDate)
order by 
	EmployeeID , OrderID

--36
SELECT top 10 orders.OrderID
, total=count(*)
FROM Orders
	join OrderDetails 
	on Orders.OrderID = OrderDetails.OrderID
		GROUP BY orders.OrderID
		order by count(*) desc 
--37
select top 2 percent OrderID
from Orders  
order by NEWID()
--38
select OrderID 
--Distinct(productid)
from OrderDetails 
where Quantity >= 60 
GROUP BY OrderID ,quantity
having count(*) > 1 
--39
with PotentialDuplicates as (
Select
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
)
Select
OrderID,ProductID,UnitPrice,Quantity,Discount
From OrderDetails
Where
OrderID in (Select OrderID from PotentialDuplicates)
Order by
OrderID,Quantity
--40
Select
OrderDetails.OrderID,ProductID,UnitPrice,Quantity,Discount
From OrderDetails
Join (Select distinct
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1) 
PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID
--41
use SQLpracticeProblems57 
GO 
select OrderID , OrderDate= CONVERT(date,OrderDate)
, RequiredDate=convert(date, RequiredDate)
,shippeddate = convert(date, ShippedDate)
from Orders
where RequiredDate <= ShippedDate 
--42
Select
Employees.EmployeeID
,LastName
,TotalLateOrders = Count(*)
From Orders
Join Employees
on Employees.EmployeeID = Orders.EmployeeID
Where
RequiredDate <= ShippedDate
Group By
Employees.EmployeeID
,Employees.LastName
Order by TotalLateOrders desc
--43
--44
--45
--46
--47
--48
--49
--51
with Orders2016 as (
Select
Customers.CustomerID
,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
)
Select
CustomerID
,CompanyName
,TotalOrderAmount
,CustomerGroupName
from Orders2016
Join CustomerGroupThresholds
on Orders2016.TotalOrderAmount between
CustomerGroupThresholds.RangeBottom and CustomerGroupThresholds.RangeTop
Order by CustomerID
--52
Select Country From Customers
Union
Select Country From Suppliers
Order by Country
--53
With SupplierCountries as
(Select Distinct Country from Suppliers)
,CustomerCountries as
(Select Distinct Country from Customers)
Select
SupplierCountry = SupplierCountries .Country
,CustomerCountry = CustomerCountries .Country
From SupplierCountries
Full Outer Join CustomerCountries
on CustomerCountries.Country = SupplierCountries.Country
--54
With SupplierCountries as
(Select Country , Total = Count(*) from Suppliers group by Country)
,CustomerCountries as
(Select Country , Total = Count(*) from Customers group by Country)
Select
Country = isnull( SupplierCountries.Country, CustomerCountries.Country)
,TotalSuppliers= isnull(SupplierCountries.Total,0)
,TotalCustomers= isnull(CustomerCountries.Total,0)
From SupplierCountries
Full Outer Join CustomerCountries
on CustomerCountries.Country = SupplierCountries.Country
--55
with OrdersByCountry as
(
Select
ShipCountry
,CustomerID
,OrderID
,OrderDate = convert(date, OrderDate)
,RowNumberPerCountry =
Row_Number()
over (Partition by ShipCountry Order by ShipCountry, OrderID)
From Orders
)
Select
ShipCountry
,CustomerID
,OrderID
,OrderDate
From OrdersByCountry
Where
RowNumberPerCountry = 1
Order by
ShipCountry
--56
--57
--58
--56
Select
InitialOrder.CustomerID
,InitialOrderID = InitialOrder.OrderID
,InitialOrderDate = convert(date, InitialOrder.OrderDate)
,NextOrderID = NextOrder.OrderID
,NextOrderDate = convert(date, NextOrder.OrderDate)
,DaysBetween = datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate)
from Orders InitialOrder
join Orders NextOrder
on InitialOrder.CustomerID = NextOrder.CustomerID
where
InitialOrder.OrderID < NextOrder.OrderID
and datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
Order by
InitialOrder.CustomerID
,InitialOrder.OrderID
--57.2
;With NextOrderDate as (
Select
CustomerID
,OrderDate = convert(date, OrderDate)
,NextOrderDate =
convert(
date
,Lead(OrderDate,1)
OVER (Partition by CustomerID order by CustomerID, OrderDate)
)
From Orders
)
Select
CustomerID
,OrderDate
,NextOrderDate
,DaysBetweenOrders = DateDiff (dd, OrderDate, NextOrderDate)
From NextOrderDate
Where
DateDiff (dd, OrderDate, NextOrderDate) <= 5

