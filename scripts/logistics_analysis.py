"""
Logistics Performance & Fulfillment Bottleneck Analysis
Analyzes TAT distributions, carrier SLA rates, and models impact of buffer mitigation.
"""
import pandas as pd
import numpy as np

def generate_summary(df):
    summary = df.groupby('hub_id').agg(
        total_orders=('order_id', 'count'),
        avg_tat=('total_tat_hours', 'mean'),
        sla_breach_rate=('is_sla_breach', 'mean')
    ).reset_index()
    summary['sla_breach_rate'] = (summary['sla_breach_rate'] * 100).round(2)
    return summary.sort_values(by='sla_breach_rate', ascending=False)

if __name__ == "__main__":
    print("Logistics Analytics Framework Loaded Successfully.")
