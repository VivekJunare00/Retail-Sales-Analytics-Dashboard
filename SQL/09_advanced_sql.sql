/*
===============================================================
Retail Data Analytics Project
File: 09_advanced_sql.sql
Author: Vivek Junare
===============================================================
*/


-- ==========================================================
-- Question 81: Rank States by Revenue
-- ==========================================================

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS revenue,
    RANK() OVER(
        ORDER BY SUM(p.payment_value) DESC
    ) AS revenue_rank
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments p
ON o.order_id=p.order_id
GROUP BY c.customer_state;


-- ==========================================================
-- Question 82: Dense Rank Product Categories by Revenue
-- ==========================================================

SELECT
    pr.product_category_name,
    ROUND(SUM(pay.payment_value),2) revenue,

    DENSE_RANK() OVER(
        ORDER BY SUM(pay.payment_value) DESC
    ) category_rank

FROM products pr
JOIN order_items oi
ON pr.product_id=oi.product_id
JOIN payments pay
ON oi.order_id=pay.order_id

GROUP BY pr.product_category_name;


-- ==========================================================
-- Question 83: Top Seller in Every State
-- ==========================================================

WITH SellerRevenue AS
(
SELECT

s.seller_state,
oi.seller_id,
SUM(p.payment_value) revenue,

ROW_NUMBER() OVER(
PARTITION BY s.seller_state
ORDER BY SUM(p.payment_value) DESC
) rn

FROM sellers s
JOIN order_items oi
ON s.seller_id=oi.seller_id
JOIN payments p
ON oi.order_id=p.order_id

GROUP BY
s.seller_state,
oi.seller_id
)

SELECT *
FROM SellerRevenue
WHERE rn=1;


-- ==========================================================
-- Question 84: Running Monthly Revenue
-- ==========================================================

WITH MonthlyRevenue AS
(
SELECT

DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') Month,

SUM(payment_value) Revenue

FROM orders o
JOIN payments p
ON o.order_id=p.order_id

GROUP BY Month
)

SELECT

Month,
Revenue,

SUM(Revenue)
OVER(
ORDER BY Month
) Running_Revenue

FROM MonthlyRevenue;


-- ==========================================================
-- Question 85: Monthly Revenue Growth
-- ==========================================================

WITH MonthlyRevenue AS
(
SELECT

DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') Month,

SUM(payment_value) Revenue

FROM orders o
JOIN payments p
ON o.order_id=p.order_id

GROUP BY Month
)

SELECT

Month,
Revenue,

LAG(Revenue)
OVER(
ORDER BY Month
) Previous_Month,

Revenue-
LAG(Revenue)
OVER(
ORDER BY Month)
Revenue_Growth

FROM MonthlyRevenue;


-- ==========================================================
-- Question 86: Top 3 Customers in Every State
-- ==========================================================

WITH CustomerRevenue AS
(
SELECT

c.customer_state,

c.customer_id,

SUM(p.payment_value) Revenue,

ROW_NUMBER() OVER(

PARTITION BY c.customer_state

ORDER BY SUM(p.payment_value) DESC

) rn

FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments p
ON o.order_id=p.order_id

GROUP BY
c.customer_state,
c.customer_id
)

SELECT *
FROM CustomerRevenue
WHERE rn<=3;


-- ==========================================================
-- Question 87: Moving Average Revenue
-- ==========================================================

WITH MonthlyRevenue AS
(
SELECT

DATE_FORMAT(order_purchase_timestamp,'%Y-%m') Month,

SUM(payment_value) Revenue

FROM orders o
JOIN payments p
ON o.order_id=p.order_id

GROUP BY Month
)

SELECT

Month,
Revenue,

ROUND(
AVG(Revenue)
OVER(

ORDER BY Month

ROWS BETWEEN
2 PRECEDING
AND CURRENT ROW

),2)

Moving_Average

FROM MonthlyRevenue;


-- ==========================================================
-- Question 88: Highest Revenue Order
-- ==========================================================

SELECT *

FROM
(
SELECT

order_id,

SUM(payment_value) revenue,

ROW_NUMBER()
OVER(
ORDER BY SUM(payment_value) DESC
) rn

FROM payments

GROUP BY order_id

)t

WHERE rn=1;


-- ==========================================================
-- Question 89: Bottom 10 Customers by Spending
-- ==========================================================

SELECT

customer_id,

SUM(payment_value) revenue

FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments p
ON o.order_id=p.order_id

GROUP BY customer_id

ORDER BY revenue

LIMIT 10;


-- ==========================================================
-- Question 90: Revenue Contribution Percentage by State
-- ==========================================================

SELECT

customer_state,

ROUND(SUM(payment_value),2) revenue,

ROUND(

SUM(payment_value)*100/

SUM(SUM(payment_value))
OVER(),

2)

percentage_of_revenue

FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments p
ON o.order_id=p.order_id

GROUP BY customer_state

ORDER BY revenue DESC;