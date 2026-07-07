/*
===============================================================
Retail Data Analytics Project
File: 07_delivery_analysis.sql
Author: Vivek Junare
===============================================================
*/


-- ==========================================================
-- Question 61: Average Delivery Time (Days)
-- ==========================================================

SELECT
    ROUND(
        AVG(DATEDIFF(order_delivered_customer_date,
                     order_purchase_timestamp)),2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ==========================================================
-- Question 62: Average Approval Time (Hours)
-- ==========================================================

SELECT
    ROUND(
        AVG(TIMESTAMPDIFF(HOUR,
                          order_purchase_timestamp,
                          order_approved_at)),2
    ) AS average_approval_hours
FROM orders
WHERE order_approved_at IS NOT NULL;


-- ==========================================================
-- Question 63: Number of Late Deliveries
-- ==========================================================

SELECT
    COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date >
      order_estimated_delivery_date;


-- ==========================================================
-- Question 64: Number of On-Time Deliveries
-- ==========================================================

SELECT
    COUNT(*) AS on_time_deliveries
FROM orders
WHERE order_delivered_customer_date <=
      order_estimated_delivery_date;


-- ==========================================================
-- Question 65: Late Delivery Percentage
-- ==========================================================

SELECT
ROUND(
COUNT(CASE
WHEN order_delivered_customer_date >
order_estimated_delivery_date
THEN 1 END)
*100.0/
COUNT(*),2)
AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ==========================================================
-- Question 66: Earliest Deliveries
-- ==========================================================

SELECT
order_id,
DATEDIFF(order_estimated_delivery_date,
order_delivered_customer_date)
AS days_early
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
ORDER BY days_early DESC
LIMIT 20;


-- ==========================================================
-- Question 67: Slowest Deliveries
-- ==========================================================

SELECT
order_id,
DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp)
AS delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
ORDER BY delivery_days DESC
LIMIT 20;


-- ==========================================================
-- Question 68: Monthly Average Delivery Time
-- ==========================================================

SELECT
DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS month,
ROUND(
AVG(DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp)),2)
AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY month
ORDER BY month;


-- ==========================================================
-- Question 69: Orders Delivered Within 7 Days
-- ==========================================================

SELECT
COUNT(*) AS delivered_within_7_days
FROM orders
WHERE DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp) <= 7;


-- ==========================================================
-- Question 70: Orders Taking More Than 30 Days
-- ==========================================================

SELECT
COUNT(*) AS delivered_after_30_days
FROM orders
WHERE DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp) > 30;