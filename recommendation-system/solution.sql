-- Recommendation System
-- Goal: recommend pages that a user does NOT follow but that at least one friend follows

-- SQL concepts used:
-- JOIN
-- Subquery
-- Filtering

SELECT DISTINCT
    f.user_id,
    p.page_id

FROM users_friends f

-- Step 1: retrieve pages followed by the user's friends
JOIN users_pages p
    ON f.friend_id = p.user_id

-- Step 2: remove pages already followed by the user
WHERE NOT EXISTS (

    SELECT 1
    FROM users_pages up

    WHERE up.user_id = f.user_id
    AND up.page_id = p.page_id
);
