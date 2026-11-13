create database world_layoffs;

use world_layoffs;

select * from layoffs;

-- 1. Now when we are data cleaning we usually follow a five steps 
-- 2. Check for duplicates and remove any
-- 3. Standerdiz data and fix errors
-- 4. Look at null values and see what
-- 5. Remove any column and rows that are not neccesary

-- Remove duplicates 

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert into layoffs_staging 
select * from layoffs;

with duplicate_cte as
(
select *,
row_number() over(partition by company, location, industry, total_laid_off,  percentage_laid_off, 'date', stage, country,funds_raised_millions ) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num >1;

select * from layoffs_staging where company = 'Yahoo';
select * from layoffs_staging where company = 'Hibob';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   row_num int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging2
select *,
row_number() over(partition by company, location, industry, total_laid_off,  percentage_laid_off, 
'date', stage, country,funds_raised_millions ) as row_num
from layoffs_staging;

select * from layoffs_staging2;

select * from layoffs_staging2
where row_num > 1;

delete from layoffs_staging2
where row_num > 1;\

select * from layoffs_staging2
where row_num > 1;

-- check null values

select * from layoffs_staging2
where industry is null or industry ='';

select * from layoffs_staging2
where company = 'Airbnb';

select * from layoffs_staging2
where company = 'Juul';


update layoffs_staging2
set industry = null   -- it will set null where industry is blank 
where industry = '';

select * from layoffs_staging2 t1 
join layoffs_staging2 t2 
on t1.company= t2.company
where t1.industry is null
and t2.industry is not null; 


update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company 
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select * from layoffs_staging2
where company = 'Airbnb';

select * from layoffs_staging2
where company = 'Juul';

select * from layoffs_staging2
where company = 'Carvana';

select distinct industry from layoffs_staging2
order by 1; 


select * from layoffs_staging2
where industry like 'Crypto%'
order by 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry from layoffs_staging2
order by 1; 

select distinct country from layoffs_staging2
order by 1;

update layoffs_staging2
set country = 'United states'
where country like 'United States%';

select distinct country from layoffs_staging2
order by 1;

-- covert date columns data type into date type :

select date,
str_to_date(date,  '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2 
set date = str_to_date(date,  '%m/%d/%Y');

alter table layoffs_staging2
modify column date date;

select date from layoffs_staging2;

-- null values 

select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 

delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 

select * from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;

select * from layoffs_staging2;
