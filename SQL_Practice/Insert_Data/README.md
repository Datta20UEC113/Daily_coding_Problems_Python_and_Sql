# Insert Data into a Table

[← Problem index](../README.md)

## Syntax

```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

## Example

Assuming Products has these columns and CategoryID 2 exists:

```sql
INSERT INTO Products (ProductID, ProductName, CategoryID, Unit, Price)
VALUES (1, 'Notebook', 2, '1 piece', 40.00);
```

For multiple rows, separate value groups with commas.

## Fixing the quoted text error

| Incorrect VALUES clause | Correct VALUES clause |
|---|---|
| VALUES (3, 'Kim', F) | VALUES (3, 'Kim', 'F') |

PostgreSQL interprets unquoted F as a column identifier. Text values require single quotes.

Values must match the listed columns in order and type. Primary keys must be unique, and foreign keys must reference existing records. Omit automatically generated IDs where appropriate.

These are syntax examples; use your actual table and column names.
