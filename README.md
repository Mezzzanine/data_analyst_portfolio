# data_analyst_portfolio
That is a collection of works within Data Analysis

Table of contents
1. [Creation of Excel Interactive Dashboard](https://github.com/Mezzzanine/data_analyst_portfolio#creation-of-excel-interactive-dashboard)
2. [Cleaning data using SQL](https://github.com/Mezzzanine/data_analyst_portfolio#cleaning-data-using-sql)
3. Tableau [To be added]
4. Python [To be added]



## Creation of Excel Interactive Dashboard

<img width="945" alt="Screenshot 2023-10-10 at 10 41 20" src="https://github.com/Mezzzanine/data_analyst_portfolio/assets/19992624/e27fbe6f-5fb9-4abe-b960-316dd45b60d7">

To check the dashboard, please download and open a file [Retail_sales_dashboard.xlsx](https://github.com/Mezzzanine/data_analyst_portfolio/blob/main/Retail_sales_dashboard.xlsx)

### Purpose of the project

1. Create an interactive dashboard to monitor sales in e-commerce projects.
    1. Sales over time
    2. Average Order Value
    3. Product analysis
    4. Demographic analysis   
3. Showcase the abilities of a Data Analyst working with Excel and data in general


### Related Resources
- [Kaggle](https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset)
- [EU Countries list](https://github.com/ajturner/acetate/blob/master/places/Countries-Europe.csv)
- [Customer's Data](https://github.com/AlexTheAnalyst/Excel-Tutorial/blob/main/Excel%20Project%20Dataset.xlsx) by @AlexTheAnalyst

### Process
1. Download, store and organise resources in a folder locally
2. Cerate master XLS file and import all available raw and taxonomy data into the file
3. Clean raw data and perform the following checks:
    1. Data types 
    2. Duplicates using `Find Duplicates` feature
    3. Null values using `COUNTIF` function
    4. Unclear values (i.e. M and F in Gender column to Male and Female)
    5. Baised values (i.e. values outside of the expected range etc.)
4. Prepare the data
   1. Add bucketed age groups using the nested `IF` function
   2. Add the information about customers and countries to the main table using `VLOOKUP` function
   3. Since we don't have any country from the original dataset, I would like to assign it randomly.
      1. Add country IDs to the country table
      2. Add a country ID column and a random integer number within a range of the number of countries to the customer table using `RAND` and `INT` functions
      3. Add a new table Country Name and Lookup a country name from the table using `XLOOKUP` function
5. Create a dashboard
    1. Create multiple charts and slicers to be able to filter the data according to business needs

## Cleaning data using SQL

<img width="1006" alt="image" src="https://github.com/Mezzzanine/data_analyst_portfolio/assets/19992624/abc36034-8f3b-467e-a452-1896780982b6">

### Purpose of the project

1. Prepare data to be able to work with them in a database
2. Showcase my ability to clean and prepare a large dataset using SQL

### Related Resources

1. [Dataset](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Data%20Cleaning%20Portfolio%20Project%20Queries.sql) by @AlexTheAnalyst
2. [W3 School](https://www.w3schools.com/)
3. [Stackoverflow](https://stackoverflow.com/)

### Process

1. Convert text field type to Date, Float, and Integer field types
2. Convert empty values into Null values
3. Populate Adress with null values from rows that have it using the ParcelId column using the `SELF JOIN` statement
4. Split combined Adress into City and Adress columns using a combination of `LOCATE()` and `SUBSTRING()` clauses
5. Split the OwnerAdress column into 3 columns: OwnerAdress, OwnerCity, OwnerState 
6. Change Y to Yes and N to No for consistency using the `CASE` statement
7. Remove duplicates using a temporary table and window function `ROW_NUMBER()`
8. Delete useless columns
9. Clean wrong characters in prices using `TRIM()` and `CONCAT()`

### Tech stack
MySQL 8.1.0,
TablePlus
