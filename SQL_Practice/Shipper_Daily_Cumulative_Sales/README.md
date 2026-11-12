# Daily and Cumulative Sales by Shipper

[← Problem index](../README.md)

**Practice date:** 12 November 2026  
**Concepts:** JOIN, GROUP BY, CTE, SUM OVER, running totals, ROUND

## Problem statement

Using Shippers, Orders, Order_Details, and Products, calculate total sales for each shipper on each order date. Also calculate cumulative sales for that shipper through and including the current order date. Round the reported values to two decimal places.

Sales for an order line = `Price * Quantity`.

## Schema

| Table | Columns | Relationships |
|---|---|---|
| Products | ProductID, ProductName, CategoryID, Unit, Price | ProductID is the primary key |
| Order_Details | OrderID, ProductID, Quantity | Links orders and products |
| Orders | OrderID, CustomerID, EmployeeID, OrderDate, ShipperID | OrderID is the primary key; ShipperID links to Shippers |
| Shippers | ShipperID, ShipperName, Phone | ShipperID identifies a shipper |

## Example input

Illustrative data; only columns used in the calculation are shown.

### Products

| ProductID | ProductName | Price |
|---|---|---:|
| 1 | Notebook | 10.00 |
| 2 | Bottle | 25.00 |

### Shippers

| ShipperID | ShipperName |
|---|---|
| 1 | Speedy Express |
| 2 | United Package |

### Orders

| OrderID | OrderDate | ShipperID |
|---|---|---:|
| 101 | 2026-01-01 | 1 |
| 102 | 2026-01-01 | 1 |
| 103 | 2026-01-02 | 1 |
| 104 | 2026-01-01 | 2 |

### Order_Details

| OrderID | ProductID | Quantity |
|---|---:|---:|
| 101 | 1 | 5 |
| 102 | 2 | 2 |
| 103 | 2 | 10 |
| 104 | 1 | 3 |

## Expected output

| ShipperName | OrderDate | TotalSales | CumulativeSales |
|---|---|---:|---:|
| Speedy Express | 2026-01-01 | 100.00 | 100.00 |
| Speedy Express | 2026-01-02 | 250.00 | 350.00 |
| United Package | 2026-01-01 | 30.00 | 30.00 |

## Solution

```sql
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
```

[Open solution.sql](solution.sql)

## Step-by-step explanation

1. Join Shippers to Orders, Orders to Order_Details, and Order_Details to Products.
2. Compute each line's sales using price multiplied by quantity.
3. Group by shipper ID, shipper name, and order date to produce one daily row per shipper.
4. Partition the window by ShipperID so each shipper has an independent running total.
5. Order each partition by OrderDate and sum from the first row through the current row.
6. Round only the displayed daily and cumulative amounts.

### Daily aggregation walkthrough

| Shipper | Date | Calculation | Daily total |
|---|---|---|---:|
| Speedy Express | 2026-01-01 | (10 × 5) + (25 × 2) | 100.00 |
| Speedy Express | 2026-01-02 | 25 × 10 | 250.00 |
| United Package | 2026-01-01 | 10 × 3 | 30.00 |

Speedy Express's second cumulative value is 100 + 250 = 350. United Package starts its own running total at 30.

## Assumptions and important details

- `OrderDate` is a DATE. If it contains timestamps, group and order by its date portion to obtain calendar-day totals.
- `Price` is DECIMAL/NUMERIC, which supports the two-argument PostgreSQL ROUND function and is appropriate for money calculations.
- “Rounded up to 2 decimals” is interpreted as ordinary rounding. If strictly upward rounding is required, replace each `ROUND(value, 2)` with `CEILING(value * 100) / 100.0`.
- Group and partition by ShipperID so different shippers sharing a name are not merged.
- Inner joins report dates with matching order lines; shippers without sales do not appear.
- The supplied schema uses `Order_Details`; adjust that identifier if the database names it differently.
- The calculation uses the product price provided in this exercise. A real sales system would generally use the price recorded on each order line.
- SQL clients may display 100 instead of 100.00 even when the value is rounded to two decimals.
