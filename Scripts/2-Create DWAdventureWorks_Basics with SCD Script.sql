/****************** Instructors Version ***************************
Title: Create the DWAdventureWorks_BasicsWithSCD database
Desc: This file will drop and create the [DWAdventureWorks_BasicsWithSCD]
 database, with all its objects. 
Change Log: (When,Who,What)
2022-12-29,RRoot,Created File
****************** Instructors Version ***************************/

USE [master]
go
If Exists (Select * from Sysdatabases Where Name = 'DWAdventureWorks_BasicsWithSCD')
	Begin 
		ALTER DATABASE [DWAdventureWorks_BasicsWithSCD] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE [DWAdventureWorks_BasicsWithSCD]
	End
go
Create Database [DWAdventureWorks_BasicsWithSCD]
go

--********************************************************************--
-- Create the Tables
--********************************************************************--
USE [DWAdventureWorks_BasicsWithSCD]
go

/****** [dbo].[DimProducts] with Type 2 SCD ******/
CREATE TABLE [dbo].[DimProducts](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[StandardListPrice] [decimal](18, 4) NOT NULL,
	[ProductSubCategoryID] [int] NOT NULL,
	[ProductSubCategoryName] [nvarchar](50) NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[ProductCategoryName] [nvarchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[IsCurrent] [int] NOT NULL CONSTRAINT [CK_DimProducts_IsCurrentValue] Check(IsCurrent in (0,1)),
	CONSTRAINT [PK_DimProducts] PRIMARY KEY CLUSTERED
	([ProductKey])
) 
go

/****** [dbo].[DimCustomers] with Type 2 SCD ******/
CREATE TABLE [dbo].[DimCustomers](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[CustomerFullName] [nvarchar](100) NOT NULL,
	[CustomerCityName] [nvarchar](50) NOT NULL,
	[CustomerStateProvinceName] [nvarchar](50) NOT NULL,
	[CustomerCountryRegionCode] [nvarchar](50) NOT NULL,
	[CustomerCountryRegionName] [nvarchar](50) NOT NULL,
  [StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[IsCurrent] [int] NOT NULL CONSTRAINT [CK_DimCustomers_IsCurrentValue] Check(IsCurrent in (0,1)),
	CONSTRAINT [PK_DimCustomers] PRIMARY KEY CLUSTERED
	([CustomerKey] ASC )
)
go

/****** [dbo].[FactSalesOrders] with Type 1 SCD ******/
CREATE TABLE [dbo].[FactSalesOrders](
	[SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[OrderQty] [int] NOT NULL,
	[ActualUnitPrice] [decimal](18, 4) NOT NULL,
	CONSTRAINT [PK_FactSalesOrders] PRIMARY KEY CLUSTERED 
	([SalesOrderID],[SalesOrderDetailID],[OrderDateKey],[CustomerKey],[ProductKey])
) ON [PRIMARY]
go

/****** [dbo].[DimDates] with Type 1 SCD ******/
CREATE TABLE [dbo].[DimDates](
	[DateKey] [int],
	[FullDate] [datetime] NOT NULL,
	[FullDateName] [nvarchar](50) NULL,
	[MonthID] [int] NOT NULL,
	[MonthName] [nvarchar](50) NOT NULL,
	[YearID] [int] NOT NULL,
	[YearName] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_DimDates] PRIMARY KEY CLUSTERED
	([DateKey] )
)
go

--********************************************************************--
-- Create the FOREIGN KEY CONSTRAINTS
--********************************************************************--

ALTER TABLE [dbo].[FactSalesOrders] ADD CONSTRAINT [FK_FactSalesOrders_DimCustomers] 
	FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomers] ([CustomerKey])
go
ALTER TABLE [dbo].[FactSalesOrders] ADD CONSTRAINT [FK_FactSalesOrders_DimProducts]
	FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProducts] ([ProductKey])
go
ALTER TABLE [dbo].[FactSalesOrders] ADD CONSTRAINT [FK_FactSalesOrders_DimDates]
	FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDates] ([DateKey])
go

--********************************************************************--
-- Review the results of this script
--********************************************************************--
Select 'Database Created'
Select Name, xType, CrDate from SysObjects 
Where xType in ('u', 'PK', 'F')
Order By xType desc, Name

