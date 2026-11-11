# Product Price Adjustment — CASE WHEN

**Platform:** Custom SQL exercise (no LeetCode ID)  
**Dialect:** PostgreSQL

## Problem statement

Display each product with an adjusted price: Electronics +10%, Books +5%, and all other categories unchanged. Do not modify the stored prices.

## Table schema

```text
Products(ProductID, Category, Price)

*Illustrative schema; actual column names may vary.*
```

## Sample input and expected output

Sample Products:

| ProductID | Category | Price |
|---:|---|---:|
| 1 | Electronics | 1000 |
| 2 | Books | 500 |
| 3 | Clothing | 800 |

Expected output:

| ProductID | Category | Price | AdjustedPrice |
|---:|---|---:|---:|
| 1 | Electronics | 1000 | 1100.00 |
| 2 | Books | 500 | 525.00 |
| 3 | Clothing | 800 | 800.00 |

## SQL solution

```sql
SELECT *,
    CASE
        WHEN Category = 'Electronics' THEN Price * 1.10
        WHEN Category = 'Books' THEN Price * 1.05
        ELSE Price
    END AS AdjustedPrice
FROM Products;
```

## How the query works

1. `CASE` evaluates conditions in order.
2. Electronics prices are multiplied by `1.10`.
3. Books prices are multiplied by `1.05`.
4. `ELSE Price` preserves all other categories.
5. `AdjustedPrice` is a calculated output column; the underlying table is unchanged.

Do not put commas between `WHEN ... THEN` branches.

## Concepts practiced

- CASE WHEN, conditional expressions, percentage calculations

## Files

- `README.md` — explanation and examples
- `solution.sql` — executable SQL solution
