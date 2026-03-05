# Highest Cost Orders

Find customers with the highest daily total order cost between:

2019-02-01 and 2019-05-01.

If a customer placed multiple orders on the same day,
sum the order costs for that day.

If several customers share the same highest daily cost,
return all of them.

## Tables

customers

| id | first_name | last_name |

orders

| id | cust_id | order_date | total_order_cost |

## Expected Output

| first_name | order_date | total_cost |
