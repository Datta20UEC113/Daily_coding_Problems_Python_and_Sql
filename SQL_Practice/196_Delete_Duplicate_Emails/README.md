# 196 — Delete Duplicate Emails

**Platform:** [LeetCode](https://leetcode.com/problems/delete-duplicate-emails/)  
**Dialect:** PostgreSQL

## Problem statement

Delete duplicate email rows from `Person`, keeping the row with the smallest `Id` for each email. This problem requires a `DELETE` statement.

## Table schema

```text
Person(Id PRIMARY KEY, Email)
```

## Sample input and expected output

Before:

| Id | Email |
|---:|---|
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

After:

| Id | Email |
|---:|---|
| 1 | john@example.com |
| 2 | bob@example.com |

## SQL solution

```sql
DELETE FROM Person AS p
USING Person AS p1
WHERE p.Email = p1.Email
  AND p.Id > p1.Id;
```

## How the query works

1. `USING Person AS p1` matches rows from the table against itself.
2. `p.Email = p1.Email` finds duplicate email values.
3. `p.Id > p1.Id` selects rows with a larger ID than another row with the same email.
4. `DELETE` removes those larger-ID rows, leaving the smallest ID per email.

**Preview rows before deletion:**

```sql
SELECT p.Id, p.Email
FROM Person AS p
JOIN Person AS p1
  ON p.Email = p1.Email AND p.Id > p1.Id;
```

This is PostgreSQL syntax. MySQL uses `DELETE p FROM Person p JOIN Person p1 ...` instead.

## Concepts practiced

- DELETE, self join, USING, duplicate removal

## Files

- `README.md` — explanation and examples
- `solution.sql` — executable SQL solution
