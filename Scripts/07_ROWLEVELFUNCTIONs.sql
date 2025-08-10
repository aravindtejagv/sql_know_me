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

select CustomerKey,
FirstName,
BirthDate,
Replace(BirthDate,'-','') as BD_Code,
EmailAddress,
Replace(EmailAddress,'adventure-works','yahoo') as New_Email
from DimCustomer

/* ============================================================================== 
   LEN() - String Length & Trimming
=============================================================================== */

-- Calculate the length of each customer's first name

select CustomerKey,
FirstName,
len(firstname) len_fname,
EmailAddress,
len(EmailAddress) len_email
from DimCustomer

/* ============================================================================== 
   LEFT() & RIGHT() - Substring Extraction
=============================================================================== */

select CustomerKey,
FirstName,
EmailAddress,
LEFT(EmailAddress,5) as first_5_charcters,
RIGHT(EmailAddress,6) as last_6_charcters,
Addressline1 as Ad_Line,
LEFT(TRIM(AddressLine1),4) as Ad_4_first, --trim to remove spaces if available
RIGHT(TRIM(AddressLine1),7) as Ad_7_last --trim to remove spaces if available
from DimCustomer


	
/* ============================================================================== 
   SUBSTRING() - Extracting Substrings
=============================================================================== */

-- Retrieve a list of customers' first names after removing the first character

select CustomerKey,
FirstName,
SUBSTRING(FirstName,1,2) s1,
SUBSTRING(reverse(FirstName),1,2) s2,
SUBSTRING(Trim(FirstName),2,len(FirstName)) Main --Answer to heading
from DimCustomer


/* ==============================================================================
   NESTING FUNCTIONS
===============================================================================*/

SELECT AccountDescription,
SUBSTRING(TRIM(AccountDescription),2,10) AS SUBSTR,
LEFT(SUBSTRING(TRIM(AccountDescription),2,10),8) AS LEFT_OF_SUBSTR,
LEN(LEFT(SUBSTRING(TRIM(AccountDescription),2,10),8)) AS LEN_OF_LEFT_OF_SUBSTR
FROM DimAccount

/* ============================================================================== 
   SQL Number Functions Guide
-------------------------------------------------------------------------------
   This document provides an overview of SQL number functions, which allow 
   performing mathematical operations and formatting numerical values.

   Table of Contents:
     1. Rounding Functions
        - ROUND
     2. Absolute Value Function
        - ABS
=================================================================================
*/

/* ============================================================================== 
   ROUND() - Rounding Numbers
=============================================================================== */

-- Demonstrate rounding a number to different decimal places


    SELECT 22.0 / 7;
    -- Or
    SELECT 22 / 7.0;
    /*Adding a decimal point to 22 (making it 22.0) or 7 (making it 7.0) implicitly
     converts the literal to a numeric data type with a decimal component, 
     forcing SQL Server to perform floating-point division.*/

SELECT 22.0/7 as divfor,3.142857 as numfor,3.51675 as numfor2,
ROUND(22/7.0,3) Rdivfor_3,ROUND(3.142857,3)Rnumfor_3,ROUND(3.51675,3)Rnumfor2_3,
ROUND(22.0/7.0,1) Rdivfor_1,ROUND(3.142857,1) Rnumfor_1,ROUND(3.51675,1) Rnumfor2_1,
ROUND(22.0/7,0) Rdivfor_0,ROUND(3.142857,0) Rnumfor_0,ROUND(3.51675,0) Rnumfor2_0

/* ============================================================================== 
   ABS() - Absolute Value
=============================================================================== */

-- Demonstrate absolute value function

SELECT -22.0/7 as divfor,22/-7.0 as divfor2,
3.142857 as numfor,-3.51675 as numfor2,
ABS(-22.0/7) ABS1,
ABS(22/-7.0) ABS2,
ABS(3.142857) ABS3,
ABS(-3.51675) ABS4,
ABS(ROUND(-3.51675,0)) ABS5_ROUN
