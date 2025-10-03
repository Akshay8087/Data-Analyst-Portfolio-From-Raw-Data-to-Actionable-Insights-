# 📊 SQL Project for Data Analytics: Restaurant Business Success Factors

---

## 🚀 Executive Summary

This project delves into the factors influencing **restaurant business success** using a comprehensive Yelp dataset. Through a blend of SQL for data extraction and Python for advanced analytics and visualization, we investigate the correlation between **user engagement** (reviews, tips, check-ins) and **business success metrics** (star ratings). Key findings highlight the critical role of a **4-star rating** and the disproportionate influence of **"elite" users**. The project offers actionable insights for strategic decision-making in the competitive restaurant industry.

---

## 🎯 Problem Statement & Objectives

In the highly competitive restaurant industry, understanding the drivers of business success is paramount. This project aims to analyze the Yelp dataset to:

1.  **Quantify the correlation** between user engagement and business success metrics.
2.  **Analyze the impact of sentiment** on review counts and average star ratings.
3.  **Identify time-based trends** in user engagement.

### Hypotheses:

* Higher user engagement correlates with higher review counts and ratings.
* Positive sentiment in reviews contributes to higher overall ratings.
* Consistent user engagement over time is associated with sustained business success.

---

## 🗃️ Data Overview

The project utilizes the **Yelp dataset**, a real-world, publicly available dataset that provides information on:
* Businesses
* User reviews
* Tips
* Check-ins

The data, originally in JSON format, is efficiently stored and queried from an **SQLite database** due to its large scale.

---

## 🛠️ Methodology & Analysis

### 1. Data Loading and Database Creation

The JSON files are parsed and loaded into an SQLite database using Python and `SQLAlchemy`.

```python
import pandas as pd
import json
from sqlalchemy import create_engine
import sqlite3

# ... (code for loading JSON files into dataframes) ...

# Create SQLite engine
engine = create_engine('sqlite:///yelp.db')

# Store dataframes into SQL tables
# df_business.to_sql('business', engine, if_exists='replace', index=False)
# df_review.to_sql('review', engine, if_exists='replace', index=False)
# df_user.to_sql('user', engine, if_exists='replace', index=False)
# df_tip.to_sql('tip', engine, if_exists='replace', index=False)

# df_checkin.to_sql('checkin', engine, if_exists='replace', index=False)
```


### 2. Initial Data Exploration & Filtering
We connect to the database and identify available tables.

```python
conn = sqlite3.connect('yelp.db')
tables_query = "SELECT name FROM sqlite_master WHERE type='table';"
tables_df = pd.read_sql_query(tables_query, conn)
print("Available Tables:", tables_df['name'].tolist())

# Explore sample data
# for table_name in tables_df['name']:
#     print(f"\n--- Table: {table_name} ---")
#     print(pd.read_sql_query(f"SELECT * FROM {table_name} LIMIT 5;", conn))
```



#### To focus our analysis, we filter for "open" businesses categorized as "restaurants".


```sql
SELECT business_id
FROM business
WHERE lower(categories) LIKE '%restaurant%'
  AND is_open = 1;
```


### 3. Descriptive Statistics & Outlier Treatment
We calculate descriptive statistics (average, min, max, median) for review_count and stars to understand their distribution and identify outliers.

```SQL

SELECT
    AVG(review_count) AS avg_review_count,
    MIN(review_count) AS min_review_count,
    MAX(review_count) AS max_review_count,
    (SELECT review_count FROM business ORDER BY review_count LIMIT 1 OFFSET (SELECT COUNT(*) FROM business) / 2) AS median_review_count
FROM business
WHERE business_id IN (...filtered_restaurant_ids...);
```
