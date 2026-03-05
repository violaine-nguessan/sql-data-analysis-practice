-- Consecutive Days

-- SQL concepts used:
-- Window functions
-- LAG
-- LEAD
-- Date difference
-- Aggregation

SELECT user_id

FROM (

    -- Step 3: count occurrences where a date has consecutive neighbors
    SELECT
        user_id,

        COUNT(
            CASE
                WHEN diff1 = 1 AND diff2 = 1
                THEN 1
            END
        ) AS count_cons_date

    FROM (

        -- Step 1: compute difference with next activity
        -- Step 2: compute difference with previous activity

        SELECT
            user_id,

            DATEDIFF(
                day,
                record_date,
                LEAD(record_date) OVER (
                    PARTITION BY user_id
                    ORDER BY record_date
                )
            ) AS diff1,

            DATEDIFF(
                day,
                LAG(record_date) OVER (
                    PARTITION BY user_id
                    ORDER BY record_date
                ),
                record_date
            ) AS diff2

        FROM sf_events

    ) sub

    GROUP BY user_id

) sub2

-- Step 4: keep users with at least one 3-day streak
WHERE count_cons_date >= 1;
