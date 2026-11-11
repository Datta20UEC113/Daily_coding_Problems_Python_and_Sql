# SQL Master — Practice & Problem Solving

A structured collection of SQL exercises, worked solutions, and learning notes covering SQL fundamentals through advanced querying. This repository documents hands-on practice with an emphasis on **clear reasoning, readable code, and reproducible examples**.

**Focus areas:** SQL · PostgreSQL · Joins · Subqueries · CTEs · Window Functions · Data Analysis

## Start here

| Resource | Description |
|---|---|
| [SQL Practice](SQL_Practice/) | Organized, self-contained problem folders |
| [Problem Index](SQL_Practice/README.md) | Problem IDs, difficulty, SQL concepts, and direct solution links |
| [LeetCode SQL](https://leetcode.com/problemset/database/) | SQL coding challenge platform |

## Featured solutions

| Problem | Source | Concepts | Solution |
|---|---|---|---|
| Ad-Free Sessions | [LeetCode 1809](https://leetcode.com/problems/ad-free-sessions/) | Correlated subquery, `NOT EXISTS`, `BETWEEN` | [View](SQL_Practice/1809_Ad_Free_Sessions/) |
| Delete Duplicate Emails | [LeetCode 196](https://leetcode.com/problems/delete-duplicate-emails/) | `DELETE`, self-join, `USING` | [View](SQL_Practice/196_Delete_Duplicate_Emails/) |
| Product Price Adjustment | Custom exercise | `CASE WHEN`, percentage calculations | [View](SQL_Practice/Product_Price_Adjustment/) |

## Repository organization

```text
.
├── README.md
├── SQL_Practice/
│   ├── README.md
│   ├── 1809_Ad_Free_Sessions/
│   │   ├── README.md
│   │   └── solution.sql
│   ├── 196_Delete_Duplicate_Emails/
│   │   ├── README.md
│   │   └── solution.sql
│   └── Product_Price_Adjustment/
│       ├── README.md
│       └── solution.sql
└── [other existing practice files and folders]
```

Each organized problem folder contains a **README** with the question, example tables, expected output, explanation, and key takeaways, plus a **solution.sql** file with the final query.

## Topics practiced

- **Core SQL:** filtering, sorting, conditional expressions, aggregates, grouping
- **Relational queries:** inner/outer joins, self-joins, anti-joins
- **Subqueries:** correlated subqueries, `EXISTS` and `NOT EXISTS`
- **Data manipulation:** `DELETE`, deduplication
- **Advanced learning goals:** CTEs, window functions, query optimization

## How to use

1. Open the [problem index](SQL_Practice/README.md).
2. Select a problem and read its `README.md` for the requirements and worked example.
3. Review `solution.sql` to see the final implementation.
4. Compare alternative query strategies and practice adapting them to other datasets.

**SQL dialect:** The featured solutions use PostgreSQL syntax. SQL syntax can differ between PostgreSQL, MySQL, and SQL Server, especially for data-modification statements.

## Practice sources

[LeetCode](https://leetcode.com/) · [HackerRank](https://www.hackerrank.com/) · [GeeksforGeeks](https://www.geeksforgeeks.org/) · [SQLBolt](https://sqlbolt.com/) · [Code360](https://www.naukri.com/code360/)

---

*Learning SQL through consistent practice, clear documentation, and problem solving.*
