# First Data cleaning project using basic controls - select,insert,alter,update etc. 

select * from layoffs;

# Deleting the duplicates

CREATE TABLE `layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs3;

insert into layoffs3
select distinct * from layoffs;

# Standardising records and handling null and blank values
# Formatting column location
select distinct location from layoffs3;

update layoffs3 set location='Florianapolis'
where location='FlorianÃ³polis';

update layoffs3 set location='Dusseldorf'
where location='DÃ¼sseldorf'
;

update layoffs3 set location='Malmo'
where location='MalmÃ¶'
;

# Formatting column industry
select distinct industry from layoffs3 order by industry;

select * from layoffs3 where industry='';

select * from layoffs3 where company='Airbnb';

update layoffs3 set industry='Travel'
where industry='' and company='Airbnb';

select * from layoffs3 where company='Juul';

update layoffs3 set industry='Consumer'
where industry='' and company='Juul';

select * from layoffs3 where company='Carvana';

update layoffs3 set industry='Transportation'
where industry='' and company='Carvana';

update layoffs3 set industry='Crypto'
where industry like 'Crypto%';

update layoffs3 set industry='Other'
where isnull(industry);

# Formatting column country

select distinct country from layoffs3 order by country;

update layoffs3 set country='United States'
where country='United States.';

# Date here is in text format
# Firstly we will deal with values then with column type

update layoffs3 set `date`=str_to_date(`date`,'%m/%d/%Y');

alter table layoffs3 modify column `date` date;

# Removing unnecessary rows and cols

select * from layoffs3 where isnull(total_laid_off) and isnull(percentage_laid_off);

# main exploration of data would be done on total and percentage laid_off, so we will delete the rows which have null values in both of them

delete from layoffs3 where
total_laid_off is null
and percentage_laid_off is null;

# here our data is clean and ready for use to draw insights and making reports 
