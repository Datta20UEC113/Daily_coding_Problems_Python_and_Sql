# 197. Rising Temperature

**LeetCode:** https://leetcode.com/problems/rising-temperature/  
**Difficulty:** Easy  
**Topics:** Self Join, Date Arithmetic, Window Functions (`LAG`)  
**Dialect:** PostgreSQL

## Problem

Find the IDs of weather records whose temperature is **higher than the immediately previous calendar day's** temperature. If yesterday's record is missing, the current record must not qualify.

### Schema: Weather

| Column | Type | Notes |
|---|---|---|
| `id` | INT | Primary key |
| `recordDate` | DATE | Date of reading |
| `temperature` | INT | Recorded temperature |

### Sample input

| id | recordDate | temperature |
|---:|---|---:|
| 1 | 2015-01-01 | 10 |
| 2 | 2015-01-02 | 25 |
| 3 | 2015-01-03 | 20 |
| 4 | 2015-01-04 | 30 |

### Expected output

| id |
|---:|
| 2 |
| 4 |

## Solution 1 — Self Join

```sql
SELECT today.id AS id
FROM Weather AS today
JOIN Weather AS yesterday
    ON today.recordDate = yesterday.recordDate + 1
WHERE today.temperature > yesterday.temperature;
```

### Intermediate joined rows (before temperature filter)

| today.id | today.date | today.temp | yesterday.date | yesterday.temp | Higher? |
|---:|---|---:|---|---:|---|
| 2 | 2015-01-02 | 25 | 2015-01-01 | 10 | Yes |
| 3 | 2015-01-03 | 20 | 2015-01-02 | 25 | No |
| 4 | 2015-01-04 | 30 | 2015-01-03 | 20 | Yes |

The first record has no preceding day and does not join. Filtering leaves IDs `2` and `4`.

## Solution 2 — `LAG()` Window Function

```sql
WITH history AS (
    SELECT id, recordDate, temperature,
           LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date,
           LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp
    FROM Weather
)
SELECT id
FROM history
WHERE recordDate = prev_date + 1
  AND temperature > prev_temp;
```

### `LAG()` intermediate result

| id | recordDate | temperature | prev_date | prev_temp |
|---:|---|---:|---|---:|
| 1 | 2015-01-01 | 10 | NULL | NULL |
| 2 | 2015-01-02 | 25 | 2015-01-01 | 10 |
| 3 | 2015-01-03 | 20 | 2015-01-02 | 25 |
| 4 | 2015-01-04 | 30 | 2015-01-03 | 20 |

**Why check the date?** `LAG()` retrieves the previous *row*, not necessarily yesterday. A gap between dates must not count.

### PostgreSQL date arithmetic

- `date + 1` adds one calendar day and returns a date.
- `date + INTERVAL '1 day'` also works (returns a timestamp).
- `date + '1 Day'` may produce an ambiguous operator error because the string is untyped.

**Complexity:** A self join may be efficient with an index on `recordDate`; the `LAG()` version typically requires ordering by date, O(n log n) without a suitable index. Actual plans depend on indexes and optimizer.
