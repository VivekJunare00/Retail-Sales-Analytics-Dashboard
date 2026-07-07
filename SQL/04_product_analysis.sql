/*
===============================================================
Retail Data Analytics Project
File: 04_product_analysis.sql
Author: Vivek Junare
===============================================================
*/

-- ==========================================================
-- Question 31: Total Products
-- ==========================================================

SELECT
    COUNT(*) AS total_products
FROM products;


-- ==========================================================
-- Question 32: Products by Category
-- ==========================================================

SELECT
    product_category_name,
    COUNT(*) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY total_products DESC;


-- ==========================================================
-- Question 33: Top 20 Selling Product Categories
-- ==========================================================

SELECT
    p.product_category_name,
    COUNT(oi.product_id) AS total_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 20;


-- ==========================================================
-- Question 34: Revenue by Product Category
-- ==========================================================

SELECT
    p.product_category_name,
    ROUND(SUM(pay.payment_value),2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN payments pay
    ON oi.order_id = pay.order_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 20;


-- ==========================================================
-- Question 35: Average Product Weight
-- ==========================================================

SELECT
    ROUND(AVG(product_weight_g),2) AS average_weight
FROM products;


-- ==========================================================
-- Question 36: Top 20 Heaviest Products
-- ==========================================================

SELECT
    product_id,
    product_weight_g
FROM products
ORDER BY product_weight_g DESC
LIMIT 20;


-- ==========================================================
-- Question 37: Average Number of Photos per Product
-- ==========================================================

SELECT
    ROUND(AVG(product_photos_qty),2) AS average_photos
FROM products;


-- ==========================================================
-- Question 38: Average Product Description Length
-- ==========================================================

SELECT
    ROUND(AVG(product_description_lenght),2) AS average_description_length
FROM products;


-- ==========================================================
-- Question 39: Average Product Name Length
-- ==========================================================

SELECT
    ROUND(AVG(product_name_lenght),2) AS average_name_length
FROM products;


-- ==========================================================
-- Question 40: Categories with Highest Average Revenue
-- ==========================================================

SELECT
    p.product_category_name,
    ROUND(AVG(pay.payment_value),2) AS average_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN payments pay
    ON oi.order_id = pay.order_id
GROUP BY p.product_category_name
ORDER BY average_revenue DESC;
