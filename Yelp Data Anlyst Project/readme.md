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
