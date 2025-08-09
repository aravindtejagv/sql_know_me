/* We have Functions in SQL in order to Manipulate, Analyze, Clean or Transform data inside table.

TWO Categories of functions we have:

1.  Single row functions eg: LOWER()
2.  Multi row functrions eg: SUM()
*/

/* ============================================================================== 
   SQL String Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL string functions, which allow 
   manipulation, transformation, and extraction of text data efficiently.

   Table of Contents:
     1. Manipulations
        - CONCAT
        - LOWER
        - UPPER
	- TRIM
	- REPLACE
     2. Calculation
        - LEN
     3. Substring Extraction
        - LEFT
        - RIGHT
        - SUBSTRING
=================================================================================
*/

/* ============================================================================== 
   CONCAT() - String Concatenation
=============================================================================== */

-- Concatenate first name and country into one column
--using adventureworks2022

select dc.FirstName,
dg.City,
CONCAT(dc.FirstName,'-',dg.City) As Name_City
from DimCustomer dc
join DimGeography dg on dc.GeographyKey=dg.GeographyKey

/* ============================================================================== 
   LOWER() & UPPER() - Case Transformation
=============================================================================== */

-- Convert the first name to lowercase, uppercase 
--using adventureworks2022

select FirstName,
lower(FirstName) as lower_fname,
upper(firstname) as upper_fname  
from DimCustomer

/* ============================================================================== 
   TRIM() - Remove White Spaces
=============================================================================== */

-- Find customers whose first name contains leading or trailing spaces
--using MyDatabase DB

select id,
first_name,
len(first_name) as len_fname,
len(trim(first_name)) as len_trim_fname,
len(first_name) - len(trim(first_name)) as Flag
from MyDatabase.dbo.customers
where len(first_name) != len(trim(first_name)) 
--where  first_name!= trim(first_name)

/* ============================================================================== 
   REPLACE() - Replace or Remove old value with new one
=============================================================================== */


