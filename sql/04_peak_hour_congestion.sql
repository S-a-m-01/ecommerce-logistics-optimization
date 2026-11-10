-- Query 4: Peak Surge Hour Dispatch Analysis
SELECT 
    strftime('%H', order_timestamp) AS order_hour_utc,
    COUNT(order_id) AS orders_received,
    ROUND(AVG((julianday(dispatch_timestamp) - julianday(order_timestamp)) * 24), 2) AS avg_intake_delay_hrs,
    SUM(is_sla_breach) AS total_breaches,
    ROUND(100.0 * SUM(is_sla_breach) / COUNT(order_id), 2) AS breach_rate_pct
FROM delivery_orders
GROUP BY order_hour_utc
ORDER BY breach_rate_pct DESC
LIMIT 8;