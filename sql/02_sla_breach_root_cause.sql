-- Identifying Hub-Level Bottlenecks using Window Functions
WITH hub_performance AS (
    SELECT 
        hub_id,
        region,
        COUNT(order_id) AS total_shipments,
        SUM(CASE WHEN delivery_timestamp > promised_delivery_timestamp THEN 1 ELSE 0 END) AS breach_count,
        AVG(EXTRACT(EPOCH FROM (delivery_timestamp - promised_delivery_timestamp)) / 3600.0) AS avg_delay_hours
    FROM delivery_orders
    WHERE delivery_timestamp > promised_delivery_timestamp
    GROUP BY hub_id, region
)
SELECT 
    hub_id,
    region,
    total_shipments,
    breach_count,
    ROUND(avg_delay_hours::numeric, 2) AS avg_breach_delay_hours,
    ROUND(100.0 * breach_count / SUM(breach_count) OVER (), 2) AS pct_of_total_breaches,
    DENSE_RANK() OVER (ORDER BY breach_count DESC) AS breach_severity_rank
FROM hub_performance
ORDER BY breach_severity_rank;
