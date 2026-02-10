
/* ============================================================

### 4️⃣ Product Category Impact
11. Which product categories have the longest average delivery times?
12. Which categories have the highest late delivery rates?
13. Are delivery delays concentrated in a small number of product categories?

/* ============================================================
    NULL CATEGORY ANALYSIS
    ============================================================ */
SELECT COUNT(*) as count_null
FROM products p
WHERE p.product_category_name IS NULL;

SELECT COUNT(*) as count_products
FROM products p



SELECT 
    ROUND(
        COUNT(*) *100.0 /
        (SELECT COUNT(*) FROM products)  
        ,2) AS percent_null

FROM products p
WHERE p.product_category_name IS NULL;
--1.85 % of products have null category

SELECT pt.product_category_name_english, 
p.product_category_name
FROM products p
LEFT JOIN product_category_translation pt ON pt.product_category_name = p.product_category_name
WHERE pt.product_category_name_english IS NULL;

SELECT COUNT(*) AS missing_translations
FROM products p
LEFT JOIN product_category_translation pt ON pt.product_category_name = p.product_category_name
WHERE pt.product_category_name_english IS NULL;

--632 - 610 = 22 products have categories that are not translated

-- 11. Which product categories have the longest average delivery times?
--When this category appears in an order, how long does the order take?”
SELECT  
    pt.product_category_name_english,
    ROUND(
        AVG((o.order_delivered_customer_date::date
             - o.order_purchase_timestamp::date)
        ) , 2) AS delivery_days,
    COUNT(o.order_id) AS total_orders
FROM orders o
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt 
    ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered' 
    AND pt.product_category_name_english IS NOT NULL
GROUP BY pt.product_category_name_english
ORDER BY delivery_days DESC;

-- 12. Which categories have the highest late delivery rates?

--Experimenting with different ways to calculate late delivery rates.
-- Here by using DISTINCT order_id to avoid double counting orders with multiple items in the same category. 
--This is more accurate but may understate the late delivery rate for categories that often appear as secondary items in orders.


SELECT  
    pt.product_category_name_english,
    ROUND(
        COUNT(DISTINCT CASE 
            WHEN o.order_delivered_customer_date::date 
                 > o.order_estimated_delivery_date::date
            THEN o.order_id
        END) * 1.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS late_deliveries_rate,
    ROUND(
        AVG(
            o.order_delivered_customer_date::date 
            - o.order_purchase_timestamp::date
        ),
        2
    ) AS delivery_time_days,
    COUNT(DISTINCT o.order_id) AS total_orders

FROM orders o
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt 
    ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered'
  AND pt.product_category_name_english IS NOT NULL
GROUP BY pt.product_category_name_english
ORDER BY late_deliveries_rate DESC;


-- This method counts an order as late if any of its items belong to a category that is delivered late. 
-- It may overstate the late delivery rate for categories that often appear as secondary items in orders
SELECT  
    pt.product_category_name_english,
    ROUND(
        COUNT(CASE 
            WHEN o.order_delivered_customer_date::date 
                 > o.order_estimated_delivery_date::date
            THEN o.order_id
        END) * 1.0
        / COUNT(o.order_id),
        2
    ) AS late_deliveries_rate,
    ROUND(
        AVG(
            o.order_delivered_customer_date::date 
            - o.order_purchase_timestamp::date
        ),
        2
    ) AS delivery_time_days,
    COUNT(o.order_id) AS total_orders

FROM orders o
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt 
    ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered'
  AND pt.product_category_name_english IS NOT NULL
GROUP BY pt.product_category_name_english
ORDER BY late_deliveries_rate DESC;




-- 13. Are delivery delays concentrated in a small number of product categories?
WITH delays_by_category AS (
SELECT pt.product_category_name_english, 
    SUM(CASE 
            WHEN o.order_delivered_customer_date::date 
                 > o.order_estimated_delivery_date::date
            THEN 1
            ELSE 0
        END) AS late_deliveries,
        COUNT(*) AS total_deliveries
FROM orders o
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt 
    ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered'
  AND pt.product_category_name_english IS NOT NULL
GROUP BY pt.product_category_name_english) 



SELECT *,
       ROUND(
           late_deliveries::numeric 
           / SUM(late_deliveries) OVER (),
           4
       ) AS share_of_all_late
FROM delays_by_category
ORDER BY late_deliveries DESC;
-- What percentage of ALL late deliveries comes from each category?




