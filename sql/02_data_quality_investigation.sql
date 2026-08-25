SELECT COUNT(*)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT COUNT(*)
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id;


SELECT COUNT(*) AS order_count,
    CASE
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) >= 0 THEN 'on time'
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) < 0 THEN 'not on time'
        ELSE 'not delivered'
    END AS delivery_status
FROM orders o
GROUP BY
    CASE
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) >= 0 THEN 'on time'
        WHEN DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) < 0 THEN 'not on time'
        ELSE 'not delivered'
    END;


SELECT order_id, COUNT(*) AS review_count
FROM reviews
GROUP BY order_id
HAVING COUNT(*) > 1;


WITH rank_reviews AS (
    SELECT ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS rnk, *
    FROM reviews
)
SELECT o.order_id, o.order_status
FROM orders o
LEFT JOIN rank_reviews rr ON o.order_id = rr.order_id
WHERE rnk = 1;


WITH rank_reviews AS (
    SELECT ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS rnk, *
    FROM reviews
),
clean_review AS (
    SELECT order_id, review_score, review_creation_date, review_answer_timestamp
    FROM rank_reviews
    WHERE rnk = 1
)
SELECT o.order_id, cr.review_score
FROM orders o
LEFT JOIN clean_review cr ON o.order_id = cr.order_id;


SELECT fo.order_id, fo.delivery_status, fo.review_score
FROM fact_orders fo
WHERE fo.delivery_status = 'not delivered' AND fo.review_score IS NOT NULL;


SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END) AS null_geolocation_lat,
    SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END) AS null_geolocation_lng
FROM geolocation;
