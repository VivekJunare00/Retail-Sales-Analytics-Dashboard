/*
===============================================================
Retail Data Analytics Project
File: 02_order_analysis.sql
Author: Vivek Junare
===============================================================
*/

-- Question 11: How many orders are in each status?

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Question 12: Revenue by Order Status

SELECT
    o.order_status,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;


-- Question 13: Average Delivery Time

SELECT
ROUND(
AVG(DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp)),2)
AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Question 14: Average Approval Time

SELECT
ROUND(
AVG(TIMESTAMPDIFF(HOUR,
order_purchase_timestamp,
order_approved_at)),2)
AS avg_approval_hours
FROM orders
WHERE order_approved_at IS NOT NULL;


-- Question 15: Orders per Month

SELECT
DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS Month,
COUNT(*) AS Orders
FROM orders
GROUP BY Month
ORDER BY Month;


-- Question 16: Monthly Revenue

SELECT
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS Month,
ROUND(SUM(p.payment_value),2) AS Revenue
FROM orders o
JOIN payments p
ON o.order_id=p.order_id
GROUP BY Month
ORDER BY Month;


-- Question 17: Average Payment per Order

SELECT
ROUND(AVG(payment_value),2) AS Average_Order_Value
FROM payments;


-- Question 18: Top 10 Highest Payment Orders

SELECT
order_id,
ROUND(payment_value,2) AS payment
FROM payments
ORDER BY payment DESC
LIMIT 10;


-- Question 19: Late Deliveries

SELECT
COUNT(*) AS late_orders
FROM orders
WHERE order_delivered_customer_date >
order_estimated_delivery_date;


-- Question 20: On-Time Deliveries

SELECT
COUNT(*) AS on_time_orders
FROM orders
WHERE order_delivered_customer_date <=
order_estimated_delivery_date;
