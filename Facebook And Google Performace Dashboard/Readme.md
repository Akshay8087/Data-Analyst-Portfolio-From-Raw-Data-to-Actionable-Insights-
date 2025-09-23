# Digital Advertising Performance Dashboard (Google & Facebook Ads)

<p align="center">
  <img src="./images/overview.png" alt="Dashboard Overview" width="800"/>
</p>

---

## 📖 Executive Summary

This Power BI report provides a comprehensive, unified view of digital advertising performance across Google Ads and Facebook Ads. It is designed for marketing managers, performance analysts, and business stakeholders to monitor key metrics, compare channel efficiency, and make data-driven decisions to optimize marketing ROI. The dashboard centralizes critical KPIs, visualizes performance trends, and allows for a granular deep dive into each platform's specific results.

---

## 🎯 Business Problem

Marketing departments often allocate significant budgets across multiple ad platforms like Google and Facebook. Managing and analyzing performance data from these disparate sources is challenging, time-consuming, and makes it difficult to get a holistic view of marketing effectiveness. This report solves the following problems:

* **Lack of a Single Source of Truth:** Eliminates the need to manually download reports and switch between different ad manager platforms to gauge overall performance.
* **Difficulty in Comparing Channel ROI:** Provides direct, side-by-side comparisons of cost and conversion metrics (like CPA and ROAS) to determine which platform offers a better return on investment.
* **Inability to Spot Cross-Platform Trends:** Visualizes performance over time, helping to identify seasonal patterns, campaign fatigue, or opportunities for budget reallocation between channels.
* **Time-Consuming Manual Reporting:** Automates the data aggregation and visualization process, freeing up analysts to focus on generating insights rather than building reports.

---

## 💾 Data Sources

This report is designed to connect directly to platform APIs for automated refreshes. For this public version, it uses sample monthly data stored in CSV files.

* **Primary Sources (Sample Data):**
    * `Google Ads Performance.csv`
    * `Facebook Ads Performance.csv`
* **Connectivity:** The data model is built to be easily switched to live data sources using Power BI's native connectors for **Google Ads** and **Facebook Ads**.
* **Granularity:** Data is aggregated and visualized on a **monthly** basis.
* **Refresh Schedule:** When connected to live APIs, the report is scheduled for a **daily refresh** to ensure data is current.

---

## 📊 Report Pages Overview

The report is organized into three main pages for a clear, hierarchical analysis, moving from a high-level summary to granular details.

### 1. Main Overview Page

This page serves as the executive summary, offering a comparative look at both platforms' overall performance.
* **Visuals:**
    * [cite_start]**KPI Cards:** Key aggregate metrics for both Google and Facebook are displayed prominently at the top, including Total Impressions, Clicks, Conversions, and Cost[cite: 1903, 1904, 1905, 1906].
    * **Performance Trend (Line Chart):** A time-series chart that tracks ad views or impressions for both platforms over the year.
    * **Conversions Share (Donut Chart):** A simple visual that shows the percentage contribution of each platform to the total number of conversions.
    * **Cost Efficiency vs Return (Bar Chart):** Compares Cost Per Acquisition (CPA) and Return On Ad Spend (ROAS) side-by-side, directly answering which platform is more cost-effective.
* **Interactivity:**
    * [cite_start]**Navigation Buttons:** Buttons to navigate to the "Google Deep Dive" and "Facebook Deep Dive" pages[cite: 1957, 1972].

### 2. Google Ads Deep Dive Page

This page provides a detailed breakdown of the Google Ads account performance.
* **Visuals:**
    * **Google-Specific KPI Cards:** Displays core Google Ads metrics like CPC, CTR, CPA, and Total Cost.
    * **Monthly Impressions vs. CTR (Combo Chart):** Analyzes the relationship between ad visibility and engagement over time.
    * **Cost Per Acquisition (CPA) Over Time (Line Chart):** Compares Google's CPA against Facebook's CPA to track cost efficiency trends.
    * **Monthly Performance Table:** A detailed grid showing monthly data for Cost, Conversions, and CPA.
* **Interactivity:**
    * **Cross-filtering:** Clicking on a month in any chart will filter the other visuals on the page.

### 3. Facebook Ads Deep Dive Page

This page mirrors the Google Deep Dive in structure, allowing for consistent and easy comparison.
* **Visuals:**
    * [cite_start]**Facebook-Specific KPI Cards:** Displays core Facebook Ads metrics like CPC, CTR, CPA, and Total Cost[cite: 1903, 1904, 1905, 1906].
    * **Monthly Impressions vs. CTR (Combo Chart):** Visualizes the monthly trend of ad impressions and click-through rates.
    * **Cost Per Acquisition (CPA) Over Time (Line Chart):** Tracks Facebook's CPA against Google's CPA and the target CPA.
    * **Monthly Performance Table:** Provides a detailed breakdown of monthly performance metrics.
* **Interactivity:**
    * The page is fully interactive, with visuals that cross-filter each other upon selection.

---

## ✨ Features & Highlights

* **Unified Dashboard:** Aggregates data from two major ad platforms into one central location.
* **Comparative Analysis:** Visuals are designed specifically to compare Google vs. Facebook on key metrics like CPA, Conversions, and ROAS.
* **Interactive Navigation:** A user-friendly navigation system with buttons allows for seamless movement between the overview and deep-dive pages.
* **Drill-Down Capability:** The report structure enables users to start with a high-level summary and drill down into the details of a specific platform.
* [cite_start]**Custom Visuals:** Utilizes custom visuals like `textSearchSlicer` and `InforiverCharts` for enhanced filtering and visualization capabilities[cite: 89, 258].

---

## 🚀 How to Use the Report

1.  **Start with the Main Overview Page:** Use this page to get a quick, high-level understanding of aggregate performance and compare the two channels.
2.  **Navigate to a Deep Dive:** If you notice an interesting trend or want more detail on a specific platform, click the corresponding **"Deep Dive" button**.
3.  **Filter and Explore:** On the deep dive pages, click on any element (e.g., a month in a chart, a specific campaign in a table) to cross-filter the entire page and isolate data.
4.  **Hover for Details:** Hover your mouse over any data point in a visual to see a tooltip with more specific information and exact numbers.

---

## 🛠️ Getting Started / Setup Instructions

To view and interact with this report, you will need to have **Power BI Desktop** installed.

1.  **Download the File:** Clone this repository or download the `Ads Performance.pbix` file.
2.  **Open in Power BI Desktop:** Open the `.pbix` file using Power BI Desktop.
3.  **View the Report:** The report will load with the saved sample data.
4.  **(Optional) Connect Your Own Data:**
    * Go to **Transform data** to open the Power Query Editor.
    * Select the sample data query (e.g., `Google Ads Performance`).
    * Click on **Source** under "Applied Steps."
    * Change the source to your own data file (CSV, Excel) or connect to the Google/Facebook Ads connector.
    * Repeat for the other data source and click **Close & Apply**.

---

## 📸 Screenshots

*Place your report screenshots in an `images` folder within the repository.*

![Overview Page](./images/overview.png)
![Facebook Ads Deep Dive](./images/facebook.png)
![Google Ads Deep Dive](./images/google.png)

---

## 📝 License

This project is licensed under the **MIT License**. See the `LICENSE` file for more details.

---

## 👥 Credits / Author Info

* **Author:** [Your Name / Company Name]
* **Contact:** [your.email@example.com]

---

## 🙌 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page if you want to contribute.