--  ------------------- PHASE 1 — Data Understanding ----------------------------
-- Total Orders ---
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total Customers --
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total Revenue KPI --
SELECT ROUND(SUM(price),2) AS total_revenue
FROM order_items;

-- Average Order Value --
SELECT ROUND(AVG(price),2) AS avg_order_value
FROM order_items;

-- ----------------- PHASE 2 — Business Analysis ----------------------------
--  Order Status Distribution --
SELECT order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Monthly Revenue Trend MOST IMPORTANT --
SELECT MONTH(o.order_purchase_timestamp) AS month,
ROUND(SUM(oi.price),2) AS monthly_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- Top 10 Products by Revenue --
SELECT product_id,
ROUND(SUM(price),2) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- Top Customers --
SELECT customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;
-- i ued also 20 queries --
SELECT ROUND(SUM(price),2) FROM order_items;

-- KPI Queries --
SELECT
MONTH(order_purchase_timestamp),
COUNT(*)
FROM orders
GROUP BY MONTH(order_purchase_timestamp);

-- Business Analysis --
SELECT order_status,
COUNT(*)
FROM orders
GROUP BY order_status;

-- JOIN Queries --
SELECT o.order_id, oi.price
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id;

-- Top Products --
SELECT product_id,
SUM(price) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- Customer Analysis --
SELECT customer_id,
COUNT(order_id)
FROM orders
GROUP BY customer_id
ORDER BY COUNT(order_id) DESC;

-- Subqueries --
SELECT
    o.customer_id,
    ROUND(SUM(oi.price),2) AS total_spent
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
HAVING total_spent >
(
    SELECT AVG(price)
    FROM order_items
)
ORDER BY total_spent DESC;

-- Window Functions --
SELECT order_id,price,
AVG(price) OVER() AS avg_price
FROM order_items;

-- Ranking Functions --
SELECT product_id,
SUM(price) AS revenue,
RANK() OVER(ORDER BY SUM(price) DESC) AS product_rank
FROM order_items
GROUP BY product_id;

-- CTEs (Common Table Expressions) --
WITH monthly_sales AS
(
    SELECT
        MONTH(order_purchase_timestamp) AS month,
        SUM(price) AS revenue
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY month
)

SELECT *
FROM monthly_sales
WHERE revenue > 100000;