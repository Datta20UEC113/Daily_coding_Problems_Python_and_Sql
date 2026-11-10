# 619. Biggest Single Number

**LeetCode:** https://leetcode.com/problems/biggest-single-number/  
**Difficulty:** Easy  
**Topics:** Aggregation, `GROUP BY`, `HAVING`, Subquery, `MAX()`  
**Dialect:** PostgreSQL / MySQL

## Problem

Given a table of integers, find the **largest number occurring exactly once**. Return a single row containing `NULL` if no such number exists.

### Schema

| Column | Type |
|---|---|
| `num` | INT |

The LeetCode table is named `MyNumbers` (change to `my_numbers` if that is your local table name).

### Sample input: MyNumbers

| num |
|---:|
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 |

### Expected output

| num |
|---:|
| 6 |

## Solution

```sql
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS single_numbers;
```

## Query execution walkthrough

**1. Group and count:**

```sql
SELECT num, COUNT(*) AS occurrences
FROM MyNumbers
GROUP BY num;
```

| num | occurrences |
|---:|---:|
| 1 | 1 |
| 3 | 2 |
| 4 | 1 |
| 5 | 1 |
| 6 | 1 |
| 8 | 2 |

**2. Apply `HAVING COUNT(*) = 1`:**

| num |
|---:|
| 1 |
| 4 |
| 5 |
| 6 |

**3. Apply outer `MAX(num)`:** Returns `6`.

### Important edge case

For `[8, 8, 3, 3]`, the inner query returns no rows and the outer `MAX()` returns one row with `NULL`. `ORDER BY num DESC LIMIT 1` alone would return **zero rows**, not the required `NULL` row.

**Complexity:** Grouping typically uses O(n) expected time with hashing or O(n log n) with sorting; space is O(u) for u distinct numbers. Actual execution depends on the database optimizer.
