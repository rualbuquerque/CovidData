-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************
USE master
go;

----- Creating CovidDB
IF EXISTS (SELECT * FROM sys.databases WHERE name= 'Covid_DB')
DROP DATABASE Covid_DB

CREATE DATABASE Covid_DB


------------------------------------------------------------------------------------
-------- ****************** Creating Schemas ************************----------------
------------------------------------------------------------------------------------

---- Creating schema temp

CREATE SCHEMA [temp]
go

------- Creating schema Canada

CREATE SCHEMA [Canada]
go


-----------------------------------------------------------------------------------------------------------------------
------------- **************************** Creating Tables ********************************************----------------
-----------------------------------------------------------------------------------------------------------------------
/*
The tables are:
temp.coviddata - .csv imported as it is to a SQL table
dbo.coviddata - table with the correct datatypes

Then I divided the table by subject with the possibility of organizating it by countries (being, on this case, the schemas)
[Canada].[Date]
[Canada].[Country]
[Canada].[Cases]
[Canada].[Deaths]
[Canada].[Tests]

The reason is to be able to write simpler queries to build faster and clear reports. 
If you want, you can create a fact table joining on the date column.

*/


--------------------------------------------------------------------------
---************************* [temp].[CovidData] ***************************
--------------------------------------------------------------------------

CREATE TABLE [temp].[CovidData] (
    [iso_code] varchar(50),
    [continent] varchar(50),
    [location] varchar(50),
    [date] varchar(50),
    [total_cases] varchar(50),
    [new_cases] varchar(50),
    [total_deaths] varchar(50),
    [new_deaths] varchar(50),
    [total_cases_per_million] varchar(50),
    [new_cases_per_million] varchar(50),
    [total_deaths_per_million] varchar(50),
    [new_deaths_per_million] varchar(50),
    [total_tests] varchar(50),
    [new_tests] varchar(50),
    [total_tests_per_thousand] varchar(50),
    [new_tests_per_thousand] varchar(50),
    [new_tests_smoothed] varchar(50),
    [new_tests_smoothed_per_thousand] varchar(50),
    [tests_units] varchar(50),
    [stringency_index] varchar(50),
    [population] varchar(50),
    [population_density] varchar(50),
    [median_age] varchar(50),
    [aged_65_older] varchar(50),
    [aged_70_older] varchar(50),
    [gdp_per_capita] varchar(50),
    [extreme_poverty] varchar(50),
    [cvd_death_rate] varchar(50),
    [diabetes_prevalence] varchar(50),
    [female_smokers] varchar(50),
    [male_smokers] varchar(50),
    [handwashing_facilities] varchar(50),
    [hospital_beds_per_thousand] varchar(50)
)


--------------------------------------------------------------------------
---************************* [dbo].[CovidData] ***************************
--------------------------------------------------------------------------

CREATE TABLE [dbo].[CovidData] (

[iso_code]                 nvarchar(8) NULL ,
[continent]                nvarchar(13) NULL ,
[location]                 nvarchar(32) NOT NULL ,
[date]     			datetime NOT NULL ,
[new_cases]			int NOT NULL ,
[new_cases_per_million]	float NULL ,
[total_cases]			int NOT NULL ,
[total_cases_per_million]	float NULL ,
[new_deaths]               int NOT NULL,
[new_deaths_per_million]   float NULL ,
[total_deaths]             int NOT NULL,
[total_deaths_per_million] float NULL ,
[cvd_death_rate]           float NULL,
[stringency_index]		float NULL,
[total_tests]                     int NULL ,
[new_tests]                       int NULL ,
[total_tests_per_thousand]        float NULL ,
[new_tests_per_thousand]          float NULL ,
[new_tests_smoothed]              float NULL ,
[new_tests_smoothed_per_thousand] float NULL ,
[tests_units]                     nvarchar(15) NULL,
[gdp_per_capita]             float NULL ,
[extreme_poverty]            float NULL ,
[hospital_beds_per_thousand] float NULL ,
[diabetes_prevalence]        float NULL ,
[female_smokers]             float NULL ,
[male_smokers]               float NULL ,
[population]                 bigint NULL ,
[population_density]         float NULL ,
[median_age]                 float NULL ,
[aged_65_older]              float NULL ,
[aged_70_olderer_thousand]   float NULL ,
)


--------------------------------------------------------------------------
---************************* [Canada].[Date] *************************
--------------------------------------------------------------------------


CREATE TABLE [Canada].[date]
(
 [dateID]   int IDENTITY (1, 1) NOT NULL ,
 [date]     datetime NOT NULL ,
 [year]     int NOT NULL ,
 [month]    int NOT NULL ,
 [month_name] nvarchar (30)  NOT NULL ,
 [day]		int NOT NULL ,
 [week_day] nvarchar(30) NOT NULL ,


 CONSTRAINT [PK_DateID] PRIMARY KEY CLUSTERED ([dateID] ASC)
);
GO

------------------------------
---- INSERT QUERY 
------------------------------

--SELECT [date],
--		YEAR([date]) as year,
--		MONTH([date]) as month,
--		DATENAME(MONTH, date) as month_name,
--		DAY([date]) as day,
--		DATENAME(WEEKDAY, date) as week_day

--  FROM [Covid_DB].[temp].[coviddata]
--WHERE date IS NOT NULL and location = 'canada'


--------------------------------------------------------------------------
---************************* [Canada].[Country] *************************
--------------------------------------------------------------------------

CREATE TABLE [Canada].[Country]
(
 [countryID]                    int IDENTITY (1, 1) NOT NULL ,
 [date]     datetime NOT NULL ,
 [country]                 nvarchar(32) NOT NULL ,
 [iso_code]                   nvarchar(8) NULL ,
 [continent]                  nvarchar(13) NULL ,
 [gdp_per_capita]             float NULL ,
 [extreme_poverty]            float NULL ,
 [hospital_beds_per_thousand] float NULL ,
 [diabetes_prevalence]        float NULL ,
 [female_smokers]             float NULL ,
 [male_smokers]               float NULL ,
 [population]                 bigint NULL ,
 [population_density]         float NULL ,
 [median_age]                 float NULL ,
 [aged_65_older]              float NULL ,
 [aged_70_olderer_thousand]   float NULL ,


 CONSTRAINT [PK_CountryID] PRIMARY KEY CLUSTERED ([countryID] ASC)
);
GO
------------------------------
---- INSERT QUERY 
------------------------------

--SELECT [iso_code]
--		,date
--      ,[continent]
--      ,[location] as country
--      ,[population]
--      ,[population_density]
--      ,[median_age]
--      ,[aged_65_older]
--      ,[aged_70_older]
--      ,[gdp_per_capita]
--      ,[extreme_poverty]
--      ,[diabetes_prevalence]
--      ,[female_smokers]
--      ,[male_smokers]
--      ,[hospital_beds_per_thousand]
--  FROM [Covid_DB].[temp].[coviddata]
--WHERE location = 'Canada'

--------------------------------------------------------------------------
---************************* [Canada].[Cases] ***************************
--------------------------------------------------------------------------

CREATE TABLE [Canada].[Cases]
(
 [casesID]					int IDENTITY (1, 1) NOT NULL ,
 [country]					nvarchar(32) NOT NULL ,
 [date]						datetime NOT NULL ,
 [new_cases]				int NOT NULL ,
 [total_cases]				int NOT NULL ,
 [total_cases_per_million]	float NULL ,
 [new_cases_per_million]	float NULL ,
 [stringency_index]			float NULL  


 CONSTRAINT [casesID] PRIMARY KEY CLUSTERED ([casesID] ASC)
);
GO
------------------------------
---- INSERT QUERY 
------------------------------

--SELECT [location]
--      ,[date]
--      ,[total_cases]
--      ,[new_cases]
--      ,[total_cases_per_million]
--      ,[new_cases_per_million]
--      ,[stringency_index]
--  FROM [Covid_DB].[temp].[coviddata]
--where location = 'Canada'


--------------------------------------------------------------------------
---************************* [Canada].[Deaths] ***************************
--------------------------------------------------------------------------

CREATE TABLE [Canada].[Deaths]
(
 [deathsID]                 int IDENTITY (1, 1) NOT NULL ,
 [country]                 nvarchar(32) NOT NULL ,
 [date]     datetime NOT NULL ,
 [new_deaths]               int NOT NULL,
 [total_deaths]               int NOT NULL,
 [total_deaths_per_million] float NULL ,
 [new_deaths_per_million]   float NULL ,
 [cvd_death_rate]           float NULL 


 CONSTRAINT [deathsID] PRIMARY KEY CLUSTERED ([deathsID] ASC));
GO
------------------------------
---- INSERT QUERY 
------------------------------

-- SELECT location as country,
--		date,
--		new_deaths,
--		total_deaths,
--		total_deaths_per_million,
--		new_deaths_per_million,
--		cvd_death_rate
-- FROM temp.CovidData
--WHERE location = 'Canada'

--------------------------------------------------------------------------
---************************* [Canada].[Tests] ***************************
--------------------------------------------------------------------------


CREATE TABLE [Canada].[Tests]
(
 [testID]                          int IDENTITY (1, 1) NOT NULL,
 [country]                 nvarchar(32) NOT NULL ,
 [date]     datetime NOT NULL ,
 [total_tests]                     int NULL ,
 [new_tests]                       int NULL ,
 [total_tests_per_thousand]        float NULL ,
 [new_tests_per_thousand]          float NULL ,
 [new_tests_smoothed]              float NULL ,
 [new_tests_smoothed_per_thousand] float NULL ,
 [tests_units]                     nvarchar(15) NULL 


 CONSTRAINT [testID] PRIMARY KEY CLUSTERED ([testID] ASC)
 );
GO
------------------------------
---- INSERT QUERY 
------------------------------

--SELECT location as country,
--		date,
--		total_tests,
--		new_tests,
--		total_tests_per_thousand,
--		new_tests_per_thousand,
--		new_tests_smoothed,
--		new_tests_smoothed_per_thousand,
--		tests_units
--FROM temp.CovidData
--WHERE location = 'Canada'

