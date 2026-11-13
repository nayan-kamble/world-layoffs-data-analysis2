-- Exploratory Data Analysis (EDA) using SQL 5 questions.

-- 1: Find the maximum layoffs
-- 2: Find companies with the highest layoffs
-- 3: Which industries were affected most?
-- 4: Which countries had the most layoffs?
-- 5: Analyze layoffs by year

-- 1:
select MAX(total_laid_off)
from layoffs_staging2;

-- 2:
select company, SUM(total_laid_off) as total_layoffs
from layoffs_staging2
group by company
order by total_layoffs desc
limit 10;

-- 3:
select industry, SUM(total_laid_off) as total_layoffs
from layoffs_staging2
group by industry
order by total_layoffs desc;

-- 4: 
select country, SUM(total_laid_off) as total_layoffs
from layoffs_staging2
group by country
order by total_layoffs desc;

-- 5:
select year(date) as year,
       SUM(total_laid_off) as total_layoffs
from layoffs_staging2
group by year(date)
order by year;