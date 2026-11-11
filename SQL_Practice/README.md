# SQL Practice — Problem Index

[← Back to repository overview](../README.md)

A navigable index of documented SQL exercises. Each problem has a standalone explanation and an executable `solution.sql`.

## LeetCode problems

| # | Problem | Difficulty | Concepts | Files |
|---|---|---|---|---|
| 1809 | [Ad-Free Sessions](https://leetcode.com/problems/ad-free-sessions/) | Easy | `NOT EXISTS`, correlated subquery, `BETWEEN` | [README](1809_Ad_Free_Sessions/README.md) · [SQL](1809_Ad_Free_Sessions/solution.sql) |
| 196 | [Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/) | Easy | `DELETE`, self-join, `USING` | [README](196_Delete_Duplicate_Emails/README.md) · [SQL](196_Delete_Duplicate_Emails/solution.sql) |

## Custom exercises

| Problem | Concepts | Files |
|---|---|---|
| Product Price Adjustment | `CASE WHEN`, percentage calculations | [README](Product_Price_Adjustment/README.md) · [SQL](Product_Price_Adjustment/solution.sql) |

## Folder convention

```text
<LeetCodeID>_<Problem_Name>/
├── README.md       # Statement, schema, sample tables, explanation
└── solution.sql    # Final SQL query
```

For custom exercises without a LeetCode ID, use a descriptive folder name.

## Query notes

- **Ad-Free Sessions:** Use an anti-existence check; a customer's ad outside a session does not make that session ad-free if another ad occurred inside it.
- **Delete Duplicate Emails:** Preserve the smallest ID for each email; the included `DELETE ... USING` solution is PostgreSQL-specific.
- **Product Price Adjustment:** `CASE` computes a displayed value and does not update the stored price.

## Adding future problems

1. Create a folder named `<ID>_<Problem_Name>` or a descriptive custom title.
2. Add `README.md` with problem statement, schema, input/output examples, approach, and complexity notes when applicable.
3. Add `solution.sql` with the final tested SQL.
4. Add a row to this index so visitors can find the new exercise quickly.

[← Repository homepage](../README.md)
