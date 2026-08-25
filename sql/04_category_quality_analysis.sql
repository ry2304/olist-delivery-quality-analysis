SELECT
    foi.product_category_name_english,
    ROUND(AVG(fo.review_score * 1.0), 2) AS avg_review_score_on_time,
    COUNT(*) AS on_time_order_count
FROM fact_order_items foi
LEFT JOIN fact_orders fo ON foi.order_id = fo.order_id
WHERE fo.delivery_status = 'on time'
GROUP BY foi.product_category_name_english
HAVING COUNT(foi.order_id) > 200
ORDER BY avg_review_score_on_time ASC;
