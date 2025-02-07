# # SSIS ETL Process 

## Table of Contents
1. [Introduction](#introduction)
2. [Source Database in SQL Server](#source-database-in-sql-server)
3. [Data Warehouse Architecture](#data-warehouse-architecture)
4. [Project Setup in Visual Studio](#project-setup-in-visual-studio)
5. [Control Flow](#control-flow)
6. [Sequence Containers](#sequence-containers)
7. [Connection Managers](#connection-managers)
8. [Execution and Troubleshooting](#execution-and-troubleshooting)
9. [Summary](#summary)

## Introduction
This guide explains the SSIS ETL process for extracting data from the `AdventureWorks_Basics` database, transforming it, and loading it into the `DWAdventureWorks_Basics` data warehouse.

## Source Database in SQL Server
Source tables in `AdventureWorks_Basics`:
- **DimProduct** - Product details
- **DimCustomer** - Customer information
- **DimDate** - Date-related data
- **FactSalesOrder** - Sales transactions

### Steps to Validate Data:
1. Restore `AdventureWorks_Basics` using the provided script.
2. Validate table structures and relationships.
3. Check data integrity.

## Data Warehouse Architecture
Data is stored in `DWAdventureWorks_Basics` for reporting and analytics.

### Setup Steps:
- Execute script to create the data warehouse with Slowly Changing Dimensions (SCDs).

## Project Setup in Visual Studio
1. Create a blank solution `A03_YourNameHere`.
2. Add an SSIS project `A03_ETLPackages`.
3. Rename `Package.dtsx` to `ETLProcess.dtsx`.
4. Add SSIS components for ETL workflow.

## Control Flow
Key components:
- **Execute SQL Tasks** - Run SQL commands
- **Sequence Containers** - Organize related tasks
- **Precedence Constraints** - Define task execution order

## Sequence Containers
1. **Pre-Load** - Prepares environment.
2. **Load Dimension Tables** - Loads dimensions.
3. **Load Fact Tables** - Loads facts.
4. **Post-Load** - Finalization tasks.

## Connection Managers
- **Source**: `AdventureWorks_Basics` (OLE DB Connection)
- **Destination**: `DWAdventureWorks_Basics` (OLE DB Connection)
- Always test connections before execution.

## Execution and Troubleshooting
### Execution Steps:
1. Open `ETLProcess.dtsx` in Visual Studio.
2. Start debugging.
3. Monitor execution results.

### Common Issues & Solutions:
| Issue | Cause | Solution |
|--------|---------|-----------|
| Connection Failure | Incorrect credentials | Verify settings |
| Data Mismatch | Errors in transformation logic | Review mappings |
| ETL Failure | Missing permissions | Check stored procedures |

## Summary
This manual provides a concise guide to the SSIS ETL process, covering data extraction, transformation, and loading into `DWAdventureWorks_Basics`. It serves as a reference for new hires and technicians managing the ETL pipeline.

