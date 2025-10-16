# 🚖 Ola Cabs Booking Analysis — Power BI Dashboard

![Ola Logo](https://upload.wikimedia.org/wikipedia/en/thumb/8/89/Ola_Cabs_logo.svg/1200px-Ola_Cabs_logo.svg.png)

> A data-driven deep dive into Ola Cabs’ ride-booking operations using Power BI and SQL — uncovering inefficiencies, customer behaviors, financial insights, and strategic recommendations to improve performance and profitability.

---

## 📌 Table of Contents

- [📖 Executive Summary](#-executive-summary)
- [🎯 Business Context & Problem Statement](#-business-context--problem-statement)
- [🛠️ Tools, Technologies & Methodology](#-tools-technologies--methodology)
- [📊 Key Performance Indicators (KPIs)](#-key-performance-indicators-kpis)
- [🧠 Analytical Findings & Insights](#-analytical-findings--insights)
- [📦 SQL Report: Data Exploration & Analysis](#-sql-report-data-exploration--analysis)
- [💡 Strategic Recommendations](#-strategic-recommendations)
- [✅ Conclusion & Way Forward](#-conclusion--way-forward)
- [📂 Project Files](#-project-files)
- [📬 Contact](#-contact)

---

## 📖 Executive Summary

This project uses **Power BI and SQL** to analyze Ola Cabs booking data from July. It delivers actionable insights into:

- Operational inefficiencies (cancellations, matching failures)
- Revenue trends by vehicle type and payment method
- Customer and driver behavioral patterns
- Strategies to enhance loyalty, reduce cancellations, and optimize revenue

---

## 🎯 Business Context & Problem Statement

Ola faces a series of challenges that reduce revenue and degrade user experience:

- High driver-led cancellations (~18.6K)
- Low ride completion rates (~62%)
- Disproportionate reliance on cash payments
- Potential service-level churn due to inconsistent quality

---

## 🛠️ Tools, Technologies & Methodology

| Component             | Description                                      |
|----------------------|--------------------------------------------------|
| **BI Tool**           | Microsoft Power BI                               |
| **Query Language**    | PostgreSQL / SQL Standard                        |
| **Data Source**       | `.csv` file (ride-level data for July)           |
| **ETL Process**       | Power Query, SQL scripts                         |
| **Data Modeling**     | Star schema, normalized tables                   |

---

## 📊 Key Performance Indicators (KPIs)

| KPI                      | Value         |
|--------------------------|---------------|
| Total Bookings           | 103,000       |
| Completed Rides          | ~64,000       |
| Completion Rate          | 62.09%        |
| Cancellation Rate        | 28.08%        |
| Total Revenue            | ₹57M          |
| Avg Driver Rating        | 4.0 / 5.0     |
| Cash Payment Share       | ~34%          |
| Returning Customer Share | ~91% of revenue |

---

## 🧠 Analytical Findings & Insights

- **Driver-led Cancellations** are the biggest operational issue.
- **Revenue** is evenly distributed across Prime Sedan, eBike, and Auto.
- **Returning customers** drive majority of revenue (₹52M/₹57M).
- **Cash is still dominant**, creating reconciliation inefficiencies.
- **Ride ratings and fare per km** vary slightly across vehicle types.

---

## 📦 SQL Report: Data Exploration & Analysis

### 🔹 Table Creation & Data Import

```sql
CREATE TABLE ola_bookings_july (
    Date TIMESTAMP,
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(15),
    Vehicle_Type VARCHAR(25),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INTEGER,
    C_TAT INTEGER,
    Canceled_Rides_by_Customer TEXT,
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(5),
    Incomplete_Rides_Reason TEXT,
    Booking_Value DECIMAL(10, 2),
    Payment_Method VARCHAR(20),
    Ride_Distance DECIMAL(5, 2),
    Driver_Ratings NUMERIC(2, 1),
    Customer_Rating NUMERIC(2, 1),
    Vehicle_Images TEXT
);

COPY ola_bookings_july 
FROM 'D:/Ola Data Analytics End to End Project/Bookings OLA - July.csv' 
WITH (FORMAT CSV, HEADER TRUE, NULL 'null');
