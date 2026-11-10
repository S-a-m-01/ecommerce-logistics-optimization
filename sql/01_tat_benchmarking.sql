-- Order-to-Delivery Turnaround Time (TAT) Calculation
WITH delivery_metrics AS (
    SELECT 
        order_id,
        hub_id,
        carrier_id,
        region,
        order_timestamp,
        dispatch_timestamp,
        delivery_timestamp,
        promised_delivery_timestamp,
        ROUND(EXTRACT(EPOCH FROM (dispatch_timestamp - order_timestamp)) / 3600.0, 2) AS processing_tat_hours,
        ROUND(EXTRACT(EPOCH FROM (delivery_timestamp - dispatch_timestamp)) / 3600.0, 2) AS transit_tat_hours,
        ROUND(EXTRACT(EPOCH FROM (delivery_timestamp - order_timestamp)) / 3600.0, 2) AS total_tat_hours,
        CASE WHEN delivery_timestamp > promised_delivery_timestamp THEN 1 ELSE 0 END AS is_sla_breach
    FROM delivery_orders
    WHERE order_status = 'DELIVERED'
)
SELECT 
    region,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(processing_tat_hours), 2) AS avg_warehouse_tat,
    ROUND(AVG(transit_tat_hours), 2) AS avg_transit_tat,
    ROUND(AVG(total_tat_hours), 2) AS avg_total_tat,
    ROUND(100.0 * SUM(is_sla_breach) / COUNT(order_id), 2) AS sla_breach_rate_pct
FROM delivery_metrics
GROUP BY region
ORDER BY sla_breach_rate_pct DESC;
