
CREATE VIEW fact_orders AS
WITH rank_reviews AS (
    SELECT
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS rnk,
        *
    FROM reviews
),
reviews_cte AS (
    SELECT *
    FROM rank_reviews
    WHERE rnk = 1
),
sum_cte AS (
    SELECT order_id,
        ROUND(SUM(payment_value), 2) AS total_per_order
    FROM payments
    GROUP BY order_id
)
SELECT
    c.customer_id,
    c.customer_unique_id,
    o.order_id,
    o.order_status,
    c.customer_state,
    c.customer_city,
    o.order_purchase_timestamp,
    o.order_estimated_delivery_date,
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date) AS days_delivered,
    CASE
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) >= 0 THEN 'on time'
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) < 0 THEN 'not on time'
        ELSE 'not delivered'
    END AS delivery_status,
    rcte.review_score,
    rcte.review_creation_date,
    rcte.review_answer_timestamp,
    scte.total_per_order
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN reviews_cte rcte ON o.order_id = rcte.order_id
LEFT JOIN sum_cte scte ON o.order_id = scte.order_id;
GO

CREATE VIEW fact_order_items AS
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,
    ct.product_category_name_english
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct ON p.product_category_name = ct.product_category_name;
GO