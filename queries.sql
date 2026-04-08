-- Query 1
SELECT *
FROM output_db.raw
LIMIT 10;

-- Query 2
SELECT
    category,
    COUNT(DISTINCT "order id") AS total_orders
FROM output_db.raw
GROUP BY category
ORDER BY total_orders DESC
LIMIT 10;

-- Query 3
SELECT
    fulfilment,
    COUNT(DISTINCT "order id") AS total_orders,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(amount), 2) AS total_revenue
FROM output_db.raw
WHERE LOWER(status) NOT LIKE '%cancel%'
  AND LOWER(status) NOT LIKE '%pend%'
GROUP BY fulfilment
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 4
SELECT
    date_format(date_parse(date, '%m-%d-%y'), '%Y-%m') AS sales_month,
    COUNT(DISTINCT "order id") AS total_orders,
    ROUND(SUM(amount), 2) AS total_revenue
FROM output_db.raw
WHERE LOWER(status) NOT LIKE '%cancel%'
  AND LOWER(status) NOT LIKE '%pend%'
GROUP BY date_format(date_parse(date, '%m-%d-%y'), '%Y-%m')
ORDER BY sales_month
LIMIT 10;

-- Query 5
WITH ranked AS (
    SELECT
        category,
        sku,
        SUM(amount) AS total_revenue,
        SUM(qty) AS total_units_sold,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY SUM(amount) DESC
        ) AS rnk
    FROM output_db.raw
    WHERE LOWER(status) NOT LIKE '%cancel%'
      AND LOWER(status) NOT LIKE '%pend%'
      AND qty > 0
    GROUP BY category, sku
)
SELECT
    category,
    sku,
    ROUND(total_revenue, 2) AS total_revenue,
    total_units_sold,
    rnk
FROM ranked
WHERE rnk <= 5
LIMIT 10;