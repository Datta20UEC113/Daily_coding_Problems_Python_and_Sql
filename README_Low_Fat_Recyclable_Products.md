# Recyclable and Low-Fat Products

**Difficulty:** Easy  
**Topics:** SQL, Filtering, WHERE, AND

## Problem Statement
Find the IDs of products that are **both low fat and recyclable**. Return the product IDs in any order.

## Table Structure
**Products**

| Column | Type | Description |
|---|---|---|
| product_id | int | Primary key |
| low_fats | enum('Y','N') | `Y` means low fat |
| recyclable | enum('Y','N') | `Y` means recyclable |

## Sample Input
**Products**

| product_id | low_fats | recyclable |
|---:|:---:|:---:|
| 0 | Y | N |
| 1 | Y | Y |
| 2 | N | Y |
| 3 | Y | Y |
| 4 | N | N |

## SQL Solution
```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
```

## Expected Output
| product_id |
|---:|
| 1 |
| 3 |

## Query Execution Walkthrough
### Step 1: Filter low-fat products
Rows meeting `low_fats = 'Y'`:

| product_id | low_fats | recyclable |
|---:|:---:|:---:|
| 0 | Y | N |
| 1 | Y | Y |
| 3 | Y | Y |

### Step 2: Apply the recyclable condition
Rows also meeting `recyclable = 'Y'`:

| product_id | low_fats | recyclable |
|---:|:---:|:---:|
| 1 | Y | Y |
| 3 | Y | Y |

### Step 3: Select only product IDs
| product_id |
|---:|
| 1 |
| 3 |

## Why `AND` Rather Than `OR`?
- `AND` requires **both** conditions to be true.
- `OR` would also include products that satisfy only one condition, which is not what the question asks.

## Key Takeaways
- Use `WHERE` to filter rows.
- Use `AND` when every condition must be satisfied.
- Select only the columns requested in the output.
