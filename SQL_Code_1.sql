SELECT * FROM sales_data.housing_in_london_yearly_variables;

-- 1. check for duplicates and remove any

SELECT
	code, area, date, median_salary, life_satisfaction, mean_salary, 
	recycling_pct, population_size, number_of_jobs, area_size, no_of_houses, borough_flag, 
COUNT(*) AS duplicate_count
FROM 
	sales_data.housing_in_london_yearly_variables
GROUP BY
	code, area, date, median_salary, life_satisfaction, mean_salary, 
	recycling_pct, population_size, number_of_jobs, area_size, no_of_houses, 
	borough_flag
HAVING 
	COUNT(*) > 1;
-- 	No duplicates found!

-- standardize data and fix errors


-- Checking for null data in first column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE `code` IS NULL 
OR `code` = ''
ORDER BY `code`;



-- Checking for null data in second column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE area IS NULL 
OR area = ''
ORDER BY area;



-- Checking for null data in third column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE `date` IS NULL 
OR `date` = ''
ORDER BY `date`;



-- Checking for null data in fourth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE `date` IS NULL 
OR `date` = ''
ORDER BY `date`;



-- Checking for null data in fifth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE median_salary IS NULL 
OR median_salary = ''
ORDER BY median_salary;


-- Checking for null data in sixth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE life_satisfaction IS NULL 
OR life_satisfaction = ''
ORDER BY life_satisfaction;

-- Seems like there are null values and I do not know what to fill them with, so I would drop the column as more than half of the entire rows are null.
ALTER TABLE sales_data.housing_in_london_yearly_variables
DROP COLUMN life_satisfaction;


-- Check the dataset
SELECT * FROM sales_data.housing_in_london_yearly_variables;



-- Checking for null data in seventh column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE mean_salary IS NULL 
OR mean_salary = ''
ORDER BY mean_salary;


-- Checking for null data in eight column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE recycling_pct IS NULL 
OR recycling_pct = ''
ORDER BY recycling_pct;
-- The result shows three rows with 0 as the input, I don't consider it null.





-- Checking for null data in ninth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE population_size IS NULL 
OR population_size = ''
ORDER BY population_size;



-- Checking for null data in tenth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE number_of_jobs IS NULL 
OR number_of_jobs = ''
ORDER BY number_of_jobs;

-- Since there are no jobs in the missing rows, I will replace with 0
UPDATE sales_data.housing_in_london_yearly_variables 
SET number_of_jobs = 0
WHERE number_of_jobs IS NULL;

-- It told me that I could not run the code without disabling safe mode, so I decided to do this:

-- Disable safe update mode for the current session

-- Since there are no jobs in the missing rows, I will replace with 0
SET SQL_SAFE_UPDATES = 0;

-- Now perform your update
UPDATE sales_data.housing_in_london_yearly_variables
SET number_of_jobs = 0
WHERE number_of_jobs IS NULL
OR number_of_jobs = '';

SET SQL_SAFE_UPDATES = 1;

-- Checking for null data in eleventh column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE area_size IS NULL 
OR area_size = ''
ORDER BY area_size;
-- There are alot of null columns, so I would replace with 0
SET SQL_SAFE_UPDATES = 0;

-- Now perform your update
UPDATE sales_data.housing_in_london_yearly_variables
SET area_size  = 0
WHERE area_size  IS NULL
OR area_size  = '';

SET SQL_SAFE_UPDATES = 1;


-- Checking for null data in  twelvth column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE no_of_houses IS NULL 
OR no_of_houses = ''
ORDER BY no_of_houses;


-- There are alot of null columns, so I would replace with 0
SET SQL_SAFE_UPDATES = 0;

-- Now perform your update
UPDATE sales_data.housing_in_london_yearly_variables
SET no_of_houses  = 0
WHERE no_of_houses  IS NULL
OR no_of_houses  = '';

SET SQL_SAFE_UPDATES = 1;


-- Checking for null data in  last column
SELECT *
FROM sales_data.housing_in_london_yearly_variables
WHERE borough_flag IS NULL 
OR borough_flag = ''
ORDER BY borough_flag;

-- The values are not null but, 0 indicated so I'll skip for now.




-- CHECKING FOR MULTIPLE VALUES
SELECT DISTINCT area 
FROM
sales_data.housing_in_london_yearly_variables;
-- They are all distinct

SELECT * 
FROM
sales_data.housing_in_london_yearly_variables;


-- ANALYSIS SECTION 
-- Questions I want to answer:
-- 1. Trend in Median Salary Over the Years for Boroughs?
-- 2.  How does the percentage of recycling in each borough correlate with the number of jobs in the year 2001?

-- What is the Trend in Median Salary Over the Years for Boroughs?
-- This question would help you understand how house prices have changed over time in different boroughs.

SELECT 
    borough_flag,
    YEAR(date) AS year,
    AVG(median_salary) AS avg_median_salary
FROM 
    sales_data.housing_in_london_yearly_variables
GROUP BY 
    borough_flag, 
    YEAR(date)
ORDER BY 
    borough_flag, 
    YEAR(date);


--  How does the percentage of recycling in each borough correlate with the number of jobs in the year 2001?
SELECT
    area AS borough_name,
    recycling_pct,
    number_of_jobs
FROM
    sales_data.housing_in_london_yearly_variables
WHERE
    date LIKE '2001-12-01'
ORDER BY
    recycling_pct DESC;  -- Sorting by recycling percentage can help in identifying trends


-- We have come to the end of my analysis