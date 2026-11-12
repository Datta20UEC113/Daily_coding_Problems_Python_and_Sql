# Combine Shop Items Priced Above 25

[← Problem index](../README.md)

**Practice date:** 12 November 2026  
**Concepts:** Filtering, UNION, duplicate removal

## Problem statement

Return item names and prices from `shop_1` and `shop_2` where the price is greater than 25. Return each distinct item-name and price combination once.

Both tables contain `item_name` (text) and `price` (numeric).

## Example input

The following data is illustrative.

### shop_1

| item_name | price |
|---|---:|
| Pen | 20 |
| Notebook | 40 |
| Bottle | 60 |

### shop_2

| item_name | price |
|---|---:|
| Pencil | 25 |
| Notebook | 40 |
| Bag | 100 |

## Expected output

| item_name | price |
|---|---:|
| Notebook | 40 |
| Bottle | 60 |
| Bag | 100 |

Output order is not guaranteed.

## Solution

```sql
SELECT item_name, price
FROM shop_1
WHERE price > 25

UNION

SELECT item_name, price
FROM shop_2
WHERE price > 25;
```

[Open solution.sql](solution.sql)

## How it works

1. Each `WHERE` clause filters its own table. Prices equal to 25 are excluded.
2. `UNION` combines the two results and removes duplicate rows across both selected columns.
3. Notebook at 40 appears in both tables but appears once in the result.

## Key takeaways

- Use `WHERE`, not `whose`.
- Put the semicolon at the end of the complete UNION statement.
- Use `UNION ALL` if duplicate rows should be retained.
- Both SELECT statements must return the same number of columns with compatible types.
