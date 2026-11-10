# Interview Preparation & Concept Cheatsheet
## Project: Supply Chain & Logistics Operations Optimization

This document is your preparation guide for interview questions on Business Operations, Strategy, Product Operations, and Data Analytics.

---

### 1. The 60-Second Elevator Pitch
> *"In this project, I owned the operational diagnosis of an e-commerce fulfillment network handling over 100,000 orders across 15 hubs. The core business problem was that customer delivery SLA breaches were climbing, and management needed to know exactly which process stage was failing. 
> 
> I built an analytical framework in SQL and Python to decompose Order-to-Delivery Turnaround Time (TAT) into warehouse processing and transit legs. Using SQL window functions, I isolated root causes showing that over 70% of SLA breaches originated not in initial dispatch, but in mid-mile sorting hubs (specifically Hubs 4, 9, and 12) during peak evening intake hours (18:00–22:00). 
> 
> Based on this, I modeled an operational redesign featuring cross-docking workflows and dynamic dispatch buffers, delivering an estimated 18% improvement in On-Time Delivery."*

---

### 2. Common Technical & Operational Questions

#### Q1: "Why did you use SQL window functions instead of a standard `GROUP BY`?"
* **Model Answer:**
  > *"A standard `GROUP BY` collapses individual rows into single summary aggregates, losing the context of the total population. In query `02_sla_breach_root_cause.sql`, I needed to calculate each hub's breach count while simultaneously calculating what percentage that hub contributed to the **entire system's** total breaches (`SUM(breach_count) OVER ()`), as well as ranking the hubs dynamically using `DENSE_RANK() OVER (ORDER BY hub_breach_pct DESC)`. Window functions allowed me to calculate macro-level benchmark ratios without writing messy subqueries or self-joins."*

#### Q2: "How did you separate warehouse processing delay from transit delay?"
* **Model Answer:**
  > *"I decomposed the lifecycle into two timestamps:
  > 1. **Warehouse Processing TAT:** `dispatch_timestamp - order_timestamp` (identifies intake picking, packing, and sorting bottlenecks).
  > 2. **Transit TAT:** `delivery_timestamp - dispatch_timestamp` (evaluates carrier logistics, linehaul transit, and last-mile efficiency).
  > This distinction was crucial: the data proved that first-mile warehouse dispatch met SLAs in over 94% of cases, so investing in faster picking/packing would not have solved the delay—the issue was package dwell time at mid-mile sorting hubs."*

#### Q3: "What are the operational trade-offs of recommending cross-docking?"
* **Model Answer:**
  > *"Cross-docking routes fast-moving SKUs directly from inbound trucks to outbound carrier dispatch with zero intermediate warehouse storage. 
  > * **Upside:** Cuts warehouse dwell time by 4–6 hours, eliminates storage handling costs, and directly reduces TAT.
  > * **Trade-off / Risk:** Requires extreme precision in truck synchronization and inbound shipment forecasting. If an inbound truck is delayed, outbound carriers either leave half-empty or miss departure windows. That's why I recommended it specifically for top 20 high-velocity SKUs with predictable replenishment schedules."*

#### Q4: "What metrics would you put on a daily executive operations dashboard?"
* **Model Answer:**
  > *"I track a pyramid of input and output metrics:
  > * **North Star Output Metric:** On-Time Delivery Rate (OTD %) and SLA Breach Rate.
  > * **Leading / Input Metrics:** 
  >   1. **Dwell Time per Hub (hours):** Time parcels spend sitting in sorting centers.
  >   2. **Carrier SLA Compliance %:** Breakdown by dedicated vs. 3PL regional freight.
  >   3. **Peak Hour Dwell Spike:** Dwell ratio during 18:00–22:00 vs. daytime average.
  >   4. **Delivery Variance (Standard Deviation of TAT):** Consistency is often more important to customers than raw average speed."*

---

### 3. Key SQL Syntax to Remember for the Interview
* **Window Total Ratio:** `ROUND(100.0 * breach_count / SUM(breach_count) OVER (), 2)`
* **Ranking Bottlenecks:** `DENSE_RANK() OVER (ORDER BY breach_rate DESC)`
* **Timestamp Difference (Hours in SQLite/Postgres):** `(julianday(delivery_time) - julianday(order_time)) * 24` or `EXTRACT(EPOCH FROM (delivery_time - order_time)) / 3600.0`
