# Create Students and Faculties Tables

**LeetCode ID:** N/A — this is a custom SQL DDL exercise, not a verified LeetCode problem.  
**Topics:** `CREATE TABLE`, `PRIMARY KEY`, `NOT NULL`, `VARCHAR`, `DESC`  
**Dialect:** MySQL

## Problem

Create two tables with the following exact column names, types, and constraints. Then describe each table with `DESC`.

### Students schema

| Column | Type | Constraint |
|---|---|---|
| `RollNumber` | INT | PRIMARY KEY |
| `sName` | VARCHAR(50) | — |
| `Address` | VARCHAR(100) | — |
| `ContactNumber` | VARCHAR(15) | — |

### Faculties schema

| Column | Type | Constraint |
|---|---|---|
| `FacultyId` | INT | PRIMARY KEY |
| `fName` | VARCHAR(50) | NOT NULL |
| `class` | VARCHAR(25) | — |
| `email` | VARCHAR(100) | — |

## Solution

```sql
CREATE TABLE Students (
    RollNumber INT PRIMARY KEY,
    sName VARCHAR(50),
    Address VARCHAR(100),
    ContactNumber VARCHAR(15)
);

CREATE TABLE Faculties (
    FacultyId INT PRIMARY KEY,
    fName VARCHAR(50) NOT NULL,
    class VARCHAR(25),
    email VARCHAR(100)
);

DESC Students;
DESC Faculties;
```

## Expected `DESC Students` (key columns)

| Field | Type | Null | Key |
|---|---|---|---|
| RollNumber | int | NO | PRI |
| sName | varchar(50) | YES | |
| Address | varchar(100) | YES | |
| ContactNumber | varchar(15) | YES | |

## Expected `DESC Faculties` (key columns)

| Field | Type | Null | Key |
|---|---|---|---|
| FacultyId | int | NO | PRI |
| fName | varchar(50) | NO | |
| class | varchar(25) | YES | |
| email | varchar(100) | YES | |

The actual MySQL `DESC` output also includes `Default` and `Extra` columns.

## Explanation

1. `CREATE TABLE` defines the structure.
2. `PRIMARY KEY` requires unique, non-NULL IDs.
3. `VARCHAR(100)` permits up to 100 characters for `Address`.
4. `fName VARCHAR(50) NOT NULL` requires a faculty name.
5. Each statement ends with `;`.
6. `DESC` inspects the structure in MySQL; in PostgreSQL `psql`, use `\d Students` and `\d Faculties` instead.

**Note:** These are schema-only exercises; no rows are inserted, so there is no data-output table.
