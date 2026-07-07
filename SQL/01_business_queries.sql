/*
============================================================
Retail Data Analytics Project
Business Questions - Part 1
Author: Vivek Junare
============================================================
*/



-- Question 1: What is the total revenue generated?

SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments;


-- Question 2: How many orders are there?


SELECT
    COUNT(*) AS total_orders
FROM orders;


-- Question 3: How many customers are there?


SELECT
    COUNT(*) AS total_customers
FROM customers;


-- Question 4: How many sellers are there?


SELECT
    COUNT(*) AS total_sellers
FROM sellers;


-- Question 5: What is the Average Order Value (AOV)?


SELECT
    ROUND(SUM(payment_value) / COUNT(*), 2) AS average_order_value
FROM payments;


-- Question 6: How many orders are there by status?


SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Question 7: Which payment methods are used the most?


SELECT
    payment_type,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_type
ORDER BY total_payments DESC;
 

-- Question 8: Which states have the highest number of customers?

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;


-- Question 9: What is the average customer review score?

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;


-- Question 10: Top 10 states with the highest number of customers

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;
