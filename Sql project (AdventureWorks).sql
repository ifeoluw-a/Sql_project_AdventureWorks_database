--1 For the Person.Address Table, extract the count of the unique cities in the data.
SELECT COUNT (DISTINCT city) AS unique_city_count
FROM Person.Address;

--2 For the Person.Address Table, extract the count of the unique postal code in the data.
SELECT COUNT (DISTINCT PostalCode) AS unique_postal_count
FROM Person.Address;

--3 Do you think each city matches with the postal code in the Person.Address table, write a query to show that its true or false
SELECT city, PostalCode,
CASE  
WHEN PostalCode LIKE '[0-9][0-9][0-9][0-9][0-9]' THEN 'True'
ELSE 'False'
END AS City_match
FROM Person.Address
GROUP BY city, PostalCode;;

--4 How many people have two addresses in the Person.Address table 
SELECT COUNT (*) AS people_with_2_addresses
FROM Person.Address
WHERE AddressLine1 IS NOT NULL AND AddressLine2 IS NOT NULL;

--5 From the Person.businessentityaddress table, do you think there are employees that have the same address, write a query to extract out the count of people living in the adresses and find the max count.
SELECT DISTINCT AddressLine1 , COUNT (AddressLine1) AS Count_
FROM Person.BusinessEntityAddress
JOIN Person.Address
ON Person.BusinessEntityAddress.AddressID =  Person.Address.AddressID
GROUP BY  AddressLine1

SELECT MAX (count_) num_of_people_
FROM (SELECT  DISTINCT AddressLine1 , COUNT (AddressLine1) AS Count_
FROM Person.BusinessEntityAddress
JOIN Person.Address
ON Person.BusinessEntityAddress.AddressID =  Person.Address.AddressID
GROUP BY  AddressLine1) AS max_


--6 From the Person.businessentityaddress table, groupby the addresstypeid and determine the type that occurs the most and the least too.
--Least
SELECT TOP 1 AddressTypeID, COUNT (AddresstypeID) AS address_count
FROM Person.BusinessEntityAddress
GROUP BY  AddressTypeID
ORDER BY  address_count;

--Most
SELECT TOP 1 AddressTypeID, COUNT (AddresstypeID) AS address_count
FROM Person.BusinessEntityAddress
GROUP BY  AddressTypeID
ORDER BY  address_count DESC;

--7 Perform any join operation on the Person.businessentityaddress and the Person.addresstype tables, then do number 6 again, group by the name column.
--Least
SELECT TOP 1  Name, PBA.AddressTypeID, COUNT (PAT.AddresstypeID) AS address_count
FROM Person.BusinessEntityAddress AS PBA
LEFT JOIN Person.AddressType AS PAT
ON PBA.AddressTypeID =  PAT.AddressTypeID
GROUP BY Name,  PBA.AddressTypeID
ORDER BY  address_count;

--Most
SELECT TOP 1 Name, PBA.AddressTypeID, COUNT (PAT.AddresstypeID) AS address_count
FROM Person.BusinessEntityAddress AS PBA
LEFT JOIN Person.AddressType AS PAT
ON PBA.AddressTypeID =  PAT.AddressTypeID
GROUP BY Name,  PBA.AddressTypeID
ORDER BY  address_count;

--8 Perform an inner join operation on the Person.Businessentitycontact table and the Person.contacttype tables. Determine the suitable column to perform the join operation and determine the top 5 contacttype name that occur most.
SELECT TOP 5 name,  count (name) AS most_occurred_name
FROM Person.BusinessEntityContact AS PBS
INNER JOIN Person.ContactType AS PCT
ON PBS.ContactTypeID = PCT.ContactTypeID
GROUP BY name
ORDER BY  most_occurred_name DESC;

--9  For the Person.CountryRegion table, determine the the countries names start with 'A’ and count them.
SELECT COUNT (*) AS countries_with_A
FROM Person.CountryRegion
WHERE name LIKE 'A%'

--10  For the Person.CountryRegion table, determine the the countries names start with ‘B’ and count them.
SELECT COUNT (*) AS countries_with_B
FROM Person.CountryRegion
WHERE name LIKE 'B%'

--11  For the Person.CountryRegion table, determine the the countries names start with ‘N’ and count them.
SELECT COUNT (*) AS countries_with_N
FROM Person.CountryRegion
WHERE name LIKE 'N%'

--12  For the Person.CountryRegion table, determine the the countries names start with ‘T’ and count them.
SELECT COUNT (*) AS countries_with_T
FROM Person.CountryRegion
WHERE name LIKE 'T%'

--13  For the Person.CountryRegion table, determine the the countries names start with ‘R’ and count them.
SELECT COUNT (*) AS countries_with_R
FROM Person.CountryRegion
WHERE name LIKE 'R%'

--14  For the Person.EmailAdress table, extract out the emails that have ‘micheal’ in the email address
SELECT EmailAddress
FROM Person.EmailAddress
WHERE EmailAddress LIKE '%micheal%'

--15  For the Person.Person table, determine the number of people who bear Mr, Mrs and other titles using your groupby and count.
SELECT Title, COUNT (Title) AS title_count
FROM Person.Person
WHERE Title IN ('Mr.','MS.', 'Mrs.') 
GROUP BY Title

--16 For the Person.Person table, determine the number of people that did not input their middle name I.e where the record is null.
SELECT  COUNT (*) AS Null_count
FROM Person.Person
WHERE MiddleName is NULL

--17 For the Person.PersonPhone table, write a subquery that would give only the result of the business entity ids where the phonenumber typeid occurs the most.
SELECT top 1 PhoneNumberTypeID
FROM Person.PersonPhone
GROUP BY PhoneNumberTypeID
ORDER BY COUNT (PhoneNumberTypeID) DESC

SELECT BusinessEntityID
FROM Person.PersonPhone
WHERE PhoneNumberTypeID = (SELECT  top 1 PhoneNumberTypeID
FROM Person.PersonPhone
GROUP BY PhoneNumberTypeID
ORDER BY COUNT (PhoneNumberTypeID) DESC) ;

--18  Perform an inner join on Person.CountryRegion and Sales.CountryRegionCurrency so we can see the country names, country abbreviation and country currency.
SELECT Name, PCR.CountryRegionCode, CurrencyCode
FROM Person.CountryRegion AS PCR
JOIN Sales.CountryRegionCurrency AS CRC
ON PCR.CountryRegionCode = CRC.CountryRegionCode

--19  From the Sales.CreditCard table, determine the credit ids whose expiry date is between july and october.
SELECT CreditCardID
FROM Sales.CreditCard
WHERE ExpMonth BETWEEN 7 AND 10;

--20  From the Sales.CreditCard table, determine the credit ids whose expiry date is between july and october and whose expiry year is between 2006 and 2008.
SELECT CreditCardID
FROM Sales.CreditCard
WHERE ExpMonth BETWEEN 7 AND 10 AND ExpYear BETWEEN '2006' AND '2008';

--21 . Perform a join on the Person.CountryRegion table, Sales.CountryRegionCurrency and the Sales.Currency table.
SELECT *
FROM Person.CountryRegion AS PCR
JOIN Sales.CountryRegionCurrency AS CRC
ON PCR.CountryRegionCode = CRC.CountryRegionCode
JOIN Sales.Currency AS SC
ON CRC.CurrencyCode = SC.CurrencyCode

--22 From the Sales.CurrencyRate table, what modified date was the Average rate of the ‘CAD’ currency the highest.
SELECT TOP 1 ModifiedDate, AverageRate
FROM Sales.CurrencyRate
WHERE ToCurrencyCode = 'CAD'
ORDER BY AverageRate DESC

--23 From the Sales.SalesOrderDetail table, which product id do people buy the most based on the order qty.
SELECT TOP 1 ProductID, COUNT (OrderQty) AS qty_count
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY qty_count DESC;

--24 From the Sales.SalesOrderDetail table, identify the products that have special offer ID greater than 12
SELECT ProductID, SpecialOfferID
FROM Sales.SalesOrderDetail
WHERE SpecialOfferID > 12

--25 From the Sales.SalesOrderDetail table, identify the most expensive product.
SELECT MAX (UnitPrice) AS most_expensive_product
FROM Sales.SalesOrderDetail

--26 Based on the Sales.SpecialOffer, what specialofferid has the highest DiscountPct.
SELECT SpecialOfferID, DiscountPct
FROM Sales.SpecialOffer
WHERE DiscountPct = (SELECT MAX (DiscountPct)
FROM Sales.SpecialOffer)

--27 Based on the Production.document table, what are the unique file extensions.
SELECT DISTINCT FileExtension
FROM Production.Document

--28 Based on the Production.document table, what are the count of the unique file extensions.
SELECT COUNT (*) AS unique_ext_count
FROM (SELECT DISTINCT FileExtension
FROM Production.Document) AS file_count

--29 Based on the Production.ProductInventory table, determine the records that have ‘frame’ in them.
SELECT ProductID, PPI.LocationID, name
FROM Production.ProductInventory AS PPI
JOIN Production.Location AS PL
ON PPI.LocationID = PL.LocationID
WHERE name LIKE '%frame%'

--30 Based on the Production.ScrapReason, what records contain ‘fail’ in the name column in the table.
SELECT *
FROM Production.ScrapReason
WHERE name LIKE '%fail%'


