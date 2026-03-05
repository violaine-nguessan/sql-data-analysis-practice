# Recommendation System

You are given a list of Facebook friends and the list of Facebook pages that users follow.

Your task is to build a recommendation system.

For each user, recommend pages that:
- the user does NOT follow
- but at least one of their friends follows.

## Tables

users_friends

| user_id | friend_id |

users_pages

| user_id | page_id |

## Expected Output

| user_id | page_id |

Each row represents a page recommendation for a user.
