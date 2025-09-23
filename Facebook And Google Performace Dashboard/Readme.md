# 📊 Digital Ads Performance Dashboard

<p align="center">
  <img alt="Power BI" src="https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=Power-BI&logoColor=white">
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

<img width="421" height="641" alt="Image" src="https://github.com/user-attachments/assets/cc415f78-60dd-4897-ac16-00a09f436ef4" />
<img width="411" height="626" alt="Image" src="https://github.com/user-attachments/assets/8ae188c3-9429-4434-a10d-b055c9dfe860" />


---

## 📋 Table of Contents
1. [Overview](#-overview)
2. [Key Insights](#-key-insights)
3. [Tech Stack](#-tech-stack)
4. [Dashboard Design](#-dashboard-design)
5. [Usage Guide](#-usage-guide)
6. [Setup Instructions](#-setup-instructions)
7. [Screenshots](#-screenshots)
8. [Contact](#-contact)

---

## 📌 Overview
This Power BI dashboard consolidates **Google Ads** and **Facebook Ads** data to deliver a unified view of digital marketing performance.  
It helps marketing teams move beyond siloed platform metrics and focus on **business impact of ad spend**.

> 🔗 *(Optional: Add a link to your published Power BI report here.)*

---

## 💡 Key Insights
The dashboard answers critical marketing questions:

- **ROI by Platform** → Which channel delivers higher **Return on Ad Spend (ROAS)**?  
- **Cost Efficiency** → What is the overall **Cost Per Acquisition (CPA)** and how has it trended?  
- **Conversion Drivers** → Which platform contributes the majority of conversions?  
- **Engagement** → How do **CTR** and **CPC** compare across Google & Facebook?  

---

## 🛠 Tech Stack
- **Data Sources:** Sample CSVs (`GoogleAds.csv`, `FacebookAds.csv`) → can be swapped with API feeds.  
- **ETL / Transformation:** **Power Query**  
  - Standardized schema across platforms  
  - Consolidated `Fact_CampaignPerformance` table  
  - Custom `Dim_Date` table for time intelligence  
- **Data Modeling:** Star Schema (fact + dimension)  
- **DAX Measures:** Custom KPIs  

```dax
// Example Measures

CPA = DIVIDE([Total Cost], [Total Conversions], 0)

ROAS = DIVIDE([Total Revenue], [Total Cost], 0)

// Time Intelligence
Conversions MTD = TOTALMTD([Total Conversions], 'Dim_Date'[Date])

```


## 🎨 Dashboard Design
The report uses a consistent dark theme and is structured across **3 main pages**:

### 1. 📍 Main Overview
- High-level Google vs. Facebook performance comparison  
- **Visuals:** KPI Cards, Donut Chart (Conversion Share), Line Chart (Trends), Bar Chart (CPA vs. ROAS)  
- **Navigation:** Buttons link to deep-dive pages  

### 2. 🔵 Facebook Ads Deep Dive
- Detailed Facebook metrics (CPC, CTR, CPA, conversions)  
- **Visuals:** Combo charts, line charts, performance tables  
- **Interactivity:** Fully interactive cross-filters  

### 3. 🔴 Google Ads Deep Dive
- Mirrors Facebook page structure for consistency  
- **Visuals:** Google-specific KPI cards, trends, drill-down tables  

---

## 🚀 Usage Guide
1. Start with the **Main Overview** for overall performance.  
2. Use the **Navigation buttons** to drill into Google or Facebook details.  
3. **Click charts** to apply cross-filtering.  
4. **Hover on visuals** for detailed tooltips.  

---

## ⚙️ Setup Instructions
To run this project locally:

1. Clone the repo:
   ```bash
   git clone https://github.com/Akshay8087/Your-Repo-Name.git
   ```
---

2. Open Ads Performance.pbix in Power BI Desktop.

- Load sample data (already included) or replace with your own:

- Go to Transform Data → select a query (e.g., Facebook_Data)

Update file source → Apply changes
---

---

## 📸 Screenshots
*(Place screenshots inside an `/images` folder in the repo)*  
<img width="412" height="638" alt="Image" src="https://github.com/user-attachments/assets/91e531b4-43d6-4f18-b200-7d4dbe5da067" />
<img width="421" height="641" alt="Image" src="https://github.com/user-attachments/assets/cc415f78-60dd-4897-ac16-00a09f436ef4" />
<img width="328" height="592" alt="Image" src="https://github.com/user-attachments/assets/08cd058d-4177-4340-9210-32273aae6ff8" />
<img width="411" height="626" alt="Image" src="https://github.com/user-attachments/assets/8ae188c3-9429-4434-a10d-b055c9dfe860" />
<img width="332" height="592" alt="Image" src="https://github.com/user-attachments/assets/c645c00e-7d4d-4e5d-93e9-a6d76cd7b564" />
---





## 📞 Contact
**Akshay Rathod**  
- 🔗 [LinkedIn](https://www.linkedin.com/in/akshay-rathod-data-analyst/)  
- 💻 [GitHub](https://github.com/Akshay8087)  
- 📧 akshayrathod8179@gmail.com
- 📞 8087828179
- Stay Tuned For AB Testing

