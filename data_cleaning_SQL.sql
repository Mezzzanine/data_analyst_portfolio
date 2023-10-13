/* Convert text field type to Date, Float, Integer field types
Columns affected: 
SalePrice
SaleDate
LandValue
BuildingValue
TotalValue
YearBuilt
Bedrooms
FullBath
HalfBath
OwnerName
*/

SELECT
	SaleDate,
	CONVERT(SaleDate, DATE)
FROM
	nashville_housing;

alter table nashville_housing
change SaleDate SaleDate DATE null;

alter table nashville_housing
change SalePrice SalePrice float NULL,
change LandValue LandValue float NULL,
change BuildingValue BuildingValue float NULL,
change TotalValue TotalValue float NULL,
change YearBuilt YearBuilt int NULL,
change Bedrooms Bedrooms int NULL,
change FullBath FullBath int NULL,
change HalfBath HalfBath int NULL,
change OwnerName OwnerName varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL;

select 
	Acreage,
	replace(Acreage, ",",".")
from nashville_housing;

update nashville_housing
set Acreage = replace(Acreage, ",",".");

select 
	distinct(Acreage),
	count(Acreage)
from nashville_housing
group by 1
order by 2 desc;

ALTER TABLE nashville_housing
CHANGE Acreage Acreage float NULL;


-- Convert empty values in Null values

SELECT *
from nashville_housing
where PropertyAddress IS NULL;

SELECT *
from nashville_housing
where BuildingValue = '';

UPDATE nashville_housing 
SET Acreage = NULLIF(Acreage, '');

UPDATE nashville_housing 
SET HalfBath = NULLIF(HalfBath, '');

/*
	SalePrice,
	LandValue,
	BuildingValue,
	TotalValue,
	Bedrooms,
	YearBuilt,
	FullBath,
	HalfBath
*/

-- Populate Adress with null values from rows that has it using ParcelId column

SELECT 
	a.ParcelID, 
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	COALESCE (a.PropertyAddress,b.PropertyAddress)
from 
	nashville_housing a
join 
	nashville_housing b
	on a.ParcelID = b.ParcelID
	and a.UniqueID != b.UniqueID
where a.PropertyAddress IS NULL;

UPDATE nashville_housing a
join nashville_housing b 
	on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
SET a.PropertyAddress = COALESCE (a.PropertyAddress, b.PropertyAddress)
where a.PropertyAddress IS NULL;

-- Split combined Adress into City and Adress columns

SELECT 
SUBSTRING(PropertyAddress, 1, LOCATE(",", PropertyAddress)-1) as New_Adress,
SUBSTRING(PropertyAddress, LOCATE(",", PropertyAddress)+1, LENGTH(PropertyAddress)) as City
FROM nashville_housing;

ALTER TABLE nashville_housing
add PropertySplitAddress nvarchar(255);

UPDATE nashville_housing
 SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(",", PropertyAddress)-1);

ALTER TABLE nashville_housing
add PropertySplitCity nvarchar(255);

UPDATE nashville_housing
 SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(",", PropertyAddress)+1, LENGTH(PropertyAddress));

-- Split owner adress column into 3 columns : Owner Adress, Owner City, Owner State

SELECT OwnerAddress
FROM nashville_housing;

SELECT
OwnerAddress,
SUBSTRING_INDEX(OwnerAddress,',',1) as owner_addres,
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',',2) ,',',-1) as owner_city,
SUBSTRING_INDEX(OwnerAddress,',',-1) as owner_state
FROM nashville_housing;

ALTER TABLE nashville_housing
add OwnerSplitAddress nvarchar(255);

UPDATE nashville_housing
 SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress,',',1);

ALTER TABLE nashville_housing
add OwnerSplitCity nvarchar(255);

UPDATE nashville_housing
 SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',',2) ,',',-1);

ALTER TABLE nashville_housing
add OwnerSplitState nvarchar(255);

UPDATE nashville_housing
 SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress,',',-1);

-- Change Y to Yes and N to No for consistency

SELECT 
	DISTINCT(SoldAsVacant),
	COUNT(SoldAsVacant)
FROM nashville_housing
group by SoldAsVacant
order by 2 DESC;

SELECT 
	SoldAsVacant,
	CASE
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end
FROM nashville_housing;

update nashville_housing
set SoldAsVacant = 
	CASE
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end;

-- Remove duplicates using temp table

create table duplicates_temp
select *, 
	row_number() over(
	partition by 
		ParcelID,
		PropertyAddress,
		SalePrice,
		SaleDate,
		LegalReference		
		order by
			UniqueID
			) as row_num
from nashville_housing
order by ParcelID;

select *
from nashville_housing nh
left join duplicates_temp t
on t.UniqueID = nh.UniqueID
where t.row_num > 1;

delete nh
from nashville_housing nh
right join duplicates_temp t
on t.UniqueID = nh.UniqueID
where t.row_num > 1;

drop table duplicates_temp;

-- Delete useles columns

select *
from nashville_housing;

alter table nashville_housing
drop column OwnerAddress;

alter table nashville_housing
drop column PropertyAddress;

alter table nashville_housing
drop column TaxDistrict;

alter table nashville_housing
drop column SaleDate;

-- Clean wrong caracters in prices

select 
	SalePrice
	-- LandValue,
	-- BuildingValue,
	-- TotalValue
from nashville_housing
where SalePrice like '%.%'
order by SalePrice;

update nashville_housing
set	SalePrice = trim("$" from SalePrice)
where SalePrice like '$%';

select
	SalePrice,
	SUBSTRING_INDEX(SalePrice,'.',1) as first_part,
	SUBSTRING_INDEX(SUBSTRING_INDEX(SalePrice,'.',2),'.',-1) as second_part,
	SUBSTRING_INDEX(SalePrice,'.',-1) as third_part,
	concat(SUBSTRING_INDEX(SalePrice,'.',1), SUBSTRING_INDEX(SUBSTRING_INDEX(SalePrice,'.',2),'.',-1), SUBSTRING_INDEX(SalePrice,'.',-1))
from nashville_housing
where SalePrice like '%.%.%';

update nashville_housing
set	SalePrice = concat(SUBSTRING_INDEX(SalePrice,'.',1), SUBSTRING_INDEX(SUBSTRING_INDEX(SalePrice,'.',2),'.',-1), SUBSTRING_INDEX(SalePrice,'.',-1))
where SalePrice like '%.%.%';

select
	SalePrice,
	SUBSTRING_INDEX(SalePrice,'.',1) as first_part,
	SUBSTRING_INDEX(SalePrice,'.',-1) as third_part,
	concat(SUBSTRING_INDEX(SalePrice,'.',1), SUBSTRING_INDEX(SalePrice,'.',-1))
from nashville_housing
where SalePrice like '%.%';

update nashville_housing
set	SalePrice = concat(SUBSTRING_INDEX(SalePrice,'.',1), SUBSTRING_INDEX(SalePrice,'.',-1))
where SalePrice like '%.%';

select 
	SalePrice,
	LandValue,
	BuildingValue,
	TotalValue
from nashville_housing
where 
	SalePrice like '%.%'
	or SalePrice like '$%'
	or LandValue like '%.%'
	or LandValue like '$%'
	or BuildingValue like '%.%'
	or BuildingValue like '$%'
	or TotalValue like '%.%'
	or TotalValue like '$%'
order by SalePrice;

select YearBuilt
from nashville_housing
where YearBuilt is not null
order by YearBuilt;
