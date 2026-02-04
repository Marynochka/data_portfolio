
/* ============================================================
  Geographic Analysis (Regional Delivery Performance)
5. Which customer states have the highest late delivery rates?
6. What is the average delivery time by customer state?
7. Which regions consistently underperform compared to the national average?
   ============================================================ */

-- 5. Customer states with highest late delivery rates
SELECT 
    c.customer_state AS STATE,
    COUNT(*) AS total_orders,
    ROUND(
        SUM(
        CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 
        ELSE 0 
        END
    ) *1.0 / COUNT(*), 3 )AS late_delivery_rate
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered' 
GROUP BY c.customer_state
ORDER BY late_delivery_rate DESC;




-- 6. Average delivery time by customer state
SELECT 
    c.customer_state, 
    ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 2) AS avg_delivery_time_days
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_time_days DESC;


--7.Which regions consistently underperform compared to the national average?
WITH national_avg AS (
  SELECT AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date) AS avg_delivery_time_national
  FROM orders o
  WHERE o.order_status = 'delivered'
)
SELECT c.customer_state,
         ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 2) AS avg_delivery_time_state,
         ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date) - national_avg.avg_delivery_time_national, 2) AS deviation_from_national_avg
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
CROSS JOIN national_avg
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state, national_avg.avg_delivery_time_national
ORDER BY deviation_from_national_avg DESC;