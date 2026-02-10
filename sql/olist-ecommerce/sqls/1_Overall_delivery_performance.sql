/* 
============================================================
Overall Delivery Performance
Questions 1–4
1. Percentage of orders delivered
2. Percentage of orders delivered late
3. Average delay (days) for late orders
4. Actual vs estimated delivery time
5. Monthly late delivery trend
============================================================
*/

--1. Percentage of orders delivered and other status values
SELECT 
order_status AS "ORDER STATUS",
    COUNT(*) AS "ORDERS",
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        3
    ) AS "% of Total Orders"
FROM orders
GROUP BY order_status
ORDER BY "% of Total Orders" DESC;

--2. Percentage of orders delivered late

SELECT 
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        3
    ) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered';

--3. Average delay (days) for late orders
SELECT ROUND(AVG(order_delivered_customer_date::DATE - order_estimated_delivery_date::DATE), 2) AS average_delay_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date;

--4. Actual vs estimated delivery time
SELECT 
    ROUND(AVG(order_delivered_customer_date::date 
              - order_purchase_timestamp::date), 2) 
        AS avg_actual_days,
        
    ROUND(AVG(order_estimated_delivery_date::date 
              - order_purchase_timestamp::date), 2) 
        AS avg_estimated_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
--On average, are we overpromising or underpromising?

SELECT 
    ROUND(
        AVG(
            (order_delivered_customer_date::date 
             - order_purchase_timestamp::date)
            -
            (order_estimated_delivery_date::date 
             - order_purchase_timestamp::date)
        ),
        2
    ) AS avg_difference_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
-- negative → deliveries are faster than promised

--5. Monthly late delivery trend
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp)::date AS month,

    COUNT(*) AS total_delivered,

    SUM(
        CASE 
            WHEN order_delivered_customer_date > order_estimated_delivery_date 
            THEN 1 
            ELSE 0 
        END
    ) AS late_orders,

    ROUND(
        100.0 * 
        SUM(
            CASE 
                WHEN order_delivered_customer_date > order_estimated_delivery_date 
                THEN 1 
                ELSE 0 
            END
        )
        / COUNT(*),
        2
    ) AS late_percentage

FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL

GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
ORDER BY month;
