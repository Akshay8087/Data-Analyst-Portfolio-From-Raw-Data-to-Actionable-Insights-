# 📈 Yelp Restaurant Business Success Analysis with SQL & Python


## 🧾 Table of Contents (Index)



🔵 [Project Overview](#-project-overview)



🔵 [Problem Statement](#-problem-statement)



🔵 [Research Objectives](#-research-objectives)



🔵 [Hypotheses](#-hypotheses)



🔵 [Dataset](#-dataset)



🔵 [Analysis Steps](#-analysis-steps)



🔵 [Key Findings](#-key-findings)



🔵 [Recommendations](#-recommendations)



🔵 [Technologies Used](#-technologies-used)



🔵 [Conclusion](#-conclusion)



---
## Project Overview

This project delves into the vast Yelp dataset to uncover key factors influencing the success of restaurants. By employing a robust SQL-based data analysis approach, complemented with Python for data handling and visualization, we aim to transform raw business, review, user, tip, and check-in data into actionable business intelligence. The analysis focuses on understanding user engagement, sentiment, geographical impact, and temporal trends to provide strategic recommendations for restaurant stakeholders.

---

## 🎯 Problem Statement

In the highly competitive restaurant industry, understanding the drivers of business success is crucial. This project utilizes the Yelp dataset, a platform where users review local businesses, to investigate the relationship between user engagement (reviews, tips, check-ins) and business success metrics (average star ratings). The core objective is to determine if user engagement is correlated with a restaurant's success and to identify other contributing factors.

---

## 🔍 Research Objectives

1.  **Quantify the Correlation:** Measure the relationship between user engagement (review count) and average star ratings for restaurants.
2.  **Analyze Sentiment Impact:** Examine how sentiment expressed in reviews (useful, funny, cool votes) affects review count and average star ratings.
3.  **Identify Time Trends:** Explore seasonal patterns and overall trends in user engagement over time.

---

## 💡 Hypotheses

1.  **User Engagement & Success:** Higher levels of user engagement (reviews, tips, check-ins) correlate with increased review counts and better ratings for restaurants.
2.  **Positive Sentiment:** Positive sentiment in reviews (e.g., high "useful" or "cool" votes) contributes to higher overall ratings and review counts.
3.  **Consistent Engagement:** Sustained user engagement over time is positively associated with long-term business success for restaurants.

---

## 📊 Dataset

The project utilizes a subset of the publicly available Yelp dataset, comprising information about businesses across eight metropolitan areas in the USA and Canada. The original dataset is shared by Yelp as JSON files, which were subsequently imported and stored in an SQLite database for efficient querying and analysis due to its large size.

The dataset consists of the following key tables:

* `business`: Contains information about businesses, including `business_id`, `name`, `address`, `city`, `state`, `stars`, `review_count`, and `categories`.
* `review`: Stores user reviews with `review_id`, `user_id`, `business_id`, `stars`, `useful`, `funny`, `cool` votes, `text`, and `date`.
* `user`: Details about users, including `user_id`, `review_count`, and `elite` status.
* `tip`: Records user tips for businesses, with `user_id`, `business_id`, `text`, and `date`.
* `checkin`: Contains check-in dates for businesses, useful for tracking engagement over time.

---

## 🚀 Analysis Steps

The analysis was conducted through a series of SQL queries and Python scripts, focusing on various aspects of the Yelp data:

1.  **Descriptive Statistics & Outlier Treatment:**
    * Calculated average, min, max, and median for `review_count` and `stars` to understand their distributions.
    * Identified and removed outliers using the Interquartile Range (IQR) method to ensure robust analysis.
    ```sql
    SELECT
        AVG(review_count) AS avg_review_count,
        MIN(review_count) AS min_review_count,
        MAX(review_count) AS max_review_count,
        (SELECT review_count FROM business ORDER BY review_count LIMIT 1 OFFSET (SELECT COUNT(*) FROM business) / 2) AS median_review_count
    FROM business
    WHERE business_id IN (...filtered_restaurant_ids...);
    ```

2.  **User Engagement vs. Ratings:**
    * Analyzed the correlation between engagement metrics (review, tip, check-in counts) and average star ratings.
    * **Finding:** The sweet spot for engagement appears to be around **4-star rated restaurants**.
    ```sql
    SELECT
        CAST(B.stars AS REAL) AS average_rating,
        AVG(B.review_count) AS avg_review_count,
        AVG(T.tip_count) AS avg_tip_count,
        AVG(C.checkin_count) AS avg_checkin_count
    FROM business AS B
    LEFT JOIN (
        SELECT business_id, COUNT(*) AS tip_count
        FROM tip
        GROUP BY business_id
    ) AS T ON B.business_id = T.business_id
    LEFT JOIN (
        SELECT business_id,
               (LENGTH(checkin_dates) - LENGTH(REPLACE(checkin_dates, ',', '')) + 1) AS checkin_count
        FROM checkin
    ) AS C ON B.business_id = C.business_id
    WHERE B.business_id IN (...filtered_restaurant_ids...)
    GROUP BY average_rating
    ORDER BY average_rating;
    ```

3.  **Correlation Analysis of Engagement Metrics:**
    * A heatmap was generated to reveal the relationships between `review_count`, `tip_count`, and `check-in_count`.
    * **Finding:** These metrics are highly correlated, suggesting that boosting one form of engagement can positively impact others.
    
4.  **Geographical Success Metrics:**
    * A custom "Success Score" (weighted average of rating and review count) was calculated for restaurants across different cities and states.
    * **Finding:** This helps identify regions with a higher propensity for restaurant success. For example, **Philadelphia** showed a high success score.
    ```sql
    SELECT
        city,
        state,
        latitude,
        longitude,
        AVG(stars) AS average_rating,
        SUM(review_count) AS total_review_count,
        COUNT(business_id) AS restaurant_count
    FROM business
    WHERE business_id IN (...filtered_restaurant_ids...)
    GROUP BY city, state, latitude, longitude
    ORDER BY total_review_count DESC
    LIMIT 10;
    ```
    
5.  **Time-Series Analysis of User Engagement:**
    * Analyzed trends in user engagement (reviews, tips, ratings) over time.
    * **Finding:** A notable drop in engagement was observed around **2020**, likely attributable to the **COVID-19 pandemic**. Seasonal patterns also emerged, indicating higher engagement during specific times of the year (e.g., year-end and beginning).
    ```sql
    -- Query to extract monthly/yearly data for time series analysis
    SELECT
        STRFTIME('%Y-%m', date) AS month_year,
        AVG(B.stars) AS avg_rating,
        COUNT(DISTINCT R.review_id) AS review_count,
        COUNT(DISTINCT T.tip_id) AS tip_count
    FROM business AS B
    JOIN review AS R ON B.business_id = R.business_id
    LEFT JOIN tip AS T ON B.business_id = T.business_id
    WHERE B.business_id IN (...filtered_restaurant_ids...)
    GROUP BY month_year
    ORDER BY month_year;
    ```
    
6.  **Sentiment Analysis:**
    * The "useful," "funny," and "cool" votes on reviews served as proxies for sentiment.
    * **Finding:** A strong correlation was found between these sentiment indicators and the overall business success score, particularly for **"useful" and "cool" sentiments**.

7.  **Elite vs. Non-Elite Users:**
    * Investigated the impact of "elite" users on total reviews.
    * **Finding:** While "elite" users constitute a small percentage (around **4.5%**) of the total user base, they contribute a substantial portion of the overall reviews, highlighting their significant influence on the platform.
    ```sql
    SELECT
        CASE
            WHEN elite = '' THEN 'Non-Elite'
            ELSE 'Elite'
        END AS user_type,
        COUNT(user_id) AS number_of_users,
        SUM(review_count) AS total_review_count
    FROM user
    GROUP BY user_type;
    ```
    
8.  **Busiest Hours:**
    * Analyzed check-in, review, and tip activity by hour of the day.
    * **Finding:** **4 PM to 1 AM** were identified as the busiest hours for restaurants, crucial for operational planning.
    ```sql
    -- Example for review engagement by hour
    SELECT
        CAST(STRFTIME('%H', date) AS INTEGER) AS hour_of_day,
        COUNT(review_id) AS review_count
    FROM review
    WHERE business_id IN (...filtered_restaurant_ids...)
    GROUP BY hour_of_day
    ORDER BY hour_of_day;
    ```
    
---

## ✨ Key Findings

* **Optimal Rating for Engagement:** Restaurants with approximately 4-star ratings exhibit the highest user engagement across reviews, tips, and check-ins.
* **Interconnected Engagement:** Review count, tip count, and check-in count are strongly positively correlated; boosting one metric can lead to improvements in others.
* **Geographical Success Varies:** A custom "Success Score" helps pinpoint cities and states with a higher propensity for restaurant triumph, with Philadelphia being a top performer.
* **COVID-19 Impact:** A significant drop in user engagement was observed around 2020, coinciding with the global pandemic.
* **Sentiment's Role:** "Useful" and "cool" review votes show a stronger correlation with business success than "funny" votes.
* **Elite User Influence:** A small percentage of "elite" Yelp users contribute disproportionately to the total review count, indicating their considerable platform influence.
* **Peak Operating Hours:** The period from 4 PM to 1 AM is consistently the busiest for restaurant activity and user engagement.

---

## 📈 Recommendations

Based on the comprehensive analysis, the following recommendations are put forth for restaurant businesses:

* **Holistic Success Strategy:** Adopt a "Success Score" model that incorporates both rating quality and review quantity for a comprehensive view of business performance.
* **Drive Engagement:** Implement strategies to actively encourage customer reviews, tips, and check-ins, leveraging the observed interlinkage between these metrics.
* **Cultivate Elite Users:** Recognize and engage with "elite" Yelp users. Their high activity significantly influences brand perception and customer acquisition.
* **Optimize Peak Hour Operations:** Staff and resource allocation should be optimized for the peak hours between 4 PM and 1 AM to ensure seamless service and customer satisfaction.
* **Strategic Expansion:** Utilize geographical success score data to inform decisions regarding new restaurant locations or targeted marketing efforts.
* **Responsive Engagement:** Monitor sentiment in reviews (useful, funny, cool votes) and respond proactively to feedback to enhance customer relationships and improve the overall brand image.

---

## 🛠️ Technologies Used

* **SQL (SQLite):** For efficient data storage, querying, and manipulation of the large Yelp dataset.
* **Python:**
    * **Pandas:** For data loading, processing, and DataFrame operations.
    * **Matplotlib & Seaborn:** For comprehensive data visualization (bar plots, line plots, heatmaps).
    * **Folium:** For interactive geographical mapping of success scores.
    * **SQLAlchemy:** For connecting Python to the SQLite database.
    * **NumPy:** For numerical operations.
    * **DateTime:** For handling temporal data.
    * **Statsmodels:** For time series decomposition.


## 🤝 Conclusion

This project underscores the immense power of integrating SQL and Python for transforming raw data into actionable business intelligence. By strategically focusing on user engagement, sentiment, geographical factors, and time-based trends, restaurant businesses can make data-driven decisions that enhance operational efficiency, elevate customer satisfaction, and ultimately secure a competitive edge in the dynamic market.

