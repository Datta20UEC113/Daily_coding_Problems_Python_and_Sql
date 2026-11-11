# 1809 — Ad-Free Sessions

**Platform:** [LeetCode](https://leetcode.com/problems/ad-free-sessions/)  
**Dialect:** PostgreSQL

## Problem statement

Find playback session IDs during which the customer saw no advertisements. An advertisement during the inclusive interval from `start_time` to `end_time` makes that session ineligible.

## Table schema

```text
Playback(session_id, customer_id, start_time, end_time)
Ads(ad_id, customer_id, timestamp)
```

## Sample input and expected output

Playback:

| session_id | customer_id | start_time | end_time |
|---:|---:|---:|---:|
| 1 | 10 | 1 | 5 |
| 2 | 10 | 6 | 10 |
| 3 | 20 | 2 | 7 |

Ads:

| ad_id | customer_id | timestamp |
|---:|---:|---:|
| 101 | 10 | 3 |
| 102 | 20 | 8 |

Expected output:

| session_id |
|---:|
| 2 |
| 3 |

## SQL solution

```sql
SELECT p.session_id
FROM Playback AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM Ads AS a
    WHERE a.customer_id = p.customer_id
      AND a.timestamp BETWEEN p.start_time AND p.end_time
);
```

## How the query works

1. Scan each playback session.
2. The correlated subquery checks for ads by the same customer within the inclusive session interval.
3. `NOT EXISTS` keeps only sessions with no matching ad.
4. A session is not excluded merely because the customer saw an ad outside its time interval.

## Concepts practiced

- Correlated subquery, NOT EXISTS, BETWEEN, anti-join

## Files

- `README.md` — explanation and examples
- `solution.sql` — executable SQL solution
