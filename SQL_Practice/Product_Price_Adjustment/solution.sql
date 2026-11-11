-- Product Price Adjustment — CASE WHEN
SELECT *,
    CASE
        WHEN Category = 'Electronics' THEN Price * 1.10
        WHEN Category = 'Books' THEN Price * 1.05
        ELSE Price
    END AS AdjustedPrice
FROM Products;
