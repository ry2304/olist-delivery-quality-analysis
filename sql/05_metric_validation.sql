SELECT SUM(total_per_order) AS total_revenue_payments
FROM fact_orders;


SELECT SUM(total_per_order) AS revenue_at_risk_payments
FROM fact_orders
WHERE delivery_status <> 'on time';

SELECT SUM(oi.price + oi.freight_value) AS revenue_at_risk_items
FROM order_items oi
LEFT JOIN fact_orders fo ON oi.order_id = fo.order_id
WHERE fo.delivery_status <> 'on time';


WITH order_counts AS (
    SELECT c.customer_unique_id, COUNT(o.order_id) AS num_of_orders
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT ROUND(
    (SELECT COUNT(*) * 100.0 FROM order_counts WHERE num_of_orders > 1)
    / (SELECT COUNT(customer_unique_id) FROM order_counts),
2) AS repeat_purchase_rate
FROM order_counts;
