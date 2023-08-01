USE AdventureWorks2019
GO

DECLARE @CountryNames NVARCHAR(4000) = '';
DECLARE @SQLDinamico NVARCHAR(4000) = '';

SELECT @CountryNames += quotename(CountryRegionName)+','
FROM AdventureWorks2019.Sales.vIndividualCustomer
GROUP BY CountryRegionName

SET @CountryNames = substring(@CountryNames, 1, len(@CountryNames)-1)

SET @SQLDinamico = 'SELECT *
    FROM
        (SELECT
             CountryRegionName,
             StateProvinceName,
             BusinessEntityID
         FROM AdventureWorks2019.Sales.vIndividualCustomer)as tabular
    PIVOT (
            count (BusinessEntityID)
            FOR CountryRegionName
            IN('+ @CountryNames +')
            ) as NewPivot'

EXEC (@SQLDinamico)

