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

/* ==============================================================================
   SQL Date & Time Functions
-------------------------------------------------------------------------------
   This script demonstrates various date and time functions in SQL.
   It covers functions such as GETDATE, DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, DAY, EOMONTH, FORMAT, CONVERT, CAST, DATEADD, DATEDIFF,
   and ISDATE.
   
   Table of Contents:
     1. GETDATE | Date Values
     2. Date Part Extractions (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
     3. DATETRUNC
     4. EOMONTH
     5. Date Parts
     6. FORMAT
     7. CONVERT
     8. CAST
     9. DATEADD / DATEDIFF
    10. ISDATE
===============================================================================
*/

/* ==============================================================================
   GETDATE() | DATE VALUES
===============================================================================*/

/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date.
*/ 
-- I am using AdventureWorksDW2022

SELECT DC.CustomerKey,DC.FirstName,DC.DateFirstPurchase,
FIS.OrderDate,
FIS.ShipDate,
'2025-08-10' as Hardcoded_Curr_Date,
GETDATE() as Curr_Date,
CURRENT_TIMESTAMP as Curr_Date2,
SYSDATETIME() as Curr_Date_time,
SYSDATETIMEOFFSET() as Curr_Date_time_offset
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey

/*Task 2:

Display Day, Year, Month of OrderDate.
*/

-- I am using AdventureWorksDW2022

SELECT DC.CustomerKey,DC.FirstName,
DC.DateFirstPurchase,
FIS.OrderDate,
Year(FIS.OrderDate) as Year,
Month(FIS.OrderDate) as MOnth,
Day(FIS.OrderDate) as Day
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey

/*Task 2.a:

Display Datepart on OrderDate.
*/

-- I am using AdventureWorksDW2022
-- FYI Datepart returns only interger value i.e., Type int as output

SELECT DC.CustomerKey,DC.FirstName,
DC.DateFirstPurchase,
FIS.OrderDate,
Year(FIS.OrderDate) as Year,
Month(FIS.OrderDate) as Month,
Day(FIS.OrderDate) as Day,
DATEPART(YEAR,FIS.OrderDate) as Year_dp,
DATEPART(Month,FIS.OrderDate) as Month_dp,
DATEPART(Day,FIS.OrderDate) as Day_dp,
DATEPART(HOUR,FIS.OrderDate) as hour_dp,
DATEPART(DAYOFYEAR,FIS.OrderDate) as Dayyear_dp,
DATEPART(QUARTER,FIS.OrderDate) as Quarter_dp,
DATEPART(WEEK,FIS.OrderDate) as Week_dp,
DATEPART(WEEKDAY,FIS.OrderDate) as Weekday_dp
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
order by FIS.OrderDateKey DESC

/*Task 2.b:

Display Datename on OrderDate.
*/

-- I am using AdventureWorksDW2022
-- FYI Datename returns only String value i.e., Type String as output

SELECT DC.CustomerKey,DC.FirstName,
DC.DateFirstPurchase,
FIS.OrderDate,
DATENAME(YEAR,FIS.OrderDate) as Year_dn,
DATENAME(Month,FIS.OrderDate) as Month_dn,
DATENAME(Day,FIS.OrderDate) as Day_dn,
DATENAME(Hour,FIS.OrderDate) as hour_dn, --- For testing purpose i used datename for hour as well, But the result is '0'
DATENAME(DAYOFYEAR,FIS.OrderDate) as Dayyear_dn,
DATENAME(QUARTER,FIS.OrderDate) as Quarter_dn,
DATENAME(WEEK,FIS.OrderDate) as Week_dn,
DATENAME(WEEKDAY,FIS.OrderDate) as Weekday_dn
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
order by FIS.OrderDateKey DESC


/*for reference
 create table #test (d datetime);
 insert into #test values(null); 
 insert into #test values(null);
 insert into #test values(null); 
 update #test SET d = DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530), 0);
 select * from #test;
 drop table #test; */

/*Task 3:

Display DATETRUNC on OrderDate.
*/
-- I am using AdventureWorksDW2022

 SELECT DC.CustomerKey,DC.FirstName,fis.OrderDate,
DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate) Random_time, --used for random date or time.
DATETRUNC(YEAR,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as Year_dT,
DATETRUNC(Month,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as Month_dt,
DATETRUNC(Day,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as Day_dt,
DATETRUNC(HOUR,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as hour_dt, 
DATETRUNC(MINUTE,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as minute_dt,
DATETRUNC(SECOND,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as second_dt, 
DATETRUNC(MILLISECOND,DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 65530),fis.OrderDate)) as millisecond_dt
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
order by FIS.CustomerKey DESC

/*Task 4:

Display EOMONTH on OrderDate.
*/

SELECT 
FIS.OrderDate,
EOMONTH(FIS.OrderDate)
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey

/*
Task 5: DATE PARTS 
I am using AdventureWorksDW2022
SAMPLE EXAMPLE FOR DATETRUNC
*/
SELECT 
DATETRUNC(MONTH,FIS.OrderDate) as Year_dT,
COUNT(*) AS TOTALSALES,SUM(FIS.SalesAmount) AS TOTAL_SALES_AMOUNT
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
GROUP BY DATETRUNC(MONTH,FIS.OrderDate) 
order by DATETRUNC(MONTH,FIS.OrderDate) DESC

/* ==============================================================================
  FORMAT & CAST & CONVERT
===============================================================================*/
/*
Task 6: FORMAT 

Format Date into various string representations.
*/
SELECT DC.CustomerKey,
FIS.OrderDate,
FORMAT(FIS.OrderDate, 'dd-MM-yyyy') AS EURO_Format,
FORMAT(FIS.OrderDate, 'MM-dd-yyyy') AS USA_Format,
FORMAT(FIS.OrderDate, 'dd') AS dd,
FORMAT(FIS.OrderDate, 'ddd') AS ddd,
FORMAT(FIS.OrderDate, 'dddd') AS dddd,
FORMAT(FIS.OrderDate, 'MM') AS MM,
FORMAT(FIS.OrderDate, 'MMM') AS MMM,
FORMAT(FIS.OrderDate, 'MMMM') AS MMMM
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
order by FIS.OrderDateKey DESC

/* TASk :
   Display date using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT OrderDate,
DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 65530),sysdatetime()) as RandomDate,
'Day'+' '+FORMAT(DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 65530),sysdatetime()),'ddd MMM')+' Q'+
DATENAME(QQ,DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 65530),sysdatetime()))+' '+
FORMAT(DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 65530),sysdatetime()),'yyyy hh:mm:ss tt') as CustomFormat
FROM FactInternetSales;

/* TASK:
   How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?
*/

SELECT FORMAT(OrderDate,'MMM yy'),
COUNT(SalesOrderNumber) As TotalOrders
FROM FactInternetSales
GROUP BY FORMAT(OrderDate,'MMM yy')

/* ==============================================================================
   CONVERT()
===============================================================================*/

/* Task 7. CONVERT
   Demonstrate conversion using CONVERT.
*/
SELECT CONVERT(INT,'1234') AS STRING_TO_INT,
CONVERT(DATE,'2025-03-23') AS STRING_TO_DATE,
OrderDate, 
CONVERT(DATE,OrderDate) AS DATETIME_TO_DATE,
CONVERT(VARCHAR,OrderDate,32) AS [USA Std. Style:32],
CONVERT(VARCHAR,OrderDate,34) AS [EURO Std. Style:34]

FROM FactInternetSales

/* ==============================================================================
   CAST()
===============================================================================*/

/* Task 8. CAST
   Convert data types using CAST.
*/

SELECT 
CAST('1234' AS INT) AS STRING_TO_INT,
CAST(1234 AS VARCHAR) AS INT_TO_STRIG,
CAST('2025-06-24' AS date) AS STRING_TO_DATE,
CAST('2025-04-14' AS datetime) AS STRING_TO_DATETIME,
OrderDate,
CAST(OrderDate AS DATE) AS DATETIME_TO_DATE
FROM FactInternetSales

/* ==============================================================================
   DATEADD() / DATEDIFF()
===============================================================================*/

/* Task 9. DATEADD / DATEDIFF

   Task:Perform date arithmetic on OrderDate.
*/
SELECT FirstName,
BirthDate,
DATEADD(DAY,9,BirthDate) AS NINEDAYSFROM_BRITHDATE,
DATEADD(DAY,-14,BirthDate) AS TWOWEEKSBEFOREFROM_BRITHDATE,
DATEADD(MONTH,7,BirthDate) AS SEVENMONTHSFROM_BRITHMONTH,
DATEADD(YEAR,2,BirthDate) AS TWOYEARFROM_BRITHYEAR
FROM DimCustomer

/* TASK :
   Calculate the age of employees.
*/

SELECT FirstName,
BirthDate,
DATEDIFF(YEAR,BirthDate,'2020-01-01') Age_asof2020,
DATEDIFF(YEAR,BirthDate,GETDATE()) Age_asofToday
FROM DimCustomer

/* TASK: Find the average shipping duration in days for each month.
*/

SELECT MONTH(OrderDate) AS ORDERMONTH,
AVG(DATEDIFF(DAY,OrderDate,ShipDate))
FROM FactInternetSales
GROUP BY MONTH(OrderDate) 
ORDER BY MONTH(OrderDate)  ASC

/* TASK : Time Gap Analysis: Find the number of days between each order and the previous order.
*/

SELECT DC.CustomerKey,DC.FirstName,
FIS.OrderDate,FIS.SalesOrderNumber,
LAG(FIS.OrderDate) OVER (ORDER BY FIS.OrderDate) AS PerviousOrderDate,
DATEDIFF(DAY,LAG(FIS.OrderDate) OVER (ORDER BY FIS.OrderDate),OrderDate) TimeGapBetweenOrders
FROM DimCustomer DC
JOIN FactInternetSales FIS ON FIS.CustomerKey=DC.CustomerKey
--WHERE DC.CustomerKey=25863
order by FIS.OrderDateKey ASC

/* ==============================================================================
   ISDATE
===============================================================================*/

/* Task 10. ISDATE*/

select 
ISDATE('123') AS DATECHECK1,
ISDATE('2025-08-31') AS DATECHECK2,
ISDATE('08-31-2025') AS DATECHECK3,
ISDATE('20-12-2025') AS DATECHECK4,
ISDATE('31-10-2025') AS DATECHECK5,
ISDATE('2025') AS DATECHECK6,
ISDATE('10') AS DATECHECK7,
ISDATE('31') AS DATECHECK8

/* TASK : Validate ODate using ISDATE and convert valid dates.*/

select ODate,
ISDATE(ODate) as DateFlag,   --Perform Date Validation
case
when ISDATE(ODate)<>0 then CAST(ODate as Date)
else '9999-01-01' --'Not a valid date'
end  as ODate_Date
--CONVERT(Date,ODate,0) as ODate_USDate
from (
select '2024-08-20' as ODate
union 
select '2023-12-01' 
union 
select '2021-31-08' 
union 
select '31-11-2022' 
union 
select '2024-09' 
union 
select '07-11-2022' 
) temp
--where ISDATE(ODate) <>0






