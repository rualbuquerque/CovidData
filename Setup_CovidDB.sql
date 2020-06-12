-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************
-- ************************************** [dbo].[Date]

CREATE TABLE [dbo].[Date]
(
 [dateID]   int NOT NULL ,
 [date]     date NOT NULL ,
 [year]     date NOT NULL ,
 [month]    date NOT NULL ,
 [week_day] date NOT NULL ,


 CONSTRAINT [PK_DateID] PRIMARY KEY CLUSTERED ([dateID] ASC)
);
GO

-- ************************************** [dbo].[Country]

CREATE TABLE [dbo].[Country]
(
 [countryID]                    int IDENTITY (1, 1) NOT NULL ,
 [country]                 nvarchar(32) NOT NULL ,
 [iso_code]                   nvarchar(8) NULL ,
 [continent]                  nvarchar(13) NOT NULL ,
 [gdp_per_capita]             float NULL CONSTRAINT [DF_Country_gdp_per_capita] DEFAULT ((0)) ,
 [extreme_poverty]            float NULL ,
 [hospital_beds_per_thousand] float NULL ,
 [diabetes_prevalence]        float NULL ,
 [female_smokers]             float NULL ,
 [male_smokers]               float NULL ,
 [population]                 int NULL ,
 [population_density]         float NULL ,
 [median_age]                 float NULL ,
 [aged_65_older]              float NULL ,
 [aged_70_olderer_thousand]   float NULL ,


 CONSTRAINT [PK_CountryID] PRIMARY KEY CLUSTERED ([countryID] ASC)
);
GO


-- ************************************** [dbo].[Cases]

CREATE TABLE [dbo].[Cases]
(
 [casesID]                 int IDENTITY (1, 1) NOT NULL ,
 [new_cases]               int NOT NULL ,
 [total_cases]             int NOT NULL ,
 [total_cases_per_million] float NULL ,
 [new_cases_per_million]   float NULL ,
 [stringency_index]        float NULL ,
 [dateID]                  int NOT NULL ,
 [countryID]               int NOT NULL ,


 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([casesID] ASC),
 CONSTRAINT [FK_DateID] FOREIGN KEY ([dateID])  REFERENCES [dbo].[Date]([dateID]),
 CONSTRAINT [FK_Country] FOREIGN KEY ([countryID])  REFERENCES [dbo].[Country]([countryID])
);
GO


-- ************************************** [dbo].[Deaths]

CREATE TABLE [dbo].[Deaths]
(
 [deathsID]                 int IDENTITY (1, 1) NOT NULL ,
 [country]                  nvarchar(32) NOT NULL ,
 [new_deaths]               int NOT NULL,
 [total_deaths_per_million] float NULL ,
 [new_deaths_per_million]   float NULL ,
 [cvd_death_rate]           float NULL ,
 [dateID]                   int NOT NULL ,
 [countryID]                int NOT NULL ,


 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([deathsID] ASC),
 CONSTRAINT [FK_DateID_TableDeaths] FOREIGN KEY ([dateID])  REFERENCES [dbo].[Date]([dateID]),
 CONSTRAINT [FK_CountryID_TableDeaths] FOREIGN KEY ([countryID])  REFERENCES [dbo].[Country]([countryID])
);
GO

-- ************************************** [dbo].[Tests]

CREATE TABLE [dbo].[Tests]
(
 [testID]                          int IDENTITY (1, 1) NOT NULL ,
 [country]                         nvarchar(32) NOT NULL ,
 [total_tests]                     int NULL ,
 [new_tests]                       int NULL ,
 [total_tests_per_thousand]        float NULL ,
 [new_tests_per_thousand]          float NULL ,
 [new_tests_smoothed]              float NULL ,
 [new_tests_smoothed_per_thousand] float NULL ,
 [tests_units]                     nvarchar(15) NULL ,
 [dateID]                          int NOT NULL ,
 [countryID]                       int NOT NULL ,


 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([testID] ASC),
 CONSTRAINT [FK_DateID_TableTests] FOREIGN KEY ([dateID])  REFERENCES [dbo].[Date]([dateID]),
 CONSTRAINT [FK_CountryID_TableTests] FOREIGN KEY ([countryID])  REFERENCES [dbo].[Country]([countryID])
);
GO
