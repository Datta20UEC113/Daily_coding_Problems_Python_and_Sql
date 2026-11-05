# Students Report by Geography (LeetCode 618)

**Topic:** SQL Pivoting, Window Functions, Conditional Aggregation  
**Database:** PostgreSQL

## Problem Statement

A graduate school has students from America, Asia, and Europe. Pivot the `continent` column so that students' names appear alphabetically under their respective continents. The output columns must be `America`, `Asia`, and `Europe`, in that order.

It is guaranteed that the number of students from America is at least as large as the number from either Asia or Europe.

## Table Schema

**Student**

| Column | Type |
|---|---|
| name | varchar |
| continent | varchar |

## Sample Input

| name | continent |
|---|---|
| Jack | America |
| Pascal | Europe |
| Xi | Asia |
| Jane | America |

## Expected Output

| America | Asia | Europe |
|---|---|---|
| Jack | Xi | Pascal |
| Jane | NULL | NULL |

## PostgreSQL Solution

```sql
WITH rn AS (
    SELECT
        name,
        continent,
        ROW_NUMBER() OVER (
            PARTITION BY continent
            ORDER BY name
        ) AS rnc
    FROM Student
)
SELECT
    MAX(CASE WHEN continent = 'America' THEN name END) AS "America",
    MAX(CASE WHEN continent = 'Asia' THEN name END) AS "Asia",
    MAX(CASE WHEN continent = 'Europe' THEN name END) AS "Europe"
FROM rn
GROUP BY rnc
ORDER BY rnc;
```

## Explanation

1. `ROW_NUMBER()` assigns an alphabetical position to each student within their continent.
2. `GROUP BY rnc` aligns students who occupy the same alphabetical position in their respective continents.
3. Each `CASE WHEN` returns the name for one continent, or `NULL` otherwise.
4. `MAX()` collapses each group into one row and selects its non-NULL name for each continent.
5. `ORDER BY rnc` displays names in alphabetical order within each continent.

### Intermediate Ranking

| name | continent | rnc |
|---|---|---|
| Jack | America | 1 |
| Jane | America | 2 |
| Xi | Asia | 1 |
| Pascal | Europe | 1 |

## Alternative: PostgreSQL `FILTER`

```sql
WITH rn AS (
    SELECT name, continent,
           ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS rnc
    FROM Student
)
SELECT
    MAX(name) FILTER (WHERE continent = 'America') AS "America",
    MAX(name) FILTER (WHERE continent = 'Asia') AS "Asia",
    MAX(name) FILTER (WHERE continent = 'Europe') AS "Europe"
FROM rn
GROUP BY rnc
ORDER BY rnc;
```

## Complexity

- **Time:** Typically `O(n log n)` due to sorting for the window function; actual database execution costs depend on the plan.
- **Space:** Up to `O(n)` working memory for sorting and aggregation, depending on the execution plan.

## Key Concepts

`ROW_NUMBER()` · `PARTITION BY` · `CASE WHEN` · `MAX()` · `GROUP BY` · Pivoting
