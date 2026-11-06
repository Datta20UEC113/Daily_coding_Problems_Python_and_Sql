# LeetCode 1468 — Calculate Salaries

**Difficulty:** Medium  
**Topics:** PostgreSQL, window functions, CASE, ROUND

## Problem
Apply a **company-wide** tax rate to every employee based on the **highest salary in that company**:

| Maximum company salary | Tax rate | Take-home multiplier |
|---|---:|---:|
| Less than 1,000 | 0% | 1.00 |
| 1,000 through 10,000 | 24% | 0.76 |
| Greater than 10,000 | 49% | 0.51 |

Round each after-tax salary to the nearest integer.

### Salaries (input)
| company_id | employee_id | employee_name | salary |
|---:|---:|---|---:|
| 1 | 1 | Tony | 2000 |
| 1 | 2 | Pronub | 21300 |
| 1 | 3 | Tyrrox | 10800 |
| 2 | 1 | Pam | 300 |
| 2 | 7 | Bassem | 450 |
| 2 | 9 | Hermione | 700 |
| 3 | 7 | Bocaben | 100 |
| 3 | 2 | Ognjen | 2200 |
| 3 | 13 | Nyancat | 3300 |
| 3 | 15 | Morninngcat | 7777 |

## PostgreSQL solution

```sql
WITH company_max AS (
    SELECT
        company_id,
        employee_id,
        employee_name,
        salary,
        MAX(salary) OVER (PARTITION BY company_id) AS max_salary
    FROM Salaries
)
SELECT
    company_id,
    employee_id,
    employee_name,
    ROUND(
        CASE
            WHEN max_salary > 10000 THEN salary * 0.51
            WHEN max_salary >= 1000 THEN salary * 0.76
            ELSE salary
        END
    ) AS salary
FROM company_max
ORDER BY company_id, employee_id;
```

## Step-by-step execution

### Step 1 — Window MAX: add the maximum salary for each company

`MAX(salary) OVER (PARTITION BY company_id)` **does not collapse employee rows**.

| company_id | employee_name | original salary | max_salary |
|---:|---|---:|---:|
| 1 | Tony | 2000 | 21300 |
| 1 | Pronub | 21300 | 21300 |
| 1 | Tyrrox | 10800 | 21300 |
| 2 | Pam | 300 | 700 |
| 2 | Bassem | 450 | 700 |
| 2 | Hermione | 700 | 700 |
| 3 | Bocaben | 100 | 7777 |
| 3 | Ognjen | 2200 | 7777 |
| 3 | Nyancat | 3300 | 7777 |
| 3 | Morninngcat | 7777 | 7777 |

### Step 2 — CASE: choose one tax rate per company

| company_id | max_salary | condition matched | tax | multiplier |
|---:|---:|---|---:|---:|
| 1 | 21300 | > 10000 | 49% | 0.51 |
| 2 | 700 | < 1000 | 0% | 1.00 |
| 3 | 7777 | >= 1000 and <= 10000 | 24% | 0.76 |

**Common mistake:** Testing each employee's `salary` instead of the company's `max_salary` would incorrectly tax Tony at 24%, even though his company is taxed at 49%.

### Step 3 — Multiply and ROUND: calculate take-home pay

| company_id | employee_name | original salary | multiplier | before rounding | rounded salary |
|---:|---|---:|---:|---:|---:|
| 1 | Tony | 2000 | 0.51 | 1020.00 | 1020 |
| 1 | Pronub | 21300 | 0.51 | 10863.00 | 10863 |
| 1 | Tyrrox | 10800 | 0.51 | 5508.00 | 5508 |
| 2 | Pam | 300 | 1.00 | 300.00 | 300 |
| 2 | Bassem | 450 | 1.00 | 450.00 | 450 |
| 2 | Hermione | 700 | 1.00 | 700.00 | 700 |
| 3 | Bocaben | 100 | 0.76 | 76.00 | 76 |
| 3 | Ognjen | 2200 | 0.76 | 1672.00 | 1672 |
| 3 | Nyancat | 3300 | 0.76 | 2508.00 | 2508 |
| 3 | Morninngcat | 7777 | 0.76 | 5910.52 | 5911 |

### Final output

| company_id | employee_id | employee_name | salary |
|---:|---:|---|---:|
| 1 | 1 | Tony | 1020 |
| 1 | 2 | Pronub | 10863 |
| 1 | 3 | Tyrrox | 5508 |
| 2 | 1 | Pam | 300 |
| 2 | 7 | Bassem | 450 |
| 2 | 9 | Hermione | 700 |
| 3 | 2 | Ognjen | 1672 |
| 3 | 7 | Bocaben | 76 |
| 3 | 13 | Nyancat | 2508 |
| 3 | 15 | Morninngcat | 5911 |

## Alternative — GROUP BY + JOIN

```sql
WITH company_max AS (
    SELECT company_id, MAX(salary) AS max_salary
    FROM Salaries
    GROUP BY company_id
)
SELECT
    s.company_id,
    s.employee_id,
    s.employee_name,
    ROUND(CASE
        WHEN m.max_salary > 10000 THEN s.salary * 0.51
        WHEN m.max_salary >= 1000 THEN s.salary * 0.76
        ELSE s.salary
    END) AS salary
FROM Salaries AS s
JOIN company_max AS m ON m.company_id = s.company_id;
```

## Complexity
Window-based implementation commonly requires **O(n log n)** time for partition sorting and **O(n)** intermediate space, depending on the PostgreSQL plan and indexes. The grouped JOIN alternative can be approximately **O(n)** expected time with hashing, excluding sorting.

**Takeaway:** A window aggregate gives each employee access to the company maximum while retaining individual rows.
