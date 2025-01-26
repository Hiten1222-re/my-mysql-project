# Data cleaning 


select * from nashville_housing_data_2013_2016;

CREATE TABLE `clean_nashville` (
  `MyUnknownColumn` int DEFAULT NULL,
  `Unnamed: 0` int DEFAULT NULL,
  `Parcel ID` text,
  `Land Use` text,
  `Property Address` text,
  `Suite/ Condo   #` text,
  `Property City` text,
  `Sale Date` text,
  `Sale Price` int DEFAULT NULL,
  `Legal Reference` text,
  `Sold As Vacant` text,
  `Multiple Parcels Involved in Sale` text,
  `Owner Name` text,
  `Address` text,
  `City` text,
  `State` text,
  `Acreage` text,
  `Tax District` text,
  `Neighborhood` text,
  `image` text,
  `Land Value` text,
  `Building Value` text,
  `Total Value` text,
  `Finished Area` text,
  `Foundation Type` text,
  `Year Built` text,
  `Exterior Wall` text,
  `Grade` text,
  `Bedrooms` text,
  `Full Bath` text,
  `Half Bath` text,
  `row_no` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into clean_nashville
select *,row_number() over(partition by `Parcel ID`,`Land Use`,`Property Address`,`Sale Date`,`Sale Price`,
`Legal Reference`,`Owner Name`,Address,City,`Year Built`) roww
from nashville_housing_data_2013_2016;

delete from clean_nashville
where roww>1;

select * from clean_nashville;

update clean_nashville set
`Parcel ID`= trim(`Parcel ID`),
`Land Use`= trim(`Land use`),
`Property Address`=trim(`Property Address`),
`Sale Date`=trim(`Sale Date`),
`Sale Price`=trim(`Sale Price`),
`Legal Reference`=trim(`Legal Reference`),
`Owner Name`=trim(`Owner Name`),
Address=trim(address),
City=trim(City),
`Year Built`=trim(`year Built`);

select `Property Address`,`Address` from clean_nashville where `Property Address`like '0%' and
Address not like '0%';

select * from clean_nashville n1
join clean_nashville n2
	on n1.`Parcel ID`=n2.`Parcel ID`
    where n1.`Property address`='0' and n2.`Property address`<>'0';
    
    
update clean_nashville n1
join clean_nashville n2
	on n1.`Parcel ID`=n2.`Parcel ID`
    set n1.`property address`=n2.`property address`
    where n1.`Property address`='0' and n2.`Property address`<>'0';

update clean_nashville set `property address`=address
where `property address` like '0%' and address not like '0%' and address <> '';

select str_to_date(`sale date`,'%m/%d/%Y') from clean_nashville;

select convert(`sale date`,date) from clean_nashville;

update clean_nashville set `sale date`= convert(`sale date`,date);

alter table clean_nashville modify
column `Sale Date` date;

alter table clean_nashville
drop column MyUnknownColumn,
drop column `Unnamed: 0`,
drop column roww;