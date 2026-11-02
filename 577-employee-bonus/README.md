# 577. Employee Bonus

**Difficulty:** 🟢 Easy  
**Platform:** [LeetCode](https://leetcode.com/problems/employee-bonus/)  
**Topics:** SQL, LEFT JOIN, WHERE, NULL Handling, COALESCE

---

## Problem Statement

Write an SQL query to find the names and bonus amounts of employees who satisfy at least one of the following conditions:

- The employee received a bonus **less than 1000**.
- The employee did not receive any bonus.

Return the result in any order.

## Database Schema

### Employee

| Column | Type |
|---|---|
| empId | int |
| name | varchar |
| supervisor | int |
| salary | int |

**Primary Key:** `empId`

Each row contains an employee's ID, name, supervisor ID, and salary.

### Bonus

| Column | Type |
|---|---|
| empId | int |
| bonus | int |

**Primary Key:** `empId`  
**Foreign Key:** `empId` references `Employee(empId)`.

Each row contains an employee's ID and their bonus amount.

---

## SQL Solution

```sql
SELECT
    e.name,
    b.bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
    ON e.empId = b.empId
WHERE b.bonus < 1000
   OR b.bonus IS NULL;
```

---

## Approach: LEFT JOIN + WHERE + NULL Handling

We use `LEFT JOIN` because we need to include employees who do not have a matching record in the `Bonus` table.

An `INNER JOIN` would exclude employees who did not receive a bonus.

### Step 1: Join Employee and Bonus tables

```sql
SELECT
    e.name,
    b.bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
    ON e.empId = b.empId;
```

A `LEFT JOIN` preserves every employee from the `Employee` table, even when no matching bonus record exists.

**Result after LEFT JOIN:**

| name | bonus |
|---|---|
| Brad | NULL |
| John | NULL |
| Dan | 500 |
| Thomas | 2000 |

**Important:** Brad and John are included even though they do not have records in the `Bonus` table.

### Step 2: Filter employees using WHERE

```sql
WHERE b.bonus < 1000
   OR b.bonus IS NULL
```

We use two conditions:

**Condition 1: Bonus less than 1000**

```sql
b.bonus < 1000
```

This selects employees whose bonus amount is strictly less than 1000.

For example, Dan received a bonus of 500, so he satisfies this condition.

**Condition 2: No bonus received**

```sql
b.bonus IS NULL
```

This selects employees who have no matching bonus record.

For example, Brad and John have `NULL` bonus values because they did not receive a bonus.

The `OR` operator ensures that employees satisfying either condition are included.

---

## Expected Output

| name | bonus |
|---|---|
| Brad | NULL |
| John | NULL |
| Dan | 500 |

**Explanation:**

- Brad did not receive any bonus.
- John did not receive any bonus.
- Dan received a bonus of 500, which is less than 1000.
- Thomas received a bonus of 2000, so he is excluded.

---

## Alternative Approach: COALESCE()

We can also solve this problem using `COALESCE()`.

```sql
SELECT
    e.name,
    b.bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
    ON e.empId = b.empId
WHERE COALESCE(b.bonus, 0) < 1000;
```

### How does COALESCE() work?

`COALESCE()` returns the first non-NULL value from its arguments.

```sql
COALESCE(b.bonus, 0)
```

- If the bonus is 500, it returns 500.
- If the bonus is NULL, it returns 0.
- If the bonus is 2000, it returns 2000.

This allows us to check both conditions using a single comparison.

Note that `COALESCE()` only replaces NULL values during filtering. The selected `b.bonus` column still displays NULL for employees without bonuses.

---

## Important SQL Concept: NULL Handling

In SQL, `NULL` represents a missing or unknown value.

We cannot compare NULL using ordinary comparison operators.

**Incorrect:**

```sql
WHERE bonus = NULL;
```

**Correct:**

```sql
WHERE bonus IS NULL;
```

Also, the expression:

```sql
NULL < 1000
```

does not return TRUE or FALSE. It evaluates to `UNKNOWN`.

This is why we explicitly include `OR b.bonus IS NULL` in our original query.

---

## Key SQL Concepts Learned

| Concept | Purpose |
|---|---|
| `LEFT JOIN` | Includes all employees, even without bonus records |
| `ON` | Specifies the relationship between the tables |
| `WHERE` | Filters rows based on conditions |
| `OR` | Returns rows satisfying at least one condition |
| `IS NULL` | Checks for missing values |
| `COALESCE()` | Replaces NULL with a fallback value in an expression |

## Important Takeaway

When a SQL problem asks for records that **may or may not have a matching entry in another table**, consider using a `LEFT JOIN`.

For problems involving missing values, remember:

- Use `IS NULL` instead of `= NULL`.
- Use `IS NOT NULL` instead of `!= NULL`.
- Use `COALESCE()` when a fallback value is appropriate.

**Final Understanding:** `LEFT JOIN` preserves employees without bonus records, while `WHERE` filters employees who received less than 1000 or have no bonus.

---

**Problem Link:** [LeetCode 577 — Employee Bonus](https://leetcode.com/problems/employee-bonus/)
