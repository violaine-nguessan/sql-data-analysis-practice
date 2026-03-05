-- Highest Cost Orders

-- SQL concepts used:
-- CTE
-- Aggregation
-- GROUP BY
-- MAX
-- JOIN

WITH order_info AS (

    -- Step 1: compute total daily cost per customer
    SELECT
        cust_id,
        order_date,
        SUM(total_order_cost) AS total_cost

    FROM orders

    WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01'

    GROUP BY cust_id, order_date
),

max_order AS (

    -- Step 2: find maximum order per day
    SELECT
        order_date,
        MAX(total_cost) AS max_cost

    FROM order_info

    GROUP BY order_date
)

-- Step 3: return customers matching the daily maximum

SELECT
    c.first_name,
    o.order_date,
    o.total_cost

FROM order_info o

JOIN customers c
    ON o.cust_id = c.id

JOIN max_order m
    ON o.order_date = m.order_date

WHERE o.total_cost = m.max_cost

ORDER BY o.order_date;
