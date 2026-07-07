/*
===============================================================
Retail Data Analytics Project
File: 06_payment_analysis.sql
Author: Vivek Junare
===============================================================
*/


-- ==========================================================
-- Question 51: Payment Distribution by Type
-- ==========================================================

SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- ==========================================================
-- Question 52: Revenue by Payment Type
-- ==========================================================

SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;


-- ==========================================================
-- Question 53: Average Payment Value by Payment Type
-- ==========================================================

SELECT
    payment_type,
    ROUND(AVG(payment_value),2) AS average_payment
FROM payments
GROUP BY payment_type
ORDER BY average_payment DESC;


-- ==========================================================
-- Question 54: Average Installments by Payment Type
-- ==========================================================

SELECT
    payment_type,
    ROUND(AVG(payment_installments),2) AS average_installments
FROM payments
GROUP BY payment_type
ORDER BY average_installments DESC;


-- ==========================================================
-- Question 55: Highest Payment Transactions
-- ==========================================================

SELECT
    order_id,
    payment_type,
    payment_value
FROM payments
ORDER BY payment_value DESC
LIMIT 20;


-- ==========================================================
-- Question 56: Installment Distribution
-- ==========================================================

SELECT
    payment_installments,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_installments
ORDER BY payment_installments;


-- ==========================================================
-- Question 57: Revenue Generated Through Installments
-- ==========================================================

SELECT
    payment_installments,
    ROUND(SUM(payment_value),2) AS revenue
FROM payments
GROUP BY payment_installments
ORDER BY revenue DESC;


-- ==========================================================
-- Question 58: Average Payment Value by Installments
-- ==========================================================

SELECT
    payment_installments,
    ROUND(AVG(payment_value),2) AS average_payment
FROM payments
GROUP BY payment_installments
ORDER BY average_payment DESC;


-- ==========================================================
-- Question 59: Orders Paid in More Than One Installment
-- ==========================================================

SELECT
    COUNT(*) AS installment_orders
FROM payments
WHERE payment_installments > 1;


-- ==========================================================
-- Question 60: Orders Paid in a Single Installment
-- ==========================================================

SELECT
    COUNT(*) AS single_payment_orders
FROM payments
WHERE payment_installments = 1;