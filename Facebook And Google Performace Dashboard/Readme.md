# 📊 Digital Ads Performance: A Comparative Study of Facebook & Google Ads
<p align="center">
  <img alt="Power BI" src="https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=Power-BI&logoColor=white">
  <img alt="Python" src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img alt="DAX" src="https://img.shields.io/badge/DAX-2E8540?style=for-the-badge&logo=Power-BI&logoColor=white">
  <img alt="Power Query" src="https://img.shields.io/badge/Power%20Query-2E8540?style=for-the-badge&logo=Power-BI&logoColor=white">
</p>
  
<p align="center">
  <a href="https://www.linkedin.com/in/akshay-rathod-data-analyst/">
    <img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-Akshay%20Rathod-0A66C2?style=for-the-badge&logo=linkedin">
  </a>
  <a href="https://github.com/Akshay8087">
    <img alt="GitHub" src="https://img.shields.io/badge/GitHub-Akshay8087-181717?style=for-the-badge&logo=github">
  </a>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/cc415f78-60dd-4897-ac16-00a09f436ef4" alt="Dashboard Preview" width="800"/>
</p>

---

## 📋 Table of Contents
1. [Project Overview](#-project-overview)
2. [Business Problem & Objectives](#-business-problem--objectives)
3. [Key Findings & Recommendations](#-key-findings--recommendations)
4. [Project Architecture & Data Workflow](#-project-architecture--data-workflow)
5. [Analysis Part 1: Power BI Interactive Dashboard](#-analysis-part-1-power-bi-interactive-dashboard)
6. [Analysis Part 2: Python Statistical A/B Test](#-analysis-part-2-python-statistical-ab-test)
7. [Tech Stack & Libraries](#-tech-stack--libraries)
8. [Repository Structure & Setup Guide](#-repository-structure--setup-guide)
9. [Future Work & Enhancements](#-future-work--enhancements)
10. [Contact](#-contact)

---

## 📜 Project Overview
This project presents a comprehensive comparative analysis of **Facebook Ads** and **Google AdWords** performance. It leverages a dual-methodology approach, combining an interactive **Power BI dashboard** for high-level exploratory analysis with a rigorous **Python-based A/B test** for statistical validation. The ultimate goal is to generate actionable intelligence for optimizing digital marketing strategies and maximizing Return on Investment (ROI).

---

## 🎯 Business Problem & Objectives
As a data analyst for a marketing agency, the central challenge is to allocate client budgets to the advertising platform that guarantees the highest return. This requires moving beyond surface-level metrics to understand which platform is not just driving clicks, but is demonstrably superior at converting those clicks into valuable business outcomes.

#### **Project Goals**:
1.  **Identify the Superior Platform**: Determine with statistical confidence which platform (Facebook or AdWords) generates more conversions.
2.  **Analyze Performance Drivers**: Investigate the relationship between engagement (clicks), conversions, cost (CPC), and overall ROI for each platform.
3.  **Provide Actionable Insights**: Deliver clear, data-driven recommendations for budget allocation and campaign optimization.
4.  **Develop Predictive Capabilities**: Build a simple regression model to forecast potential conversions based on ad clicks for the winning platform.

---

## 🔑 Key Findings & Recommendations

The analysis provides a conclusive and statistically significant verdict: **Facebook Ads demonstrably outperform Google AdWords in driving conversions.**

| Metric | Finding | Business Impact |
| :--- | :--- | :--- |
| **Statistical Significance** | Hypothesis testing rejects the null hypothesis (p-value ≈ 0), confirming Facebook's superiority. | Prioritize Facebook for conversion-focused campaigns with high confidence. |
| **Conversion Correlation** | Facebook clicks have a **strong positive correlation (0.87)** with conversions, while AdWords' is moderate (0.45). | Facebook ad clicks are a more reliable indicator of potential sales, simplifying performance forecasting. |
| **High-Performance Days** | Facebook consistently achieves days with **11+ conversions**; AdWords rarely surpasses 10. | Facebook is better suited for scaling and achieving high-volume conversion targets. |
| **Cost Efficiency** | Facebook's **Cost Per Conversion (CPC)** is lowest in **May and November**. | Provides a data-backed strategy for optimizing seasonal ad spend on Facebook to maximize ROI. |

### **Actionable Recommendation**:
For marketing objectives centered on maximizing conversion volume and achieving a higher ROI, a larger portion of the advertising budget should be strategically allocated to **Facebook**. AdWords campaigns, while consistent, require significant optimization to improve their click-to-conversion efficiency.

---

## 🏗️ Project Architecture & Data Workflow
The project follows a standard analytics workflow, from data ingestion to insight delivery.

1.  **Data Source**: A single CSV file (`ABmarketing_campaign.csv`) containing 365 days of performance data for both Facebook and Google Ads campaigns.
2.  **ETL & Modeling (Power BI)**:
    -   **Power Query** was used to ingest, clean, and transform the raw data. This included unpivoting columns and creating a `Dim_Date` table for time intelligence.
    -   Data was modeled into a **Star Schema** with a central `Fact_CampaignPerformance` table linked to dimension tables.
3.  **Visualization (Power BI)**: An interactive dashboard was built with drill-down capabilities to compare high-level KPIs and explore platform-specific trends.
4.  **Statistical Analysis (Python)**: The same dataset was analyzed in a Jupyter Notebook to conduct hypothesis testing, correlation analysis, and regression modeling, providing statistical rigor to the visual findings.

---

## 📊 Analysis Part 1: Power BI Interactive Dashboard
The Power BI report is the project's central hub for visual exploration, enabling stakeholders to quickly grasp performance differences.

#### **Dashboard Design & Layout**
-   **Main Overview**: A comparative dashboard answering the "who is better?" question with KPI cards, conversion share donuts, trend lines, and ROI comparisons.
-   **Facebook & Google Deep Dives**: Symmetrical pages dedicated to each platform, allowing for granular analysis of metrics like CPC, CTR, and CPA.

#### **DAX Measures Showcase**
Key DAX measures were created to drive the dashboard's KPIs. These measures allow for dynamic calculations based on user selections and filters.

```DAX
// Calculates Cost Per Acquisition (CPA)
CPA = DIVIDE([Total Cost], [Total Conversions], 0)

// Calculates Return On Ad Spend (ROAS)
ROAS = DIVIDE([Total Revenue], [Total Cost], 0)

// Time Intelligence for Month-To-Date Conversions
Conversions MTD = TOTALMTD([Total Conversions], 'Dim_Date'[Date])
```

## 🧪 Analysis Part 2: Python Statistical A/B Test

This analysis uses Python to statistically validate the trends observed in Power BI.

---

### 🎯 Hypothesis Testing: Which Platform Converts More?

A **one-tailed independent t-test** was performed to compare the mean daily conversions of:

- **Facebook Ads (Group A)**  
- **Google AdWords Ads (Group B)**

#### Hypotheses:

- **Null Hypothesis (H₀):**  
  The mean number of conversions from Facebook is less than or equal to that of AdWords  
  _H₀: μ₍Facebook₎ ≤ μ₍AdWords₎_

- **Alternative Hypothesis (H₁):**  
  The mean number of conversions from Facebook is greater than that of AdWords  
  _H₁: μ₍Facebook₎ > μ₍AdWords₎_

#### 📈 Results:

- **Facebook Mean Conversions:** 11.74  
- **AdWords Mean Conversions:** 5.98  
- **T-statistic:** 32.88  
- **P-value:** 9.35e-134

> ✅ **Conclusion:**  
> The extremely low p-value provides overwhelming evidence to reject the null hypothesis.  
> The difference in conversion rates is statistically significant and not due to random chance.

---

### 📉 Correlation & Regression: Do Clicks Lead to Conversions?

This analysis quantified the relationship between **ad clicks** and **conversions**.

| Platform     | Correlation Coefficient | Relationship Type        |
|--------------|--------------------------|---------------------------|
| Facebook Ads | **0.87**                 | Strong Positive           |
| AdWords Ads  | 0.45                     | Moderate Positive         |

A **Linear Regression model** was then built for Facebook Ads:

- **R² Score:** 76.35%  
- **Interpretation:** 76% of the variance in conversions is explained by ad clicks  
- **Prediction Example:**  
  For **100 clicks**, the model forecasts approximately **24 conversions**

---

### 📊 Time-Series & Trend Analysis

- **🗓️ Weekly Performance:**  
  Highest conversion counts occurred on **Mondays and Tuesdays**

- **📉 CPC Trend (Facebook):**  
  Facebook campaigns were **most cost-efficient in May and November**

- **🔁 Cointegration Test:**  
  A cointegration test confirmed a **stable, long-term equilibrium** relationship between **ad spend and conversions**  
  → This validates that budget changes have **predictable impact** over time.

---

## 🛠 Tech Stack & Libraries

### Data Visualization & ETL:
- Power BI Desktop  
- Power Query

### Data Modeling:
- DAX (Data Analysis Expressions)

### Statistical Analysis & Programming:
- **Python 3**  
- **Jupyter Notebook**

### Core Python Libraries:
- `pandas` – Data manipulation and analysis  
- `matplotlib`, `seaborn` – Data visualization  
- `scipy.stats` – Hypothesis testing (t-test)  
- `statsmodels` – Time-series and cointegration tests  
- `scikit-learn` – Linear regression modeling

---

## ⚙️ Repository Structure & Setup Guide

```bash
.
├── 📂 data
│   └── ABmarketing_campaign.csv      # Raw dataset
├── 📂 images
│   └── dashboard_screenshot.png      # Screenshots for README
├── 📜 Ads Performance.pbix            # Power BI report file
├── 📜 A-B Testing.ipynb               # Jupyter Notebook with Python analysis
└── 📜 README.md                       # Project documentation (this file)
