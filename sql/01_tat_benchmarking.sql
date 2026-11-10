-- Query 1: Turnaround Time (TAT) & SLA Breach Breakdown by Region
SELECT 
    region,
    COUNT(order_id) AS total_orders,
    ROUND(AVG((julianday(dispatch_timestamp) - julianday(order_timestamp)) * 24), 2) AS avg_warehouse_tat_hrs,
    ROUND(AVG((julianday(delivery_timestamp) - julianday(dispatch_timestamp)) * 24), 2) AS avg_transit_tat_hrs,
    ROUND(AVG(total_tat_hours), 2) AS avg_total_tat_hrs,
    ROUND(100.0 * SUM(is_sla_breach) / COUNT(order_id), 2) AS sla_breach_rate_pct
FROM delivery_orders
GROUP BY region
ORDER BY sla_breach_rate_pct DESC;