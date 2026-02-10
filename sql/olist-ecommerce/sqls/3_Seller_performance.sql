
/* ============================================================

### 3️⃣ Seller Performance & Reliability
8. Which sellers have the highest late delivery rates (after applying a minimum order threshold)?
9. Which sellers contribute the largest absolute number of late deliveries?
10. Are high-volume sellers more or less reliable than low-volume sellers?
============================================================
*/

-- 8. Sellers with highest late delivery rates (min 50 orders)

SELECT 
    s.seller_id, ROUND(SUM(
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END
        )*1.0 / COUNT(o.order_status), 2) AS late_delivery_rate,
        COUNT(o.order_status) AS total_orders

FROM sellers s 
LEFT JOIN order_items oi ON s.seller_id = oi.seller_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
HAVING COUNT(o.order_status) >= 50
ORDER BY late_delivery_rate DESC
LIMIT 20;

-- among sellers with at least 500 orders to focus on more established sellers
SELECT 
    s.seller_id, ROUND(SUM(
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END
        )*1.0 / COUNT(o.order_status), 2) AS late_delivery_rate,
        COUNT(o.order_status) AS total_orders

FROM sellers s 
LEFT JOIN order_items oi ON s.seller_id = oi.seller_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
HAVING COUNT(o.order_status) >= 500
ORDER BY late_delivery_rate DESC
LIMIT 20;


-- 9. Sellers contributing largest absolute number of late deliveries
SELECT 
    s.seller_id, ROUND(SUM(
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END
        ), 2) AS late_delivery,
        COUNT(o.order_status) AS total_orders,
        ROUND(SUM(
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END
        ), 2)*1.0 / COUNT(o.order_status) AS late_delivery_rate
FROM sellers s 
LEFT JOIN order_items oi ON s.seller_id = oi.seller_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
HAVING COUNT(o.order_status) >= 50
ORDER BY late_delivery DESC
LIMIT 10;

-- 10. Are high-volume sellers more or less reliable than low-volume sellers?

WITH seller_stats AS (
    SELECT 
        s.seller_id,
        COUNT(o.order_id) AS total_orders,
        SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1 ELSE 0
            END
        ) AS late_delivery,
        SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1 ELSE 0
            END
        ) * 1.0 / COUNT(o.order_id) AS late_delivery_rate
    FROM sellers s 
    LEFT JOIN order_items oi ON s.seller_id = oi.seller_id
    LEFT JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY s.seller_id
)

SELECT
    CASE 
        WHEN total_orders <= 50 THEN 'low_volume'
        WHEN total_orders BETWEEN 51 AND 200 THEN 'mid_volume'
        ELSE 'high_volume'
    END AS volume_category,
    COUNT(seller_id) AS num_sellers,
    ROUND(AVG(late_delivery_rate), 3) AS avg_late_delivery_rate
FROM seller_stats
GROUP BY volume_category
ORDER BY num_sellers DESC;



