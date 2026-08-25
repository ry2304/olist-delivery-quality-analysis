WITH state_revenue AS (
    SELECT
        fo.customer_state,
        ROUND(SUM(foi.price), 2) AS total_revenue,
        ROUND(SUM(foi.price) * 100.0 / (SELECT SUM(price) FROM fact_order_items), 2) AS revenue_rate
    FROM fact_orders fo
    LEFT JOIN fact_order_items foi ON fo.order_id = foi.order_id
    GROUP BY fo.customer_state
),
state_ontime AS (
    SELECT
        customer_state,
        ROUND(
            SUM(CASE WHEN delivery_status = 'on time' THEN 1.0 ELSE 0.0 END)
            / NULLIF(SUM(CASE WHEN delivery_status IN ('on time', 'not on time') THEN 1 ELSE 0 END), 0) * 100,
        2) AS on_time_delivery_rate,
        COUNT(*) AS order_count
    FROM fact_orders
    GROUP BY customer_state
),
state_review AS (
    SELECT customer_state, ROUND(AVG(review_score * 1.0), 2) AS review_score
    FROM fact_orders
    GROUP BY customer_state
)
SELECT
    sr.customer_state,
    sr.total_revenue,
    sr.revenue_rate,
    so.on_time_delivery_rate,
    so.order_count,
    sv.review_score
FROM state_revenue sr
LEFT JOIN state_ontime so ON sr.customer_state = so.customer_state
LEFT JOIN state_review sv ON sr.customer_state = sv.customer_state
ORDER BY sr.total_revenue DESC;
