-- Query 3: Carrier Reliability & On-Time Delivery (OTD) Benchmarking
SELECT 
    carrier_id,
    COUNT(order_id) AS total_shipments,
    ROUND(AVG(total_tat_hours), 2) AS avg_tat_hrs,
    SUM(is_sla_breach) AS breach_count,
    ROUND(100.0 * (1.0 - (SUM(is_sla_breach) * 1.0 / COUNT(order_id))), 2) AS on_time_delivery_rate_pct
FROM delivery_orders
GROUP BY carrier_id
ORDER BY on_time_delivery_rate_pct DESC;