SELECT s.sale_date, s.sold_num - s1.sold_num AS diff
FROM Sales AS s
JOIN Sales AS s1
    ON s.sale_date = s1.sale_date
WHERE s.fruit = 'apples'
  AND s1.fruit = 'oranges'
ORDER BY s.sale_date;
