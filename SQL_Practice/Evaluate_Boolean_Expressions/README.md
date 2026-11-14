# Evaluate Boolean Expressions

[← Problem index](../README.md)

**Concepts:** Multiple joins, CASE

## Problem

Evaluate every expression using the values stored in Variables. Return left_operand, operator, right_operand, and a text value of 'true' or 'false', in any order.

## Schema

| Table | Columns | Key |
|---|---|---|
| Variables | name (varchar), value (int) | name |
| Expressions | left_operand (varchar), operator (enum), right_operand (varchar) | All three columns |

Operators are <, >, and =. Both operands are guaranteed to exist in Variables.

## Input: Variables

| name | value |
|---|---:|
| x | 66 |
| y | 77 |

## Expressions and expected output

The first three columns are input; the final column is the evaluated result.

| left_operand | operator | right_operand | value |
|---|---|---|---|
| x | > | y | false |
| x | < | y | true |
| x | = | y | false |
| y | > | x | true |
| y | < | x | false |
| x | = | x | true |

## Explanation

Join Variables twice: l supplies the left operand's number and r supplies the right operand's number. CASE checks the stored operator and compares those numbers. For x < y, this evaluates 66 < 77.

The operator is stored as data; CASE selects which comparison to perform. Return quoted 'true' and 'false' strings as required by the output.

Use WHEN condition THEN result. Typing THE instead of THEN causes a syntax error.

## SQL solution

```sql
SELECT
    e.left_operand,
    e.operator,
    e.right_operand,
    CASE
        WHEN e.operator = '<' AND l.value < r.value THEN 'true'
        WHEN e.operator = '>' AND l.value > r.value THEN 'true'
        WHEN e.operator = '=' AND l.value = r.value THEN 'true'
        ELSE 'false'
    END AS value
FROM Expressions AS e
JOIN Variables AS l ON e.left_operand = l.name
JOIN Variables AS r ON e.right_operand = r.name;
```

[Open solution.sql](solution.sql)
