# Walmart

# Walmart Data Engineering & Analytics Pipeline

## Overview
An end-to-end data engineering project transforming raw retail data into analytics-ready dimensional models using Snowflake, dbt Cloud, and Python.

## Architecture & Tech Stack
* **Cloud Data Warehouse:** Snowflake
* **Data Transformation:** dbt Cloud (SCD Type 1 & Type 2 Modeling)
* **Visualization:** Python (`matplotlib`, `seaborn`, `pandas`)

## Data Models
* `walmart_date_dim`: Date dimension (SCD Type 1)
* `walmart_store_dim`: Store & Department dimension (SCD Type 1)
* `walmart_fact_table`: Sales and store performance metrics (SCD Type 2 tracking history)
