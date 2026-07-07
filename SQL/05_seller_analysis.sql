/*
===============================================================
Retail Data Analytics Project
File: 05_seller_analysis.sql
Author: Vivek Junare
===============================================================
*/


-- ==========================================================
-- Question 41: Total Number of Sellers
-- ==========================================================

SELECT
    COUNT(*) AS total_sellers
FROM sellers;


-- ==========================================================
-- Question 42: Top 10 Sellers by Revenue
-- ==========================================================

SELECT
    oi.seller_id,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM order_items oi
JOIN payments p
    ON oi.order_id = p.order_id
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ==========================================================
-- Question 43: Top 10 Sellers by Orders
-- ==========================================================

SELECT
    seller_id,
    COUNT(order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;


-- ==========================================================
-- Question 44: Average Freight Charged by Seller
-- ==========================================================

SELECT
    seller_id,
    ROUND(AVG(freight_value),2) AS avg_freight
FROM order_items
GROUP BY seller_id
ORDER BY avg_freight DESC
LIMIT 10;


-- ==========================================================
-- Question 45: Seller Revenue Ranking
-- ==========================================================

SELECT
    oi.seller_id,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM order_items oi
JOIN payments p
    ON oi.order_id = p.order_id
GROUP BY oi.seller_id
ORDER BY revenue DESC;


-- ==========================================================
-- Question 46: Sellers Operating in Each State
-- ==========================================================

SELECT
    seller_state,
    COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;


-- ==========================================================
-- Question 47: Top Seller States by Revenue
-- ==========================================================

SELECT
    s.seller_state,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
JOIN payments p
    ON oi.order_id = p.order_id
GROUP BY seller_state
ORDER BY revenue DESC;


-- ==========================================================
-- Question 48: Average Revenue per Seller State
-- ==========================================================

SELECT
    s.seller_state,
    ROUND(AVG(p.payment_value),2) AS avg_revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
JOIN payments p
    ON oi.order_id = p.order_id
GROUP BY seller_state
ORDER BY avg_revenue DESC;


-- ==========================================================
-- Question 49: Sellers with More Than 100 Orders
-- ==========================================================

SELECT
    seller_id,
    COUNT(order_id) AS total_orders
FROM order_items
GROUP BY seller_id
HAVING COUNT(order_id) > 100
ORDER BY total_orders DESC;


-- ==========================================================
-- Question 50: Average Items Sold per Seller
-- ==========================================================

SELECT
    ROUND(
        COUNT(order_id) /
        COUNT(DISTINCT seller_id),
        2
    ) AS average_items_per_seller
FROM order_items;

/*Key Insights

• São Paulo sellers generated the highest revenue.

• The top 10 sellers contributed X% of total sales.

• Freight charges varied significantly between sellers.

• Seller concentration is highest in the Southeast region.
*/