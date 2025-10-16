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



### ✅ Ride Status & Cancellations

###Successful Bookings
```SQL
CREATE VIEW successful_booking AS
SELECT COUNT(*) AS bookings
FROM ola_bookings_july
WHERE booking_status = 'Success';
```
### Cancellations

```SQL
SELECT COUNT(*) FROM ola_bookings_july WHERE booking_status = 'Canceled by Customer';
SELECT COUNT(*) FROM ola_bookings_july WHERE booking_status = 'Canceled by Driver';
```

### Incomplete Rides with Reason
```SQL
-- Incomplete Rides with Reason
SELECT Booking_ID, Incomplete_Rides_Reason
FROM ola_bookings_july
WHERE Incomplete_Rides = 'Yes';
```

### 🚗 Vehicle & Distance Metrics

#### Avg ride distance per vehicle

```SQl
CREATE VIEW ride_distance_each_vehicle AS
SELECT vehicle_type, ROUND(AVG(ride_distance), 2) AS avg_ride_distance
FROM ola_bookings_july
GROUP BY vehicle_type;
```
####  Driver ratings per vehicle

```SQL
SELECT vehicle_type, MAX(driver_ratings), MIN(driver_ratings)
FROM ola_bookings_july
GROUP BY vehicle_type;
```
### 💰 Revenue & Payment Analysis

#### Total revenue from successful rides

```SQL
SELECT SUM(booking_value) AS total_successful_value
FROM ola_bookings_july
WHERE booking_status = 'Success';
```

#### -- Revenue by payment method

``` SQL
SELECT payment_method, SUM(booking_value) AS total_successful_value
FROM ola_bookings_july
WHERE booking_status = 'Success'
GROUP BY payment_method;
```
#### Average fare per km
```sql
SELECT vehicle_type, 
       ROUND(SUM(booking_value) / SUM(ride_distance), 2) AS avg_fare_per_km
FROM ola_bookings_july
WHERE booking_status = 'Success' AND ride_distance > 0
GROUP BY vehicle_type;
```

### 👥 Customer & Driver Behavior


###  Top 5 customers by bookings

```SQl
SELECT customer_id, COUNT(*) AS total_bookings
FROM ola_bookings_july
GROUP BY customer_id
ORDER BY total_bookings DESC
LIMIT 5;
```
### Customer rating by vehicle type

```sql
SELECT vehicle_type, 
       ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
       COUNT(*) AS total_rides
FROM ola_bookings_july
GROUP BY vehicle_type
ORDER BY avg_customer_rating DESC;
```
