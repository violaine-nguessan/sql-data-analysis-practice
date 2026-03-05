-- Rank Variance Per Country

-- SQL concepts used:
-- CTE
-- Window functions
-- DENSE_RANK
-- Aggregation

WITH total_com AS (

    -- Step 1: compute comments per user per month
    SELECT
        c.user_id,
        MONTH(c.created_at) AS months,
        YEAR(c.created_at) AS year,
        a.country,
        SUM(c.number_of_comments) AS total_comments

    FROM fb_comments_count c

    JOIN fb_active_users a
        ON c.user_id = a.user_id

    WHERE
        (MONTH(c.created_at) = 12 AND YEAR(c.created_at) = 2019)
        OR
        (MONTH(c.created_at) = 1 AND YEAR(c.created_at) = 2020)

    GROUP BY
        c.user_id,
        MONTH(c.created_at),
        YEAR(c.created_at),
        a.country
),

dec_rank AS (

    -- Step 2: rank countries in December
    SELECT
        country,

        SUM(total_comments) AS total_comments,

        DENSE_RANK() OVER (
            ORDER BY SUM(total_comments) DESC
        ) AS dec_rank

    FROM total_com

    WHERE months = 12 AND year = 2019

    GROUP BY country
),

jan_rank AS (

    -- Step 3: rank countries in January
    SELECT
        country,

        SUM(total_comments) AS total_comments,

        DENSE_RANK() OVER (
            ORDER BY SUM(total_comments) DESC
        ) AS jan_rank

    FROM total_com

    WHERE months = 1 AND year = 2020

    GROUP BY country
)

-- Step 4: find countries whose rank improved

SELECT j.country

FROM jan_rank j

JOIN dec_rank d
    ON j.country = d.country

WHERE j.jan_rank < d.dec_rank;
