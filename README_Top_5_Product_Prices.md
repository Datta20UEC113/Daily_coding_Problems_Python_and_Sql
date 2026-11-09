# Top 5 Most Expensive Product Prices

**Difficulty:** Easy  
**Topics:** SQL, Sorting, LIMIT

## Problem Statement
List the five most expensive prices from the `product` table. Return only the prices, ordered from highest to lowest.

> **Schema assumption:** The supplied problem does not show the actual table structure. This solution assumes a table named `product` with a numeric column named `price`. Adjust the identifiers if your database uses different names.

## Sample Input
**product**

| product_id | product_name | price |
|---:|---|---:|
| 1 | Laptop | 75000 |
| 2 | Mouse | 800 |
| 3 | Phone | 45000 |
| 4 | Monitor | 15000 |
| 5 | Keyboard | 2000 |
| 6 | Tablet | 25000 |
| 7 | Headphones | 5000 |

## SQL Solution (PostgreSQL / MySQL)
```sql
SELECT price
FROM product
ORDER BY price DESC
LIMIT 5;
```

## Expected Output
| price |
|---:|
| 75000 |
| 45000 |
| 25000 |
| 15000 |
| 5000 |

## Query Execution Walkthrough
1. `FROM product` reads the product rows.
2. `ORDER BY price DESC` sorts prices from highest to lowest.
3. `LIMIT 5` keeps only the first five rows.
4. `SELECT price` returns only the price column.

### After sorting by price
| price |
|---:|
| 75000 |
| 45000 |
| 25000 |
| 15000 |
| 5000 |
| 2000 |
| 800 |

### After `LIMIT 5`
| price |
|---:|
| 75000 |
| 45000 |
| 25000 |
| 15000 |
| 5000 |

## Important Note: Duplicate Prices
This query returns **five rows**, even if some prices are equal. If the requirement is *five distinct price values*, use:
```sql
SELECT DISTINCT price
FROM product
ORDER BY price DESC
LIMIT 5;
```

## Key Takeaways
- `DESC` means descending order.
- `LIMIT 5` restricts the result to at most five rows.
- `DISTINCT` removes duplicate values when required.
