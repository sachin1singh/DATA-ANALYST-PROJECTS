

--Cleaning Data in SQL Queries

Select * From NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------
--Standardize Date Format

Select SaleDateConverted,CONVERT(Date,SaleDate) From NashvilleHousing

Update NashvilleHousing
Set SaleDate =CONVERT(Date,SaleDate)

Alter table NashvilleHousing
Add SaleDateConverted Date;


Update NashvilleHousing
Set SaleDateConverted =CONVERT(Date,SaleDate)


----------------------------------------------------------------------------------------------------------------------------
--Populate property Address Data

Select *From NashvilleHousing
Where PropertyAddress is NUll

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
     on a.ParcelID =b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NUll

--now the column created will be updated in null value with same parcel id

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
JOIN NashvilleHousing b
      on a.ParcelID =b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NUll

----------------------------------------------------------------------------------------------------------------------------
--Breaking out Address into individual columns (Address,City, State)

Select PropertyAddress From NashvilleHousing

Select 
SUBSTRING(PropertyAddress , 1 ,CHARINDEX(',' , PropertyAddress) -1)as Address
,SUBSTRING(PropertyAddress ,CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress)) as Address
from NashvilleHousing


Alter table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);


Update NashvilleHousing
Set PropertySplitAddress =SUBSTRING(PropertyAddress , 1 ,CHARINDEX(',' , PropertyAddress) -1)

Alter table NashvilleHousing
Add PropertySplitCity Nvarchar(255);


Update NashvilleHousing
Set PropertySplitCity =SUBSTRING(PropertyAddress ,CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress))



Select OwnerAddress From NashvilleHousing


Select 
PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,3)
,PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,2)
,PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,1)
From NashvilleHousing


Alter table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress =PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,3)



Alter table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,2)



Alter table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState =PARSENAME(REPLACE(OwnerAddress, ',' , '.' ) ,1)


Select *From NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------
--Change Y and N to Yes and No in"Sold as Vacant" field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,Case when SoldAsVacant ='Y' then 'Yes'
	  when SoldAsVacant ='N' then 'No'
      Else SoldAsVacant 
	  End
from NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant=Case when SoldAsVacant ='Y' then 'Yes'
	  when SoldAsVacant ='N' then 'No'
      Else SoldAsVacant 
	  End

----------------------------------------------------------------------------------------------------------------------------
--Remove Duplicates

With RowNumCTE AS(
Select *, 
	ROW_NUMBER() over(
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDAte,
				 LegalReference
				 Order by 
				 UniqueID
				 ) row_num
from NashvilleHousing
--order by ParcelID
)
Select * 
from RowNumCTE
where row_num>1
order by PropertyAddress

--we deleted dup. with this and above select ststement is for seeing executed query , only my mistake is that i did it with raw data need to create a copy first
--Delete 
--from RowNumCTE
--where row_num>1



----------------------------------------------------------------------------------------------------------------------------
--Delete Unused Columns

Select * from NashvilleHousing

Alter table NashvilleHousing
drop column OwnerAddress , TaxDistrict , PropertyAddress

Alter table NashvilleHousing
drop column SaleDate