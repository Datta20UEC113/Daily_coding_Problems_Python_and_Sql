-- LeetCode 619: Biggest Single Number (PostgreSQL / MySQL)
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS single_numbers;
