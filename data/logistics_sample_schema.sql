-- Table definition for delivery_orders
CREATE TABLE delivery_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    hub_id VARCHAR(20) NOT NULL,
    carrier_id VARCHAR(50) NOT NULL,
    region VARCHAR(30) NOT NULL,
    order_timestamp TIMESTAMP NOT NULL,
    dispatch_timestamp TIMESTAMP NOT NULL,
    delivery_timestamp TIMESTAMP NOT NULL,
    promised_delivery_timestamp TIMESTAMP NOT NULL,
    order_status VARCHAR(20) DEFAULT 'DELIVERED',
    is_sla_breach INT DEFAULT 0,
    total_tat_hours NUMERIC(6, 2)
);
