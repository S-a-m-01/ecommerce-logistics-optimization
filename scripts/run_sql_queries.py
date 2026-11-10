#!/usr/bin/env python3
"""
Automated SQL Runner for Logistics Operations Optimization
Creates an in-memory SQLite database, loads the sample dataset, executes all queries, and prints formatted results.
"""
import os
import glob
import sqlite3
import pandas as pd

def execute_all():
    db = sqlite3.connect(':memory:')
    base_dir = os.path.dirname(os.path.abspath(__file__))
    csv_path = os.path.join(base_dir, '..', 'data', 'delivery_orders_sample.csv')
    
    if not os.path.exists(csv_path):
        print(f"Error: CSV file not found at {csv_path}")
        return

    df = pd.read_csv(csv_path)
    df.to_sql('delivery_orders', db, index=False, if_exists='replace')
    print("=" * 80)
    print(f"  SQLite In-Memory DB Initialized with {len(df):,} Delivery Records")
    print("=" * 80)

    sql_files = sorted(glob.glob(os.path.join(base_dir, '..', 'sql', '*.sql')))
    for sql_file in sql_files:
        name = os.path.basename(sql_file)
        print(f"\n>>> Running SQL File: {name}")
        with open(sql_file, 'r', encoding='utf-8') as f:
            query = f.read()
        res = pd.read_sql_query(query, db)
        print(res.to_string(index=False))
        print("-" * 80)

if __name__ == '__main__':
    execute_all()
