-- Data Cleaning
use layoffs;

select * from layoffs;

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs2;

insert into layoffs2
select * ,
row_number() over (partition by company, industry,
total_laid_off, percentage_laid_off, 'date') as row_num
from layoffs;

select * from layoffs2;

-- 1 romove duplicates

select * from layoffs2
where row_num>1;

delete from layoffs2
where row_num>1;

select * from layoffs2;

-- 2 standardize the data

select company from layoffs2;

select company, trim(company) from layoffs2;

update layoffs2
set company= trim(company);

select company from layoffs2;

select industry from layoffs2
group by industry;

update layoffs2
set industry = "Crypto"
where industry like "Crypto%";

select distinct location
from layoffs2            -- check th issue there is no issue
order by 1;

select distinct country, trim(trailing '.'from country)
from layoffs2 
order by 1;

update layoffs2
set country= trim(trailing'.' from country)
where country like 'united states%';

select distinct country
from layoffs2
order by 1;

select `date`
from layoffs2;      -- check issue and change date format

update layoffs2 
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table  layoffs2
modify column `date` date ; -- modify the column from text to date

-- check null values
-- 3 null values or blank values

select *
from layoffs2
where industry is null -- 3 row in industry which have blank row
or industry = '';

update layoffs2 
set industry = null -- by update we change 3 blank rows with null
where industry ='';

select * 
from layoffs2 
where company like 'bally%';


select t1.industry, t2 .industry
from layoffs2 t1
join layoffs2 t2
on t1.company=t2.company
and t1.location=t2.location
where (t1.industry is null or t1.industry= '')
and t2.industry is not null;

update layoffs2 t1
join layoffs2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

select location from layoffs2;

select * from layoffs2;

select * 
from layoffs2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs2
where total_laid_off is null
and percentage_laid_off is null;


-- 4 romove any column


select * from layoffs2;

alter table layoffs2
drop column row_num;

-- exploratory analysis


--  1 how many layoffs happened per country?
select country, sum(total_laid_off)
as total_layoffs
from layoffs2
group by country
order by total_layoffs desc
limit 10;

-- 2 which industry faced the highest number of layoffs?

select industry, sum(total_laid_off)
as total_layoffs
from layoffs2
group by industry 
order by total_layoffs desc;

-- 3 which companies laid off more than certain threshold of employees (e,g 5000) 

select company, total_laid_off 
from layoffs2 
where total_laid_off>5000
order by total_laid_off desc; 

-- 4 what is the average percentage of workforce 

select industry, avg(percentage_laid_off) as avg_percentage_laid_off 
from layoffs2 
group by industry 
order by avg_percentage_laid_off desc;

-- 5 what are the top 10 companies with the most layoffs?

select company, total_laid_off 
from layoffs2
order by total_laid_off desc 
limit 10; 

-- 6 what is the total number of layoffs across all compaines ?

select sum(total_laid_off) AS total_offs 
from layoffs2;

-- 7 how many layoffs occured in each funding stage (e.g, Post-IPO, Series B )?

select stage, COUNT(*) as num_layoffs 
from layoffs2 
group by stage 
order by num_layoffs desc;


-- 8 which country raised the highest amount of funds ?
select country, sum(funds_raised_millions)
as total_fund_raised
from layoffs2
group by country
order by total_fund_raised desc
limit 10;


-- 9 which companies had layoffs with missing data for percentage laid off? 

select company, total_laid_off 
from layoffs2
where percentage_laid_off is null 
order by total_laid_off desc; 

-- 10 how many layoffs occurred in a specific time period (e.g. , 2023) ? 

select count(*) as layoffs_in_2023 
from layoffs2
where YEAR(date) = 2023; 

-- 11. which countries have the highest percentage of layoffs relative to their total workforce ? 

select country, round(avg(percentage_laid_off)) as avg_percentage_laid_off 
from layoffs2
group by country
order by avg_percentage_laid_off desc
limit 10; 

-- 12. what is the distribution of layoffs accross different locations (cities)? 

select location,count(*) as num_offs 
from layoffs2 
group by location;

-- 13 what are the top 5 industries that raised the most funds and had layoffs?

select industry, sum(funds_raised_millions)
as total_funds_raised
from layoffs2
where total_laid_off>0
group by industry 
order by total_funds_raised desc
limit 5;

-- 14 maxmium of total_laid_off and percentage_laid_off?

select max(total_laid_off), max(percentage_laid_off)
from layoffs2;

-- 15 layoffs from start date to end date?

select min(`date`), max(`date`)
from layoffs2;

-- 16 sum of total_laid_off by year?

select year(`date`), sum(total_laid_off)
from layoffs2
group by year(`date`)
order by 1 desc;

-- 17 show the layoffs by industry and break them down by comapany stage (e.g., post IPO, series B, etc.).

select industry, stage, sum(total_laid_off)
as total_layoffs
from layoffs2
group by industry, stage
order by industry;

-- excell data export

