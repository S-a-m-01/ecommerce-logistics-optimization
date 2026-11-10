# Supply Chain & Logistics Operations Optimization

## Executive Summary
This project analyzes **100,000+ e-commerce delivery transactions** across 15+ fulfillment hubs to diagnose operational fulfillment bottlenecks, calculate Order-to-Delivery Turnaround Time (TAT), and isolate root causes of Service Level Agreement (SLA) breaches across regional carrier tiers.

By leveraging **PostgreSQL/MySQL analytical window functions** and **Python (Pandas)**, the analysis uncovered that **72% of delivery SLA breaches** originated during mid-mile sorting and transit handoffs during peak operational windows. A cross-docking workflow redesign and dynamic dispatch buffer framework were modeled, projecting an **18% improvement in On-Time Delivery (OTD)**.

---

## Key Business Questions Answered
1. **Turnaround Time (TAT) Benchmarking:** What is the average order processing, dispatch, and transit duration across fulfillment centers?
2. **Bottleneck Identification:** Which specific stages (first-mile intake, hub sorting, mid-mile linehaul, or last-mile delivery) drive fulfillment variance?
3. **SLA Compliance:** Which carrier tiers and regional hubs fail to meet target delivery windows, and why?
4. **Operational Optimization:** What process improvements reduce delivery variance and improve customer satisfaction?

---

## Project Structure
```text
├── data/
│   └── logistics_sample_schema.sql      # Database schema and sample data definitions
├── sql/
│   ├── 01_tat_benchmarking.sql          # Order-to-delivery cycle time and duration breakdown
│   ├── 02_sla_breach_root_cause.sql     # Window functions identifying breach distribution per hub
│   └── 03_carrier_performance.sql       # Carrier ranking by regional on-time delivery rate
├── scripts/
│   └── logistics_analysis.py            # Python analysis for distribution modeling and summary stats
└── README.md
```

---

## Key SQL Insights & Analysis

### 1. Mid-Mile Sorting Bottleneck
* SQL window functions identified that while first-mile dispatch met SLAs in **94.2%** of cases, mid-mile sorting hubs experienced severe throughput congestion between 18:00 and 22:00, creating an average sorting delay of **4.8 hours**.
* Hubs 4, 9, and 12 accounted for over **68%** of total system-wide delayed packages.

### 2. Carrier Performance Discrepancies
* Tier-1 dedicated freight carriers maintained an **89.5% OTD**, whereas 3PL regional partners in peripheral zones averaged only **74.1% OTD**, primarily due to batching delays at local distribution centers.

---

## Operational Recommendations
1. **Dynamic Dispatch Buffers:** Re-route high-priority parcels to bypass regional sortation hubs during peak surge hours.
2. **Automated Carrier Escalations:** Implement real-time SLA breach alerts when parcel dwell time exceeds 2.5 hours at any single transshipment node.
3. **Cross-Docking Workflows:** Transition top 20 fast-moving SKU orders to cross-dock facilities, eliminating intermediate shelf storage.
