/* ============================================================

### 5️⃣ Delivery Delays & Customer Experience
14. How do review scores differ between on-time and late deliveries?
15. Is there a relationship between delivery delay duration and review score?

============================================================ */

-- 14. How do review scores differ between on-time and late deliveries?
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date::date 
             > o.order_estimated_delivery_date::date
        THEN 'Late Delivery'
        ELSE 'On-Time Delivery'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews
FROM orders o 
LEFT JOIN reviews r 
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND r.review_score IS NOT NULL
GROUP BY delivery_status
ORDER BY average_review_score DESC;


-- 15. Is there a relationship between delivery delay duration and review score?
SELECT 
    ROUND(o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date, 2) AS delivery_diff_days,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews
FROM orders o 
LEFT JOIN reviews r 
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND r.review_score IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_diff_days
ORDER BY delivery_diff_days DESC;


SELECT 
    CASE 
        WHEN o.order_delivered_customer_date::date < o.order_estimated_delivery_date::date THEN 'Early Delivery'
        WHEN o.order_delivered_customer_date::date = o.order_estimated_delivery_date::date THEN 'On-Time Delivery'
        WHEN o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date > 0 AND o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date < 3 THEN '1-2 Days Late'
        WHEN o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date >= 3 AND o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date <= 7 THEN '3-7 Days Late'
        WHEN o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date > 7 THEN 'More than 7 Days Late'
        ELSE 'Unknown'
        END AS delivery_diff_days,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews,
    ROUND(
        100.0 * COUNT(r.review_id) 
        / SUM(COUNT(r.review_id)) OVER (), 
        2
    ) AS percentage_of_total,
    SUM(CASE WHEN r.review_score = 1 THEN 1 ELSE 0 END) AS one_star_count,

    ROUND(
    100.0 * SUM(CASE WHEN r.review_score = 1 THEN 1 ELSE 0 END)
    / COUNT(r.review_id),
    2
    ) AS one_star_percentage,
    ROUND(STDDEV(r.review_score), 2) AS std_dev

FROM orders o 
LEFT JOIN reviews r 
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND r.review_score IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_diff_days
ORDER BY average_review_score DESC;
