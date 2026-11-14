# Apples and Oranges

[← Problem index](../README.md)

**Concepts:** Self-join, ENUM, subtraction

## Problem

For each sale date, calculate apples sold minus oranges sold. Assume one row per fruit per date and both fruits are present.

## Schema

| Column | Meaning |
|---|---|
| sale_date | Date of sale |
| fruit | ENUM containing apples and oranges |
| sold_num | Number sold |

## Illustrative input

| sale_date | fruit | sold_num |
|---|---|---:|
| 2026-11-13 | apples | 20 |
| 2026-11-13 | oranges | 12 |
| 2026-11-14 | apples | 8 |
| 2026-11-14 | oranges | 15 |

## Expected output

| sale_date | diff |
|---|---:|
| 2026-11-13 | 8 |
| 2026-11-14 | -7 |

## Explanation

Join Sales to itself by date. Filter the first alias to apples and the second to oranges, then subtract the quantities.

A scalar subquery in SELECT must return at most one row; the original uncorrelated subquery could return several dates. The direct join produces one result per date.

ENUM values must match exactly: use 'apples', not 'apple'. PostgreSQL can list allowed values with `SELECT unnest(enum_range(NULL::fruit_baskets));` when that is the enum type's name.

## SQL solution

```sql
SELECT s.sale_date, s.sold_num - s1.sold_num AS diff
FROM Sales AS s
JOIN Sales AS s1
    ON s.sale_date = s1.sale_date
WHERE s.fruit = 'apples'
  AND s1.fruit = 'oranges'
ORDER BY s.sale_date;
```

[Open solution.sql](solution.sql)
