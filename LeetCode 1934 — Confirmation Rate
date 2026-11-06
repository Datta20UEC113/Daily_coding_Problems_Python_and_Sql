# LeetCode 1934 — Confirmation Rate

**Difficulty:** Medium  
**Topics:** PostgreSQL, LEFT JOIN, conditional aggregation, NULL handling

## Problem
For every user in `Signups`, calculate the number of confirmed messages divided by all confirmation requests. Users with no requests have a rate of `0`. Round to two decimal places.

### Signups
| user_id | time_stamp |
|---:|---|
| 3 | 2020-03-21 10:16:13 |
| 7 | 2020-01-04 13:57:59 |
| 2 | 2020-07-29 23:09:44 |
| 6 | 2020-12-09 10:39:37 |

### Confirmations
| user_id | time_stamp | action |
|---:|---|---|
| 3 | 2021-01-06 03:30:46 | timeout |
| 3 | 2021-07-14 14:00:00 | timeout |
| 7 | 2021-06-12 11:57:29 | confirmed |
| 7 | 2021-06-13 12:58:28 | confirmed |
| 7 | 2021-06-14 13:59:27 | confirmed |
| 2 | 2021-01-22 00:00:00 | confirmed |
| 2 | 2021-02-28 23:59:59 | timeout |

## PostgreSQL solution

```sql
SELECT
    s.user_id,
    ROUND(
        COALESCE(
            AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END),
            0
        ),
        2
    ) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
```

## Step-by-step execution

### Step 1 — LEFT JOIN: retain every signup

The join yields one row per confirmation, and one NULL-extended row for user 6.

| s.user_id | c.action |
|---:|---|
| 2 | confirmed |
| 2 | timeout |
| 3 | timeout |
| 3 | timeout |
| 6 | NULL |
| 7 | confirmed |
| 7 | confirmed |
| 7 | confirmed |

### Step 2 — CASE: convert outcomes to numbers

`CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END`

| user_id | action | score |
|---:|---|---:|
| 2 | confirmed | 1.0 |
| 2 | timeout | 0 |
| 3 | timeout | 0 |
| 3 | timeout | 0 |
| 6 | NULL | 0 |
| 7 | confirmed | 1.0 |
| 7 | confirmed | 1.0 |
| 7 | confirmed | 1.0 |

### Step 3 — GROUP BY + AVG: compute each rate

| user_id | scores averaged | average |
|---:|---|---:|
| 2 | (1 + 0) / 2 | 0.50 |
| 3 | (0 + 0) / 2 | 0.00 |
| 6 | 0 / 1 (NULL-extended join row) | 0.00 |
| 7 | (1 + 1 + 1) / 3 | 1.00 |

### Step 4 — ROUND and COALESCE: final result

| user_id | confirmation_rate |
|---:|---:|
| 2 | 0.50 |
| 3 | 0.00 |
| 6 | 0.00 |
| 7 | 1.00 |

`COALESCE` is defensive here: because the CASE returns `0` even for the NULL-extended row, `AVG` already returns zero for user 6. `ROUND(..., 2)` rounds to two decimal places; display formatting may omit trailing zeroes in some clients.

## Alternative — count confirmed messages explicitly

```sql
SELECT
    s.user_id,
    COALESCE(
        ROUND(
            COUNT(*) FILTER (WHERE c.action = 'confirmed')::numeric
            / NULLIF(COUNT(c.user_id), 0),
            2
        ),
        0
    ) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
```

Here `COUNT(c.user_id)` excludes the unmatched join row; `NULLIF(..., 0)` prevents division by zero, and `COALESCE` returns zero.

## Complexity
A hash-join/hash-aggregation implementation is typically **O(S + C)** expected time and **O(S)** grouping space, where S is the number of signups and C is the number of confirmations. Actual performance depends on indexes and the query plan; the final `ORDER BY` can add sorting cost.

**Takeaway:** Use `LEFT JOIN` to retain unmatched users and conditional aggregation to compute per-user rates.
