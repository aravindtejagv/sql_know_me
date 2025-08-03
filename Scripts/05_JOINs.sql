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
LEFT JOIN DimCustomer DC ON DC.CustomerKey=FIS.CustomerKey;
-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */

SELECT DC.CustomerKey,DC.FirstName,FIS.SalesOrderNumber,FIS.SalesAmount FROM DimCustomer DC
FULL JOIN FactInternetSales FIS ON DC.CustomerKey=FIS.CustomerKey;

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */