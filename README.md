SQL Data Analysis: Global Layoffs Data

Introduction

This project involves a comprehensive data cleaning and exploratory data analysis (EDA) using SQL on a dataset related to company layoffs. The objective is to extract meaningful insights from the layoff data, identify trends, and understand the impact of various factors such as industry, country, funding stage, and time on the number of layoffs. This repository contains the SQL script used for data manipulation and analysis, designed for a MySQL environment.

Objective
The primary objectives of this SQL project are:

To perform robust data cleaning and standardization to ensure data quality and consistency.

To conduct an exploratory data analysis (EDA) using SQL queries to uncover patterns and trends in layoff data.

To identify industries, countries, and companies most affected by layoffs.

To analyze the distribution of layoffs across different time periods and funding stages.

To derive actionable insights that highlight key characteristics and impacts within the global layoff landscape.

Implementation Steps
The SQL FIRST PROJECT CC.sql script outlines the entire workflow, which includes the following key steps:

Data Loading and Table Creation:

Created a new table layoffs2 with an initial row_num column to facilitate duplicate identification.

Inserted data from the original layoffs table into layoffs2.

Duplicate Removal:

Identified and removed duplicate rows based on company, industry, total_laid_off, percentage_laid_off, and date using a Common Table Expression (CTE) and ROW_NUMBER().

Data Standardization:

Trimmed leading/trailing spaces from the company column.

Standardized industry values (e.g., converted "Crypto%" to "Crypto").

Cleaned country values by removing trailing dots (e.g., "United States." to "United States").

Converted the date column from text to date format using STR_TO_DATE and ALTER TABLE.

Handling Null and Blank Values:

Converted blank industry fields to NULL.

Populated NULL industry values by joining layoffs2 on itself based on company and location where a non-null industry existed for the same company/location.

Deleted rows where both total_laid_off and percentage_laid_off were NULL, as these entries provided no meaningful layoff data.

Column Removal:

Dropped the temporary row_num column after duplicate removal was complete.

Exploratory Data Analysis (EDA) Queries:

Executed a series of analytical queries to extract insights, including total layoffs by country, industry, company, average percentage laid off by industry, layoffs per funding stage, and temporal analysis.

Results
The SQL analysis yielded several key quantitative insights into the layoff data:

Top Countries by Total Layoffs (Top 10):

United States: Largest sum of total laid off employees.

India: Second largest sum of total laid off employees.

Netherlands, Sweden, United Kingdom, Canada, Brazil, Germany, Australia, Singapore also featured in the top 10 with significant layoff numbers.

Industries with Highest Layoffs:

Consumer: Showed the highest sum of total laid off employees.

Retail: Followed by Consumer in terms of total layoffs.

Other highly affected industries include Financial, Healthcare, and Marketing.

Companies with Over 5000 Layoffs:

Identified specific companies where total_laid_off exceeded 5000 employees.

Average Percentage of Workforce Laid Off by Industry:

Queries calculated the average percentage_laid_off for each industry, revealing industries that, on average, laid off a larger proportion of their workforce.

Total Layoffs Across All Companies:

The sum of total_laid_off across all companies was calculated, providing a grand total of employees affected by layoffs in the dataset.

Layoffs by Funding Stage:

The distribution of layoffs across stages like 'Post-IPO', 'Series B', 'Acquired', etc., was quantified, showing which stages experienced more layoff events.

Top Countries by Funds Raised (Top 10):

Identified countries that had companies with the highest sum of funds_raised_millions.

Layoffs with Missing Percentage Laid Off:

Listed companies where percentage_laid_off was NULL but total_laid_off existed.

Layoffs in 2023:

A specific query calculated the COUNT(*) of layoffs that occurred in the year 2023.

Highest Average Percentage Laid Off by Country (Top 10):

Calculated the average percentage_laid_off rounded for each country, ordered descending to show which countries had companies with the highest average proportion of workforce laid off.

Layoffs Across Different Locations (Cities):

Counted the number of layoff events per location, showing the distribution across various cities.

Top 5 Industries with Most Funds Raised and Layoffs:

Identified industries that raised significant funds (sum(funds_raised_millions)) and also experienced layoffs (where total_laid_off > 0).

Maximum Layoff Figures:

Queries found the MAX(total_laid_off) and MAX(percentage_laid_off) in the dataset.

Layoff Date Range:

Determined the MIN(date) and MAX(date) to establish the full span of the layoff data.

Total Layoffs by Year:

Aggregated sum(total_laid_off) by year(date), providing a yearly breakdown of layoffs.

Layoffs by Industry and Stage:

Provided a breakdown of total layoffs grouped by both industry and stage.

These results offer a clear quantitative picture of the layoff trends and patterns within the analyzed dataset, providing valuable insights for stakeholders.

Contact Information
For any questions, discussions, or potential collaborations on this project, please feel free to connect:

Name: Pranjal Joshi

Email: pranjaljoshi2811@gmail.com

GitHub: https://github.com/pranjal2811

LinkedIn: https://www.linkedin.com/in/pranjaljoshi2811
