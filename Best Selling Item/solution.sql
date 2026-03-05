-- Best Selling Item

-- SQL concepts used:
-- CTE
-- Aggregation
-- Ranking logic

WITH monthly_sale AS (

    -- Step 1: compute total sales per item per month
    SELECT
        MONTH(invoicedate) AS month,
        description,
        SUM(unitprice * quantity) AS total_paid

    FROM online_retail

    -- ignore returns
    WHERE invoiceno NOT LIKE 'C%'

    GROUP BY
        MONTH(invoicedate),
        description
),

max_sales AS (

    -- Step 2: find maximum sales per month
    SELECT
        month,
        MAX(total_paid) AS max_paid

    FROM monthly_sale

    GROUP BY month
)

-- Step 3: return items matching the maximum sales

SELECT
    mo.month,
    mo.description,
    mo.total_paid

FROM monthly_sale mo

JOIN max_sales ma
    ON mo.month = ma.month

WHERE mo.total_paid = ma.max_paid;
