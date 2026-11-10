-- Query 2: Hub-Level Bottlenecks & Ranking via Window Functions
WITH hub_stats AS (
    SELECT 
        hub_id,
        region,
        COUNT(order_id) AS total_orders,
        SUM(is_sla_breach) AS breach_count,
        ROUND(100.0 * SUM(is_sla_breach) / COUNT(order_id), 2) AS hub_breach_pct,
        ROUND(AVG(total_tat_hours), 2) AS avg_tat_hrs
    FROM delivery_orders
    GROUP BY hub_id, region
)
SELECT 
    hub_id,
    region,
    total_orders,
    breach_count,
    hub_breach_pct,
    ROUND(100.0 * breach_count / SUM(breach_count) OVER (), 2) AS pct_of_total_system_breaches,
    DENSE_RANK() OVER (ORDER BY hub_breach_pct DESC) AS bottleneck_severity_rank
FROM hub_stats
ORDER BY bottleneck_severity_rank;