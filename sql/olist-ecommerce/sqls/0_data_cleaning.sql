/* ============================================================
   OLIST DATA QUALITY VALIDATION
   Schema-aligned version
   Database: PostgreSQL
   ============================================================ */


/* ============================================================
   1. ROW COUNT OVERVIEW (Volume sanity check)
   ============================================================ */

SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'product_category_translation', COUNT(*) 
FROM product_category_translation;



/* ============================================================
   2. FOREIGN KEY VALIDATION
   (Should return ZERO rows due to constraints)
   ============================================================ */

-- Orders without customers (should be impossible)
SELECT o.*
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items without products
SELECT oi.*
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Order items without sellers
SELECT oi.*
FROM order_items oi
LEFT JOIN sellers s ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;



/* ============================================================
   3. ORDER TIMESTAMP CONSISTENCY
   Business logic validation
   ============================================================ */

-- Approved before purchase
SELECT *
FROM orders
WHERE order_approved_at < order_purchase_timestamp;

-- Delivered before shipped
SELECT COUNT(*) as count
FROM orders
WHERE order_delivered_customer_date < order_delivered_carrier_date;

-- Delivered before purchase
SELECT *
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Delivered status but missing delivery date
SELECT COUNT(*) as count
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;



/* ============================================================
   4. ORDER STATUS VS DATE CONSISTENCY
   ============================================================ */

-- Cancelled orders should not have delivery dates
SELECT count(*) as count
FROM orders
WHERE order_status = 'canceled'
  AND order_delivered_customer_date IS NOT NULL;



/* ============================================================
   5. NUMERIC DOMAIN VALIDATION
   ============================================================ */

-- Negative or zero price
SELECT *
FROM order_items
WHERE price <= 0;

-- Negative freight
SELECT *
FROM order_items
WHERE freight_value < 0;

-- Negative payment
SELECT COUNT(*) as count
FROM payments
WHERE payment_value <= 0;

-- Unrealistic product dimensions
SELECT COUNT(*) as count
FROM products
WHERE product_weight_g <= 0
   OR product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;



/* ============================================================
   6. REVIEW VALIDATION
   ============================================================ */

-- Scores outside 1–5 (should be impossible due to CHECK)
SELECT *
FROM reviews
WHERE review_score NOT BETWEEN 1 AND 5;

-- Review answered before creation
SELECT *
FROM reviews
WHERE review_answer_timestamp < review_creation_date;



/* ============================================================
   7. PRODUCT CATEGORY TRANSLATION CONSISTENCY
   ============================================================ */

-- Products without translation
SELECT DISTINCT p.product_category_name
FROM products p
LEFT JOIN product_category_translation t
  ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL;



/* ============================================================
   8. GEOLOCATION VALIDATION
   ============================================================ */

-- Invalid latitude/longitude
SELECT *
FROM geolocation
WHERE geolocation_lat NOT BETWEEN -90 AND 90
   OR geolocation_lng NOT BETWEEN -180 AND 180;

-- ZIP prefixes with multiple states (potential anomaly)
SELECT geolocation_zip_code_prefix,
       COUNT(DISTINCT geolocation_state) AS state_count
FROM geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(DISTINCT geolocation_state) > 1;



/* ============================================================
   9. BUSINESS METRICS VALIDATION
   ============================================================ */

-- Delivery time in days
SELECT order_id,
       (order_delivered_customer_date::date
        - order_purchase_timestamp::date) AS delivery_days
FROM orders
WHERE order_status = 'delivered';

-- Late delivery flag
SELECT order_id,
       CASE
           WHEN order_delivered_customer_date >
                order_estimated_delivery_date
           THEN 1 ELSE 0
       END AS is_late
FROM orders
WHERE order_status = 'delivered';



/* ============================================================
   END OF DATA QUALITY SCRIPT
   ============================================================ */
