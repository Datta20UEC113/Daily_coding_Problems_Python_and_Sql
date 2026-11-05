# Transactions With Maximum Amount Per Day

**Topic:** Correlated Subqueries, Aggregation, Date Handling  
**Database:** PostgreSQL

## Problem Statement

Given a `Transactions` table, return the IDs of transactions whose amount is the maximum for their calendar day. If multiple transactions tie for the highest amount on a day, include all of them.

Sort the final result by `transaction_id` in ascending order.

## Table Schema

**Transactions**

| Column | Type | Description |
|---|---|---|
| transaction_id | int | Primary key |
| day | timestamp | Date and time of transaction |
| amount | int | Transaction amount |

## Sample Input

| transaction_id | day | amount |
|---|---|---|
| 8 | 2021-04-03 15:57:28 | 57 |
| 9 | 2021-04-28 08:47:25 | 21 |
| 1 | 2021-04-29 13:28:30 | 58 |
| 5 | 2021-04-28 16:39:59 | 40 |
| 6 | 2021-04-29 23:39:28 | 58 |

## Expected Output

| transaction_id |
|---|
| 1 |
| 5 |
| 6 |
| 8 |

## PostgreSQL Solution — Correlated Subquery

```sql
SELECT t1.transaction_id
FROM Transactions AS t1
WHERE t1.amount = (
    SELECT MAX(t2.amount)
    FROM Transactions AS t2
    WHERE t2.day::date = t1.day::date
)
ORDER BY t1.transaction_id;
```

## Explanation

1. For each outer transaction (`t1`), the correlated subquery finds the maximum `amount` among transactions on the same calendar date.
2. `day::date` removes the time portion, so transactions at different times on the same day are compared together.
3. The outer `WHERE` condition retains transactions whose amount equals that daily maximum, including ties.
4. `ORDER BY transaction_id` sorts the result in ascending order.

### Daily Maximums

| Date | Maximum amount | Selected transaction IDs |
|---|---:|---|
| 2021-04-03 | 57 | 8 |
| 2021-04-28 | 40 | 5 |
| 2021-04-29 | 58 | 1, 6 |

## Alternative: Window Function

```sql
WITH daily_transactions AS (
    SELECT
        transaction_id,
        amount,
        MAX(amount) OVER (PARTITION BY day::date) AS max_amount
    FROM Transactions
)
SELECT transaction_id
FROM daily_transactions
WHERE amount = max_amount
ORDER BY transaction_id;
```

## Alternative: `DENSE_RANK()`

```sql
WITH ranked AS (
    SELECT
        transaction_id,
        DENSE_RANK() OVER (
            PARTITION BY day::date
            ORDER BY amount DESC
        ) AS rnk
    FROM Transactions
)
SELECT transaction_id
FROM ranked
WHERE rnk = 1
ORDER BY transaction_id;
```

`DENSE_RANK()` retains all tied transactions; `ROW_NUMBER()` would select only one transaction per day.

## Complexity

- **Correlated subquery:** Without helpful indexes or optimizer rewrites, can require `O(n²)` comparisons in the worst case, plus sorting the output.
- **Window-function approaches:** Typically involve sorting or partition processing; commonly around `O(n log n)`, depending on the execution plan.
- **Space:** Depends on the query plan and intermediate sorting/partitioning requirements.

## Key Concepts

Correlated Subqueries · `MAX()` · `day::date` · `PARTITION BY` · `DENSE_RANK()` · Handling Ties
