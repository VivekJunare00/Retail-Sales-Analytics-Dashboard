/*
===============================================================
Retail Data Analytics Project
File: 08_review_analysis.sql
Author: Vivek Junare
===============================================================
*/


-- ==========================================================
-- Question 71: Average Review Score
-- ==========================================================

SELECT
    ROUND(AVG(review_score),2) AS average_review_score
FROM reviews;


-- ==========================================================
-- Question 72: Review Score Distribution
-- ==========================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- ==========================================================
-- Question 73: Percentage of Each Review Score
-- ==========================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(COUNT(*) * 100.0 /
          (SELECT COUNT(*) FROM reviews),2)
          AS percentage
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- ==========================================================
-- Question 74: Average Review Score by Product Category
-- ==========================================================

SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_rating DESC;


-- ==========================================================
-- Question 75: Top 10 Highest Rated Categories
-- ==========================================================

SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY average_rating DESC
LIMIT 10;


-- ==========================================================
-- Question 76: Bottom 10 Rated Categories
-- ==========================================================

SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY average_rating ASC
LIMIT 10;


-- ==========================================================
-- Question 77: Average Review Score by Seller
-- ==========================================================

SELECT
    oi.seller_id,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
GROUP BY oi.seller_id
ORDER BY average_rating DESC
LIMIT 20;


-- ==========================================================
-- Question 78: Review Score by Payment Type
-- ==========================================================

SELECT
    p.payment_type,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN payments p
    ON r.order_id = p.order_id
GROUP BY p.payment_type
ORDER BY average_rating DESC;


-- ==========================================================
-- Question 79: Review Score by Order Status
-- ==========================================================

SELECT
    o.order_status,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY o.order_status
ORDER BY average_rating DESC;


-- ==========================================================
-- Question 80: Average Review Score for Late vs On-Time Deliveries
-- ==========================================================

SELECT
CASE
WHEN order_delivered_customer_date >
     order_estimated_delivery_date
THEN 'Late Delivery'
ELSE 'On-Time Delivery'
END AS delivery_status,

ROUND(AVG(r.review_score),2) AS average_rating

FROM orders o
JOIN reviews r
ON o.order_id = r.order_id

WHERE order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status;