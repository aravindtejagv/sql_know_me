--I AM USING ADVENTUREWORKSDW

/* ==============================================================================
   SQL SET Operations
-------------------------------------------------------------------------------
   SQL set operations enable you to combine results from multiple queries
   into a single result set. This script demonstrates the rules and usage of
   set operations, including UNION, UNION ALL, EXCEPT, and INTERSECT.
   
   Table of Contents:
     1. SQL Operation Rules
     2. UNION
     3. UNION ALL
     4. EXCEPT
     5. INTERSECT
=================================================================================
*/

/* ==============================================================================
   RULES OF SET OPERATIONS
===============================================================================*/

/* RULE: Data Types
   The data types of columns in each query should match.
*/

SELECT FirstName,LastName,EmailAddress FROM DimCustomer 
UNION
SELECT FirstName,LastName,EmailAddress FROM DimEmployee

/* RULE: Data Types (Example)
   The data types of columns in each query should match.
*/

SELECT CustomerKey,LastName,EmailAddress FROM DimCustomer 
UNION
SELECT FirstName,LastName,EmailAddress FROM DimEmployee

/* RULE: Column Order
   The order of the columns in each query must be the same.
*/

SELECT EmailAddress,FirstName,LastName FROM DimCustomer 
UNION
SELECT LastName,FirstName,EmailAddress FROM DimEmployee

/* RULE: Column Aliases
   The column names in the result set are determined by the column names
   specified in the first SELECT statement.
*/

SELECT FirstName F_Name,LastName,EmailAddress FROM DimCustomer 
UNION
SELECT FirstName,LastName L_Name,EmailAddress FROM DimEmployee

/* RULE: Correct Columns
   Ensure that the correct columns are used to maintain data consistency.
*/

SELECT MiddleName F_Name,LastName,EmailAddress FROM DimCustomer 
UNION
SELECT FirstName,MiddleName L_Name,EmailAddress FROM DimEmployee

/* ==============================================================================
   SETS: UNION, UNION ALL, EXCEPT, INTERSECT
===============================================================================*/

/* TASK 1: 
   Combine the data from Employees and Customers into one table using UNION 
*/

SELECT FirstName,LastName,EmailAddress FROM DimCustomer 
UNION
SELECT FirstName,LastName,EmailAddress FROM DimEmployee

/* TASK 2: 
   Combine the data from Employees and Customers into one table, including duplicates, using UNION ALL 
*/

SELECT FirstName,LastName,EmailAddress FROM DimCustomer 
UNION ALL
SELECT FirstName,LastName,EmailAddress FROM DimEmployee

/* TASK 3: 
   Find employees who are NOT customers using EXCEPT 
*/

SELECT FirstName,LastName,EmailAddress FROM DimEmployee 
EXCEPT
SELECT FirstName,LastName,EmailAddress FROM DimCustomer

/* TASK 4: 
   Find employees who are also customers using INTERSECT 
*/

SELECT FirstName,LastName,EmailAddress FROM DimEmployee 
INTERSECT
SELECT FirstName,LastName,EmailAddress FROM DimCustomer

/* TASK 5: 
   Combine order data from Orders and OrdersArchive into one report without duplicates 
*/

select 
'Orders' as BaseTable,
OrderID,
ProductID,
CustomerID,
SalesPersonID,
OrderDate,
ShipDate,
OrderStatus,
ShipAddress,
BillAddress,
Quantity,
Sales,
CreationTime
from SalesDB.Sales.Orders

union

select 
'Orders_Archive' as FromTable,
OrderID,
ProductID,
CustomerID,
SalesPersonID,
OrderDate,
ShipDate,
OrderStatus,
ShipAddress,
BillAddress,
Quantity,
Sales,
CreationTime
from SalesDB.Sales.OrdersArchive
order by OrderID asc

