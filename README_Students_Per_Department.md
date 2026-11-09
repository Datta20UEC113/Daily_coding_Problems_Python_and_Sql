# Number of Students in Each Department

**Difficulty:** Easy–Medium  
**Topics:** SQL, LEFT JOIN, GROUP BY, COUNT, ORDER BY

## Problem Statement
Print the department name and the number of students majoring in each department. Include **every department**, even those with zero students.

Sort by:
1. Student count in **descending** order.
2. Department name in **ascending alphabetical** order when counts tie.

## Table Structures
### student
| Column | Type | Description |
|---|---|---|
| student_id | Integer | Student ID |
| student_name | String | Student name |
| gender | Character | Gender |
| dept_id | Integer | Student's major department |

### department
| Column | Type | Description |
|---|---|---|
| dept_id | Integer | Department ID |
| dept_name | String | Department name |

## Sample Input
**student**

| student_id | student_name | gender | dept_id |
|---:|---|:---:|---:|
| 1 | Jack | M | 1 |
| 2 | Jane | F | 1 |
| 3 | Mark | M | 2 |

**department**

| dept_id | dept_name |
|---:|---|
| 1 | Engineering |
| 2 | Science |
| 3 | Law |

## SQL Solution
```sql
SELECT
    d.dept_name,
    COUNT(s.student_id) AS student_number
FROM department AS d
LEFT JOIN student AS s
    ON d.dept_id = s.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY student_number DESC, d.dept_name ASC;
```

## Expected Output
| dept_name | student_number |
|---|---:|
| Engineering | 2 |
| Science | 1 |
| Law | 0 |

## Query Execution Walkthrough
### Step 1: `LEFT JOIN`
Start with **department** so every department is retained, even when no matching student exists.

| dept_id | dept_name | student_id | student_name |
|---:|---|---:|---|
| 1 | Engineering | 1 | Jack |
| 1 | Engineering | 2 | Jane |
| 2 | Science | 3 | Mark |
| 3 | Law | NULL | NULL |

### Step 2: `GROUP BY` and `COUNT(s.student_id)`
Group the joined rows by department. `COUNT(s.student_id)` ignores NULL values.

| dept_name | student_number |
|---|---:|
| Engineering | 2 |
| Science | 1 |
| Law | 0 |

### Step 3: `ORDER BY`
Sort counts highest first. When counts tie, sort names alphabetically.

| dept_name | student_number |
|---|---:|
| Engineering | 2 |
| Science | 1 |
| Law | 0 |

## Why Not `INNER JOIN`?
`INNER JOIN` would exclude Law because it has no matching students. `LEFT JOIN` preserves the department row.

## Why `COUNT(s.student_id)` Instead of `COUNT(*)`?
The unmatched Law department still produces one joined row with NULL student fields. `COUNT(*)` would incorrectly count that row as 1. `COUNT(s.student_id)` correctly returns 0.

## Key Takeaways
- Use `LEFT JOIN` when all rows from the left table must be included.
- Use `COUNT(non_null_column)` to count actual matching records.
- `GROUP BY` creates one result per department.
- Multiple expressions in `ORDER BY` implement tie-breaking.
