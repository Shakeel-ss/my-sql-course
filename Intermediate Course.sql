-- standard select / where / order by
SELECT
    ps.PatientId
    , ps.Hospital
    , PS.Ward
    , ps.AdmittedDate
    , ps.DischargeDate
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    , DATEADD(WEEK, 2, ps.AdmittedDate) AS ReminderDate
    , ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
AND ps.Tariff > 5
ORDER BY
    ps.AdmittedDate DESC,
    ps.PatientId DESC

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    , ps.Hospital
    ,h.Hospital
    ,h.HospitalSize
FROM PatientStay ps LEFT JOIN DimHospitalBad h ON ps.Hospital = h.Hospital

SELECT
    p.PropertyType
    ,COUNT(*) AS NumberOfSales
FROM
    PricePaidSW12 p
GROUP BY p.PropertyType
ORDER BY NumberOfSales DESC;
 
 SELECT
    YEAR(p.TransactionDate) AS TheYear
    ,COUNT(*) AS NumberOfSales
    , SUM(p.Price) /1000000.0 As MarketValue
FROM
    PricePaidSW12 p
GROUP BY YEAR(p.TransactionDate)
ORDER BY TheYear;
 
 -- List all the sales in 2018 between £400,000 and £500,000 in Cambray Road (a street in SW12)
SELECT
    p.TransactionDate
    ,p.Price
    ,p.Street
    ,p.County
FROM
    PricePaidSW12 p
WHERE
    p.Street = 'Cambray Road'
    AND p.Price BETWEEN 400000 AND 500000
    AND p.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY p.TransactionDate;

-- List all the sales in 2018 between £400,000 and £500,000 in Cambray Road (a street in SW12)
SELECT
    p.TransactionDate
    ,p.Price
    ,p.Street
    ,p.County
FROM
    PricePaidSW12 p
WHERE
    p.Street IN ('Cambray Road', 'Midmoor Road')
    AND p.Price > 400000
    AND p.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY p.TransactionDate;
 
-- Homework Part 1

SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
FROM
    PricePaidSW12 AS p left JOIN PropertyTypeLookup as pt ON p.PropertyType = pt.PropertyTypeName
WHERE Street = 'Ormeley Road'
ORDER BY TransactionDate DESC

/* Homework Part 2
There is a table named PropertyTypeLookup .  This has columns PropertyTypeCode  and PropertyTypeName.  The values in PropertyTypeCode  match those in the PropertyType column of The PricePaidSW12 table.   The values in PropertyTypeName are the full name of the property type e.g. Flat, Terraced
 
Write a SQL query that joins on table  PropertyTypeLookup to include column PropertyTypeName in the result.
*/

 SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
FROM
    PricePaidSW12 AS p
WHERE Street = 'Ormeley Road'  -- a very nice street in Balham
ORDER BY TransactionDate DESC

 SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
    , CASE p.PropertyType  -- simple
        WHEN 'F' THEN 'Flat'
        WHEN 'T' THEN 'Terraced'
        ELSE 'Unknown'
    END AS PropertyTypeNameSimple
    , CASE -- Searched
        WHEN p.PropertyType IN ('D', 'S', 'T') THEN 'Freehold'
        ELSE 'leasohold'
    END AS PropertyDuration
FROM
    PricePaidSW12 AS p
WHERE Street = 'Ormeley Road'  -- a very nice street in Balham
ORDER BY TransactionDate DESC
 
 