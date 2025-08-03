/* I am using AdventureWorksDW2022 */

/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */

SELECT * FROM DimCustomer;

SELECT * FROM FactInternetSales;

-- INNER JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
INNER JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey;

-- LEFT JOIN
/* Get all customers along with their orders, 
   including those without orders */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
LEFT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey;

-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
RIGHT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey;

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM FactInternetSales FIS
LEFT JOIN DimCustomer DC ON FIS.CustomerKey=DC.CustomerKey

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
FULL JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey;

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
LEFT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey -- AND FIS.CustomerKey IS NULL;
WHERE FIS.CustomerKey IS NULL;

-- RIGHT ANTI JOIN
/* Get all orders without matching customers */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
RIGHT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey --AND FIS.CustomerKey IS NULL;
WHERE FIS.CustomerKey IS NULL;

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM FactInternetSales FIS
LEFT JOIN DimCustomer DC ON FIS.CustomerKey=DC.CustomerKey --AND FIS.CustomerKey IS NULL;
WHERE FIS.CustomerKey IS NULL;

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
LEFT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey --AND FIS.CustomerKey IS NOT NULL;
WHERE FIS.CustomerKey IS NOT NULL;

-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
FULL JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey 
WHERE DC.CustomerKey IS NULL OR FIS.CustomerKey IS NULL;

-- Alternative to INNER JOIN using LEFT JOIN OR FULL JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
LEFT JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey 
WHERE FIS.CustomerKey IS NOT NULL;

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
FULL JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey 
WHERE DC.CustomerKey IS NOT NULL AND  FIS.CustomerKey IS NOT NULL;

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
CROSS JOIN FactInternetSales FIS;

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

