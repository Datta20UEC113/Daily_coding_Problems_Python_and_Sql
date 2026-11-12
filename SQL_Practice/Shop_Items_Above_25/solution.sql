SELECT item_name, price
FROM shop_1
WHERE price > 25

UNION

SELECT item_name, price
FROM shop_2
WHERE price > 25;
