WITH DailySales AS (
    SELECT
        s.ShipperID,
        s.ShipperName,
        o.OrderDate,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Shippers AS s
    JOIN Orders AS o ON s.ShipperID = o.ShipperID
    JOIN Order_Details AS od ON o.OrderID = od.OrderID
    JOIN Products AS p ON od.ProductID = p.ProductID
    GROUP BY s.ShipperID, s.ShipperName, o.OrderDate
)
SELECT
    ShipperName,
    OrderDate,
    ROUND(TotalSales, 2) AS TotalSales,
    ROUND(
        SUM(TotalSales) OVER (
            PARTITION BY ShipperID
            ORDER BY OrderDate
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS CumulativeSales
FROM DailySales
ORDER BY ShipperName, OrderDate;
