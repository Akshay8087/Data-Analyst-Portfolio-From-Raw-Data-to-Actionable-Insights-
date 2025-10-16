# In-Depth Analysis of Ola Cabs' Operational Performance

## 📊 Business Intelligence Dashboard & SQL Analysis Project

A comprehensive deep-dive into Ola's booking data to uncover operational inefficiencies, understand customer and driver behavior, and identify key drivers of revenue. This repository contains the complete SQL analysis and a detailed breakdown of the Power BI dashboard created to visualize the findings.

---

### 📜 Table of Contents
1.  [**Business Context & Problem Statement**](#-business-context--problem-statement)
2.  [**Project Objectives**](#-project-objectives)
3.  [**Tech Stack & Tools**](#-tech-stack--tools)
4.  [**Data ETL (Extract, Transform, Load) Process**](#-data-etl-extract-transform-load-process)
5.  [**Database Schema**](#-database-schema)
6.  [**Exploratory Data Analysis (EDA) with SQL**](#-exploratory-data-analysis-eda-with-sql)
    * [Operational Metrics](#operational-metrics)
    * [Customer & Driver Insights](#customer--driver-insights)
    * [Financial Analysis](#financial-analysis)
    * [Time-Series Analysis](#time-series-analysis)
7.  [**Power BI Dashboard Deep-Dive**](#-power-bi-dashboard-deep-dive)
    * [Dashboard KPIs Overview](#dashboard-kpis-overview)
    * [View 1: The Main Overview](#view-1-the-main-overview)
    * [View 2: Cancellation Analysis](#view-2-cancellation-analysis)
    * [View 3: Vehicle Performance Analysis](#view-3-vehicle-performance-analysis)
    * [View 4: Revenue Trend Analysis](#view-4-revenue-trend-analysis)
8.  [**Consolidated Insights & Findings**](#-consolidated-insights--findings)
9.  [**Strategic Business Recommendations**](#-strategic-business-recommendations)
10. [**Project Limitations & Future Scope**](#-project-limitations--future-scope)

---

### 🎯 Business Context & Problem Statement

In the hyper-competitive ride-hailing industry, operational efficiency and customer satisfaction are paramount. Ola, a major player, faces significant challenges related to ride cancellations and service reliability. A high rate of cancellations not only leads to direct revenue loss but also erodes customer trust and can lead to both rider and driver churn. Furthermore, inefficiencies in vehicle allocation and service completion represent missed opportunities and wasted resources.

This project addresses the core business problem: **How can Ola leverage its booking data to diagnose the root causes of high cancellation rates and operational inefficiencies to improve service quality, maximize revenue, and enhance customer loyalty?**

### 📝 Project Objectives

* **Diagnose Cancellation Issues:** Identify the primary source of cancellations (Customer vs. Driver) and uncover underlying patterns.
* **Analyze Operational Performance:** Evaluate key metrics like completion rate, vehicle turnaround time (TAT), and driver availability across different vehicle types.
* **Identify Revenue Drivers:** Determine which vehicle types, payment methods, and customer segments are most valuable to the business.
* **Provide Actionable Insights:** Translate complex data into clear, strategic recommendations for Ola's operational, marketing, and product teams.

### 🛠️ Tech Stack & Tools

* **Database:** PostgreSQL for data storage, manipulation, and querying.
* **Business Intelligence:** Microsoft Power BI for creating interactive and dynamic visualizations.
* **Language:** SQL for data extraction and analysis.
* **Data Source:** `Bookings OLA - July.csv` file containing transactional booking data.

### 🔄 Data ETL (Extract, Transform, Load) Process

1.  **Extract:** The raw data was provided in a CSV format (`Bookings OLA - July.csv`).
2.  **Transform:** A database table `ola_bookings_july` was designed in PostgreSQL. The `CREATE TABLE` statement ensures data integrity by defining appropriate data types for each field (e.g., `TIMESTAMP` for dates, `DECIMAL` for financial values, `VARCHAR` for categorical data).
3.  **Load:** The `COPY` command was used to efficiently load the data from the CSV file into the PostgreSQL table, ready for analysis.

### 🗄️ Database Schema

The analysis is based on a single, comprehensive table named `ola_bookings_july`.

| Column | Data Type | Description |
| :--- | :--- | :--- |
| `Date` | TIMESTAMP | The full date and time of the booking. |
| `Time` | TIME | The time component of the booking. |
| `Booking_ID` | VARCHAR(20) | **Primary Key**; a unique identifier for each booking request. |
| `Booking_Status`| VARCHAR(50) | The final status of the booking (e.g., 'Success', 'Canceled by Driver'). |
| `Vehicle_Type` | VARCHAR(25) | The category of vehicle booked (e.g., 'Prime Sedan', 'eBike'). |
| `Payment_Method`| VARCHAR(20) | Method used for payment ('Cash', 'UPI', etc.). |
| `Booking_Value` | DECIMAL(10, 2) | The monetary value of the ride. |
| `Ride_Distance` | DECIMAL(5, 2) | The distance of the ride in kilometers. |
| `Driver_Ratings`| NUMERIC(2, 1) | The 1-5 star rating given to the driver. |
| `Canceled_Rides_by_Driver` | VARCHAR(100) | The reason provided if a driver cancels. |

### 🔍 Exploratory Data Analysis (EDA) with SQL

Detailed analysis was performed using SQL to answer critical business questions.

#### Operational Metrics

* **Question:** What is the average ride distance for each vehicle type?
* **Insight:** This helps understand the typical use case for each service (e.g., bikes for short trips, sedans for longer ones).
* **Query:**
    ```sql
    CREATE VIEW ride_distance_each_vehicle AS
    SELECT VEHICLE_TYPE, ROUND(AVG(ride_distance), 2) AS AVG_ride_distance
    FROM ola_bookings_july
    GROUP BY 1;
    ```
   

* **Question:** What are the average vehicle and customer turnaround times (TAT)?
* **Insight:** High TAT can indicate delays in driver allocation or customers taking too long, affecting overall efficiency.
* **Query:**
    ```sql
    SELECT 
        ROUND(AVG(v_tat), 2) AS avg_vehicle_tat,
        ROUND(AVG(c_tat), 2) AS avg_customer_tat
    FROM ola_bookings_july;
    ```
   

#### Customer & Driver Insights

* **Question:** Who are the top 5 most frequent customers?
* **Insight:** Identifying power users is crucial for loyalty programs and retention strategies.
* **Query:**
    ```sql
    SELECT CUstomer_id, COUNT(booking_id) AS total_bookin 
    FROM ola_bookings_july
    GROUP BY CUstomer_id 
    ORDER BY total_bookin DESC 
    LIMIT 5;
    ```
   

* **Question:** What is the distribution of driver ratings?
* **Insight:** This provides a direct measure of service quality and can help identify high-performing or under-performing drivers.
* **Query:**
    ```sql
    SELECT 
        driver_ratings,
        COUNT(*) AS ride_count
    FROM ola_bookings_july
    GROUP BY driver_ratings
    ORDER BY driver_ratings DESC;
    ```
   

#### Financial Analysis

* **Question:** What is the total revenue generated by each vehicle type?
* **Insight:** This is fundamental for understanding which services are the most profitable and should be prioritized.
* **Query:**
    ```sql
    SELECT 
        vehicle_type,
        SUM(booking_value) AS total_revenue
    FROM ola_bookings_july
    WHERE booking_status = 'Success'
    GROUP BY vehicle_type
    ORDER BY total_revenue DESC;
    ```
   

* **Question:** Which vehicle type is the most efficient in terms of fare per kilometer?
* **Insight:** This metric reveals which service provides the best return for the distance traveled, influencing pricing strategy.
* **Query:**
    ```sql
    SELECT 
        vehicle_type,
        ROUND(SUM(booking_value) / SUM(ride_distance), 2) AS avg_fare_per_km
    FROM ola_bookings_july
    WHERE booking_status = 'Success' AND ride_distance > 0
    GROUP BY vehicle_type
    ORDER BY avg_fare_per_km DESC;
    ```
   

#### Time-Series Analysis

* **Question:** What are the peak booking hours during a typical day?
* **Insight:** Essential for driver allocation and implementing dynamic or surge pricing.
* **Query:**
    ```sql
    SELECT 
        EXTRACT(HOUR FROM time) AS booking_hour,
        COUNT(*) AS total_bookings
    FROM ola_bookings_july
    GROUP BY booking_hour
    ORDER BY total_bookings DESC;
    ```
   

* **Question:** How does the daily count of successful vs. cancelled rides trend over the month?
* **Insight:** Helps identify specific days or weeks with unusually high cancellation rates, which could correlate with external events.
* **Query:**
    ```sql
    SELECT 
        DATE(date) AS booking_date,
        SUM(CASE WHEN booking_status = 'Success' THEN 1 ELSE 0 END) AS success_count,
        SUM(CASE WHEN booking_status IN ('Canceled by Customer', 'Canceled by Driver') THEN 1 ELSE 0 END) AS cancelled_count
    FROM ola_bookings_july
    GROUP BY booking_date
    ORDER BY booking_date;
    ```
   

---

### 🖥️ Power BI Dashboard Deep-Dive

The Power BI dashboard consolidates the SQL analysis into an intuitive, interactive interface for business users.

#### Dashboard KPIs Overview
The header provides a real-time pulse of the business:
* **Total Bookings (103K):** Overall demand for the service.
* **Completion Rate (62.09%):** A critical efficiency metric. A low rate indicates significant operational friction.
* **Total Revenue (₹57M):** The top-line financial performance.
* **Cancellation Rate (28.08%):** The primary pain point, representing nearly a third of all bookings.
* **Avg Driver Rating (4.00):** A measure of service quality. A 4.0 is decent but has room for improvement.

#### View 1: The Main Overview

<img width="1287" height="728" alt="Image" src="https://github.com/user-attachments/assets/f91b9b2d-5f62-4d89-a01d-2e1a9a648dff" />

##### This page gives a 360-degree view of the operation.
* **Insights:**
    * `Daily Revenue vs. Booking Trends`: Revenue and bookings trend together, showing no major pricing anomalies.
    * `Payment Methods`: **Cash (35K)** is the dominant payment method, followed by **UPI (26K)**. This highlights a need to potentially drive digital adoption.
    * `Revenue by Vehicle Type`: Revenue is surprisingly evenly distributed across all vehicle types, suggesting a well-diversified fleet strategy.
    * `Cancellation Breakdown`: This is the most alarming chart. **Drivers (18.4K)** cancel rides far more frequently than **Customers (10.5K)**, pinpointing where the problem originates.

#### View 2: Cancellation Analysis

<img width="1278" height="715" alt="Image" src="https://github.com/user-attachments/assets/34cd5c24-d41b-40cb-bea5-bc97956d2cea" />

##### This page is dedicated to dissecting the cancellation problem.
* **Insights:**
    * `Hourly & Daily Cancellation Trends`: Cancellations fluctuate throughout the day and week, likely spiking during peak demand or high-traffic periods.
    * `Daily Bookings vs. Cancellations`: The two lines track each other closely, indicating that cancellations are a consistent percentage of total bookings.
    * `Cancellation Rate by Vehicle`: The rate is almost identical across all vehicle types (27-28%). This proves the cancellation issue is systemic and platform-wide, not isolated to a specific service.

#### View 3: Vehicle Performance Analysis

<img width="1288" height="720" alt="Image" src="https://github.com/user-attachments/assets/0d01c7c6-18a2-42af-9383-ef9d5e74539e" />

##### This view compares the performance of different services.
* **Insights:**
    * `Operational Efficiency Breakdown`: This table is crucial. It shows that besides cancellations, a significant portion of failed bookings are due to **"Driver Not Found" (9-10%)**. This is a core service failure.
    * `Top Vehicles by Booking Volume`: Demand is well-spread, with Prime Sedan, eBike, and Auto leading slightly.
    * `Vehicle Type Rating vs Completion Analysis`: There is no strong correlation between a vehicle's average rating and its completion rate. All vehicles perform at a similar level.

#### View 4: Revenue Trend Analysis
This page focuses on the financial aspects.
* **Insights:**
    * `Customer Loyalty Snapshot`: An extremely powerful insight. **Returning Customers account for ₹52M of the total ₹57M revenue**. This means customer retention is mission-critical for financial health.
    * `Detailed Revenue Trend`: The daily and hourly revenue streams are stable and predictable, indicating a mature and consistent business operation.
    * `Which Vehicle Earns the Most Revenue`: Confirms the findings from the overview page that revenue is evenly split, with Prime Sedan (₹8.3M) having a very slight edge.

---

### 💡 Consolidated Insights & Findings

1.  **Driver-Initiated Cancellations are the Core Problem:** Drivers cancel rides **77%** more often than customers. This is the single biggest lever to pull for improving the completion rate.
2.  **Operational Inefficiency is High:** A completion rate of only 62% means that nearly 4 out of every 10 ride requests fail. A significant portion of these failures, beyond cancellations, are due to "Driver Not Found".
3.  **Customer Retention is Paramount:** The vast majority of revenue comes from existing, loyal customers. Losing a returning customer is far more damaging financially than failing to acquire a new one.
4.  **The Fleet is Balanced but Underperforming Uniformly:** All vehicle types show similar (and mediocre) completion rates and cancellation rates. The problem isn't with a specific service (like Auto or Bike) but is ingrained in the platform's operations.

---

### 🚀 Strategic Business Recommendations

| Recommendation | Supporting Data Insight | Expected Business Impact |
| :--- | :--- | :--- |
| **1. Revamp Driver Cancellation & Incentive Model** | Drivers are the source of 18.4K cancellations, 77% more than customers. | Reduce cancellation rate, improve completion rate, increase driver earnings and satisfaction, and enhance customer experience. |
| **2. Optimize the Driver-Rider Matching Algorithm** | "Driver Not Found" accounts for ~10% of failed bookings across top vehicle types. | Reduce wait times, decrease the "Driver Not Found" rate, improve asset utilization, and capture previously lost bookings. |
| **3. Launch a Hyper-Targeted Customer Retention Program**| Returning customers generate ₹52M (91%) of total revenue. | Increase customer lifetime value (CLV), build a stronger brand moat against competitors, and create a more stable revenue base. |
| **4. Promote and Incentivize Digital Payments** | Cash is the top payment method (35K trips), which adds operational friction. | Streamline the payment process, reduce cash handling issues for drivers, and enable faster, more secure transactions. |

---

### ❗ Project Limitations & Future Scope

* **Limitations:**
    * The dataset covers only one month (July), which may not account for seasonal trends.
    * The analysis lacks detailed geospatial data, which could be used to identify cancellation "hotspots" or areas with low driver supply.
    * Cancellation reasons are categorical and may not capture the full context.

* **Future Scope:**
    * **Predictive Modeling:** Build a machine learning model to predict the likelihood of a booking being cancelled in real-time.
    * **Geospatial Analysis:** Plot cancellations and "Driver Not Found" incidents on a map to identify problematic zones.
    * **A/B Testing:** Implement the recommended changes (e.g., a new incentive model) for a small group of drivers and measure the impact against a control group.
    * **Sentiment Analysis:** If more detailed cancellation reasons were available (e.g., text comments), perform sentiment analysis to better understand driver and customer frustrations.
