# data_analyst_portfolio
That is a collection of works within Data Analysis

Table of contents
1. [Creation of Excel Interactive Dashboard](https://github.com/Mezzzanine/data_analyst_portfolio#creation-of-excel-interactive-dashboard)
2. [Cleaning data using SQL](https://github.com/Mezzzanine/data_analyst_portfolio#cleaning-data-using-sql)
3. [Visualising data using Looker](https://github.com/Mezzzanine/data_analyst_portfolio#visualising-data-using-google-looker-studio)
4. [Data scrapping, transformation with Python and visualisation with Tableau](https://github.com/Mezzzanine/data_analyst_portfolio/tree/main#popularity-of-german-names-from-1890-to-2018)


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

To check the SQL file please download it [data_cleaning_SQL.sql(https://github.com/Mezzzanine/data_analyst_portfolio/blob/main/data_cleaning_SQL.sql)

### Purpose of the project

1. Prepare data to be able to work with them in a database
2. Showcase my ability to clean and prepare a large dataset using SQL

### Related Resources

1. [Dataset](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx) by @AlexTheAnalyst
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

## Visualising Data using Google Looker Studio

<img width="772" alt="image" src="https://github.com/Mezzzanine/data_analyst_portfolio/assets/19992624/c7efd3b5-eec1-4984-999b-484807a5d10d">

[Dashboard link](https://lookerstudio.google.com/reporting/fd8679b4-f529-4012-b2cb-a89b0503b1d2)

### Purpose of the project

1. Create an interactive dashboard to monitor sales/inventory/staff in the Food Delivery project. And reflect the following items, that imaginable client would like to check:
    1. Order activity
        1. Total orders
        2. Total sales
        3. Total items
        4. Average order value
        5. Sales by category
        6. Top selling items
        7. Orders by hour
        8. Sales by hour
        9. Orders by address
        10. Orders by delivery/pick up
    3. Inventory
        1. Wants to be able to know when it's time to order new stock.
            1. What ingredients go into each pizza their quantity is based on the size of the pizza.
            2. The existing stock level.
    5. Staff
        1. Wants to know which staff members are working when.
        2. Based on the staff salary information, how much does each pizza cost (ingredients+chefs+delivery)?
3. Showcase the abilities of a Data Analyst working with MySQL/MariaDB database, SQL and Google Looker Studio.


### Related Resources

- [Tutorial](https://www.youtube.com/watch?v=0rB_memC-dA) by Adam Finer
- [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
- [Looker Studio Documentation](https://cloud.google.com/looker/docs)

### Process

1. Create a client brief and define the initial data structure from it in Excel.
2. Create an architecture of a relational database using the [QDB Diagram tool](https://app.quickdatabasediagrams.com/#/d/JJxpxx). This process includes defining Primary and Foreign keys for each table and also data types.
3. Create a database on a dedicated server. I chose MariaDB due to the ease of installation on *nix systems and the fact of being familiar with administrative parts and syntaxis similar to MySQL.
4. Create users to manage the data and work with external data consumers (Google Looker Studio).
5. Create a table structure in the database and assign correct datatypes to columns using `CREATE TABLE`, `ALTER TABLE` etc
6. Populate tables with data using CSV export.
7. Following the client brief create specific views with SQL queries to provide necessary data to the dashboard data.
    1. Orders. Aggregate all the necessary data from different tables in one view using `JOIN` statement
    2. Staff. Aggregate the data from multiple tables using `JOIN` and calculate Staff Cost and Hours in Shift metrics using `HOUR` and `MINUTE` clause
    3. Stock. Aggregate all the necessary information for calculating stocks and inventory using CTE, calculations and `JOIN` features
9. Connecting the database data source to Looker Studio as a resource.
10. Create and customise dashboards to meet project requirements.

### Tech stack
Ubuntu 23.04
MariaDB 10.11.2
TablePlus
QDB
Looker Studio

## Popularity of German Names from 1890 to 2018

### Purpose of the project

Living in Germany with a complicated-to-pronounce name could be a personal challenge. So I thought to change the name to something more international, but common in Germany. To to that, I would need to understand what names were common in Germany and in what period of time.

![ezgif-7-017b9ae246](https://github.com/Mezzzanine/data_analyst_portfolio/assets/19992624/f7e35db0-1807-41af-8ce0-e08b12151617)

[Visualisation link](https://public.tableau.com/app/profile/sergei.levkov/viz/PopularityofGermanNames/PopularityofGermannames)

### Process

1. First I need to get the data. I checked several open data resources like Government Databases, Kaggle and so on, but didn't find any data that fully represented the time period and data quality I needed.
2. I decided to search on the internet and found a [website](https://www.beliebte-vornamen.de/) that publicized the top 25 names split by year and gender
    1. I wrote a web scrapper using [Python](https://github.com/Mezzzanine/data_analyst_portfolio/blob/main/names.py) to collect the data from the website and format it as I needed.
    2. As a result I had a CSV file with needed data. 
3. To create a viz I also needed data about the population or the number of newborn children.
    1. I downloaded the dataset from the Government website
    2. I wrote a [Python](https://github.com/Mezzzanine/data_analyst_portfolio/blob/main/population.py) script to populate this information into the CSV
        1. Calculation of the distribution of population around the placement. Since I had only data related to placement I would need to estimate how many people could have a name from the 1st place to the second etc.
        2. I used a hyperbolic function to estimate the number of names that were given to children in respective years and gender. 
4. Visualisation in Tableau
    1. Create the race bar chart to illustrate how the number of names changes over time using running sum and ranking functions

### Tech stack
Python 3
Tableau
