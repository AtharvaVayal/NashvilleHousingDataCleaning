select *
from ProtfoiloProject.dbo.NashvilleHosuing


select SaleDateConverted ,CONVERT(Date,SaleDate)
from ProtfoiloProject.dbo.NashvilleHosuing

update NashvilleHosuing
Set SaleDate = CONVERT(Date,SaleDate)   


Alter Table NashvilleHosuing
Add SaleDateConverted Date

update NashvilleHosuing
Set SaleDateConverted= CONVERT(date,SaleDate)



select *
from ProtfoiloProject.dbo.NashvilleHosuing
--where PropertyAddress is null 
order by ParcelID


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from ProtfoiloProject.dbo.NashvilleHosuing a
join ProtfoiloProject.dbo.NashvilleHosuing b
    on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
SET PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from ProtfoiloProject.dbo.NashvilleHosuing a
join ProtfoiloProject.dbo.NashvilleHosuing b
    on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


Select PropertyAddress
from ProtfoiloProject.dbo.NashvilleHosuing
--where PropertyAddress is null 
--order by ParcelID

Select
SUBSTRING(PropertyAddress , 1,CHARINDEX(',', PropertyAddress) -1) as Address 
,SUBSTRING(PropertyAddress ,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address 
from ProtfoiloProject.dbo.NashvilleHosuing

ALTER TABLE NashvilleHosuing 
Add PropertySpiltAddress Nvarchar(255);

Update NashvilleHosuing 
Set PropertySpiltAddress = SUBSTRING(PropertyAddress , 1,CHARINDEX(',', PropertyAddress) -1)


Alter Table NashvilleHosuing
Add PropertySpiltCity varchar(255);

update NashvilleHosuing
Set PropertySpiltCity = SUBSTRING(PropertyAddress ,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

select *
From ProtfoiloProject.dbo.NashvilleHosuing


Select OwnerAddress
from ProtfoiloProject.dbo.NashvilleHosuing

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from ProtfoiloProject.dbo.NashvilleHosuing 

ALTER TABLE NashvilleHosuing 
Add OwnerSpiltAddress Nvarchar(255);

Update NashvilleHosuing 
Set OwnerSpiltAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHosuing 
Add OwnerSpiltCity Nvarchar(255);

Update NashvilleHosuing 
Set OwnerSpiltCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHosuing 
Add OwnerSpiltState Nvarchar(255);

Update NashvilleHosuing 
Set OwnerSpiltState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select *
from ProtfoiloProject.dbo.NashvilleHosuing

update  NashvilleHousing 
from ProtfoiloProject.dbo.NashvilleHosuing



select distinct(SoldAsVacant), count(SoldAsVacant) 
from ProtfoiloProject.dbo.NashvilleHosuing
group by SoldAsVacant
order by 2

select SoldAsVacant
,  CASE WHEN SoldAsVacant = 'Y' then 'Yes'
       WHEN SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant
	   End
from ProtfoiloProject.dbo.NashvilleHosuing

update NashvilleHosuing
SET SoldAsVacant =CASE WHEN SoldAsVacant = 'Y' then 'Yes'
       WHEN SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant
	   End
from ProtfoiloProject.dbo.NashvilleHosuing




With RowNumCTE As(
Select *,
    ROW_NUMBER() Over(
	PARTITION by ParcelId,
	             PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 ORDER BY
				    UniqueID
					)row_num
from ProtfoiloProject.dbo.NashvilleHosuing
)
SELECT *
from RowNumCTE 
where row_num > 1
order by PropertyAddress


select *
from ProtfoiloProject.dbo.NashvilleHosuing

alter table ProtfoiloProject.dbo.NashvilleHosuing
drop column SaleDate,TaxDistrict,OwnerAddress,PropertyAddress