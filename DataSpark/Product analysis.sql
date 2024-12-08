

 -- Store Performance
SELECT
    storekey,
    country,
    city,
    SUM(quantity * unit_price_usd) AS TotalSales,
    SUM(quantity) AS TotalQuantitySold,
    square_meters,
    DATEDIFF(CURDATE(), open_date) / 365 AS YearsSinceOpen,
    
    -- Define age groups for stores
    CASE
        WHEN DATEDIFF(CURDATE(), open_date) / 365 BETWEEN 1 AND 2 THEN '1-2 years'
        WHEN DATEDIFF(CURDATE(), open_date) / 365 BETWEEN 3 AND 5 THEN '3-5 years'
        WHEN DATEDIFF(CURDATE(), open_date) / 365 BETWEEN 5 AND 10 THEN '5-10 years'
        WHEN DATEDIFF(CURDATE(), open_date) / 365 > 10 THEN '10+ years'
        ELSE 'Less than 1 year'
    END AS StoreAgeGroup

FROM overall
GROUP BY storekey, country, city, square_meters, open_date
ORDER BY TotalSales DESC;

-- Geographical Analysis
SELECT
    storekey,
    o.country,
    o.state,
    o.city,
    o.continent,
    CASE
        WHEN o.square_meters BETWEEN 0 AND 500 THEN '0-500 sqm'
        WHEN o.square_meters BETWEEN 501 AND 1000 THEN '501-1000 sqm'
        WHEN o.square_meters BETWEEN 1001 AND 1500 THEN '1001-1500 sqm'
        WHEN o.square_meters BETWEEN 1501 AND 2000 THEN '1501-2000 sqm'
        WHEN o.square_meters BETWEEN 2001 AND 2500 THEN '2001-2500 sqm'
        WHEN o.square_meters > 2500 THEN '2500+ sqm'
        ELSE 'Unknown size'
    END AS StoreSizeGroup,
    SUM(o.quantity * o.unit_price_usd) AS TotalSales,
    COUNT(DISTINCT o.storekey) AS NumberOfStores,
    AVG(o.square_meters) AS AverageStoreSize,
    SUM(o.quantity) AS TotalQuantitySold
FROM overall o
GROUP BY storekey, o.country, o.state, o.city, o.continent, StoreSizeGroup
ORDER BY TotalSales DESC;
