# Data Warehouses - Laboratories | Gdańsk University of Technology 2024/2025

## Project Description

This project focuses on creating a data warehouse and Business Intelligence (BI) system for a Developer specializing in residential construction. The goal is to enhance decision-making through effective data analysis and reporting, particularly in the areas of material management and project execution. The main steps include implementing an ETL (Extract, Transform, Load) process to gather and prepare data from key sources, designing a data warehouse, and optimizing performance for quick data access.

### Key Technologies and Tools Used:
- **MS SQL Server** for database management and building the data warehouse, utilizing **T-SQL** for writing queries and scripts to manipulate and manage data efficiently. **SQL Server Profiler** is employed to monitor and analyze query performance.
- **SQL Server Integration Services (SSIS)** for developing and managing the ETL process, ensuring accurate and efficient data loading from various sources, including the material ordering and inventory management systems.
- **Visual Studio** for creating a multidimensional model using Analysis Services, enabling complex data analysis through **MDX (Multidimensional Expressions)** queries.
- **Power BI** for designing interactive reports and dashboards that display key insights and KPIs, facilitating informed decision-making and performance tracking.

Through these technologies, the project aims to optimize material usage, reduce costs, and improve the overall efficiency of construction projects, ultimately enhancing the Developer's operational control.


## Lab 1: Specifying Requirements for BI System and Preparing Data Sources

Lab 1 focused on defining BI system requirements and preparing data sources. Two documents were created: `Process_Specification.pdf` and `Requirements_Process_Specification.pdf`, based on the provided templates.

### Tasks:
**Process Specification:**
- Define two business processes.
- Specify two measurable goals.

**Requirements Specification:**
- Define two data sources.
- Identify two analytical problems.
- Create five queries per analytical problem (total of 10 queries), with at least two requiring data integration.
- Design one query requiring an additional data source without changing the business process.
- Design one query requiring additional data, necessitating changes in the business processes.

## Lab 2: Data Sources Generator

Lab 2 focused on implementing schemas for a relational database and developing a data generator.

### Tasks:
- Implement two schemas for the relational database in **MS SQL Server**..
- Develop a data generator in **Python** using the **Faker** and **Pandas** libraries to create the necessary data.
- Use SQL scripts with BULK loading to generate two data snapshots (T1 and T2), where T1 is loaded first, and T2 includes new tuples and changes in dimension elements.
- Ensure data from both snapshots allows integration using the same business keys.

## Lab 3: Data Warehouse Design

Lab 3 focused on designing a data warehouse based on specified requirements, documented in `Data_Warehouse_Design.pdf`.

### Tasks:
- Design a data warehouse for the given business process.
- Ensure all 10 analytical queries can be executed and that necessary data is available.
- Verify that data sources contain data needed for the warehouse.
- Create a schema with multiple dimensions, at least one fact table, date/time dimensions, at least three measures, and one calculated measure.
- Use a correct schema type (star, snowflake, or constellation).
- Define attributes as numerical or character data types.
- Design at least one Slowly Changing Dimension (SCD) and one hierarchical dimension.

## Lab 4: Data Warehouse Implementation  

Lab 4 focused on implementing a data warehouse based on the designed schema using **MS SQL Server 2017** and **Visual Studio 2019**. The implementation involved configuring a relational database, defining a multidimensional model, and verifying analytical queries.  

### Tasks:  
- Create a relational database in **MS SQL Server Management Studio 2017** and restore the designed schema.  
- Implement a data warehouse for the given business process using **SQL scripts**.  
- Define a **multidimensional model** in **Visual Studio 2019** using Analysis Services.  
- Configure data sources and data views for integration.  
- Implement **fact tables and dimension tables**, and establish relationships.  
- Define **hierarchical dimensions and Slowly Changing Dimensions (SCDs)**.  
- Implement **calculated measures** and aggregation functions.  
- Create 10 analytical queries to ensure the data warehouse supports required analyses.  
- Process the OLAP cube and verify query execution in **SQL Server Management Studio (SSMS)**.  

## Lab 5: ETL Process Implementation  

Lab 5 focused on implementing the ETL process to load data into the data warehouse.

### Tasks:  
- Develop an ETL process in **MS SQL Server Integration Services (SSIS)** to load all data initially (T1), followed by new and updated data (T2).  
- Create **T-SQL scripts** for Date, Time, and Junk dimensions, along with other dimensions and facts.  
- Implement data loading into **Slowly Changing Dimensions (SCD) Type 2** for historical tracking.  
- Generate surrogate keys correctly during the loading process.  
- Ensure the SSIS flow includes "SQL SCRIPT EXECUTION" and "ANALYSIS SERVICES PROCESSING."  
- Include cube processing within the ETL workflow.  
- Display sample query results, showing changes between T1 and T2, including historical and current records.  

## Lab 6: MDX Queries  

Lab 6 focused on formulating and executing **MDX queries** and implementing **Key Performance Indicators (KPIs)** to meet business goals as defined in the requirements specification.

### Tasks:  
- Formulate and execute **MDX queries** based on the analytical problems outlined in the requirements specification, ensuring they include at least one calculated member, a WHERE clause, an MDX function operating on the dimension hierarchy, and the use of either Top… or Bottom… functions along with a numerical operation.  
- Implement at least two KPIs in Visual Studio Data Tools, ensuring that at least one KPI refers to the previous time period and any additional KPIs are formulated as necessary to meet business goals.  

## Lab 7: Data Warehouse Optimization  

Lab 7 focused on optimizing the data warehouse by examining different cube models **(ROLAP, MOLAP, HOLAP)** and aggregation design, as detailed in `Optimization_Report.pdf`.

### Tasks:  
- Use **SQL Server Profiler** to analyze **MDX** statements and identify performance issues.
- Compare query execution times for the three cube models **(ROLAP, MOLAP, HOLAP)** with and without aggregations.
- Test cube processing times for each model, checking the impact of aggregations.
- Discuss the results and compare them with theoretical expectations to understand performance differences.

## Lab 8: BI Dashboard  

Lab 8 focused on creating reports for Business Intelligence (BI) systems using **Power BI**. The implementation involved designing interactive and visually appealing dashboards to effectively communicate insights.

### Tasks:  
- Implement reports and queries as defined in the data warehouse specification document.  
- Create at least 8 pages of reports that present **KPIs** for different time periods, include a minimum of 8 different charts following best practices for data visualization, and ensure all reports are parametrizable, allowing users to choose the year of analysis.  
- Develop a main **BI dashboard** featuring the most important metrics and insights.
