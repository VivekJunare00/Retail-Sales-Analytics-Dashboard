/*
===============================================================
Retail Data Analytics Project
File: 03__customer_analysis.sql
Author: Vivek Junare
===============================================================
*/

-- ==========================================================
-- Question 21: Customers by State
-- ==========================================================

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;


-- ==========================================================
-- Question 22: Top 10 States by Revenue
-- ==========================================================

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;


-- ==========================================================
-- Question 23: Average Revenue by State
-- ==========================================================

SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value),2) AS average_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY average_revenue DESC;


-- ==========================================================
-- Question 24: Top 10 Customers by Spending
-- ==========================================================

SELECT
    c.customer_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- ==========================================================
-- Question 25: Customers with Multiple Orders
-- ==========================================================

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;


-- ==========================================================
-- Question 26: Average Orders per Customer
-- ==========================================================

SELECT
    ROUND(
        COUNT(order_id) / COUNT(DISTINCT customer_id),
        2
    ) AS average_orders_per_customer
FROM orders;


-- ==========================================================
-- Question 27: Revenue by ZIP Code
-- ==========================================================

SELECT
    c.customer_zip_code_prefix,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_zip_code_prefix
ORDER BY revenue DESC
LIMIT 20;


-- ==========================================================
-- Question 28: Top 20 Cities by Customers
-- ==========================================================

SELECT
    customer_city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 20;


-- ==========================================================
-- Question 29: Top 20 Cities by Revenue
-- ==========================================================

SELECT
    c.customer_city,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY revenue DESC
LIMIT 20;


-- ==========================================================
-- Question 30: Revenue Contribution by State
-- ==========================================================

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;
