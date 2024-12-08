
 -- Overall sales performance
SELECT
     DATE_FORMAT(order_date, '%y') AS Year,
     SUM(quantity * unit_price_usd) AS TotalSales,
     SUM(quantity) AS TotalQuantity
FROM overall
GROUP BY Year
ORDER BY Year;

-- Sales by product
SELECT
      product_name,
      SUM(quantity) AS TotalQuantitySold,
      SUM(quantity * unit_price_usd) AS TotalRevenue
FROM overall
GROUP BY product_name
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Sales by store
SELECT
       country,
       storekey,
       SUM(quantity * unit_price_usd) AS StoreTotalSales,
       SUM(quantity) AS StoreTotalQuantity
FROM overall 
GROUP BY country, storekey
ORDER BY country, StoreTotalSales DESC;

-- Sales by Currency
SELECT
      currency_code,
      SUM(quantity * unit_price_usd) AS TotalSalesInOriginalCurrency,
      SUM(quantity * unit_price_usd * exchange) AS TotalSalesInUSD,
      (SUM(quantity * unit_price_usd * exchange) - SUM(quantity * unit_price_usd)) AS SalesImpactFromExchangeRate,
      SUM(quantity) AS TotalQuantitySold
FROM overall
GROUP BY currency_code
ORDER BY TotalSalesInUSD DESC;

