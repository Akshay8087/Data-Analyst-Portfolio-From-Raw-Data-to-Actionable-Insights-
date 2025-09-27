# ✈️ Indian Domestic Airlines Flight Data Analysis

This repository contains an exploratory data analysis (EDA) of domestic flights within India. The analysis is performed on a dataset scraped from the **EaseMyTrip** website, which captures a snapshot of flight details between major Indian cities.

The goal of this project is to uncover patterns and insights related to flight operations, airline market share, pricing strategies, and popular travel routes. The findings are presented through a series of visualizations and data summaries.

---

## Dataset

The dataset was sourced from Kaggle and contains flight information scraped from the travel website EaseMyTrip.

* **Kaggle Dataset Link:** [Airlines Flights Data](https://www.kaggle.com/datasets/rohitgrewal/airlines-flights-data)

### Data Dictionary

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `airline` | object | The name of the airline operating the flight. |
| `flight` | object | The flight number. |
| `source_city` | object | The city where the flight originates. |
| `departure_time` | object | The time of day the flight departs (e.g., Morning, Evening). |
| `stops` | object | The number of stops during the flight (zero, one, two_or_more). |
| `arrival_time` | object | The time of day the flight arrives (e.g., Morning, Evening). |
| `destination_city`| object | The city where the flight lands. |
| `class` | object | The travel class of the seat (Economy or Business). |
| `duration` | float64 | The total duration of the flight in hours. |
| `days_left` | int64 | The number of days left until the departure date. |
| `price` | int64 | The price of the flight ticket in Indian Rupees (₹). |

---

## 📊 Key Insights from the Analysis

### 🛫 Flight Operations
* **Busiest Airline**: **Vistara** operates the highest number of flights in this dataset, holding the largest market share, followed closely by **Air India**.
* **Most Popular Route**: The route between **Delhi and Mumbai** is the most frequently operated, indicating it's the busiest travel corridor.
* **Peak Timings**: Most flights tend to depart in the **Morning** and arrive in the **Evening** or **Night**.

### 💰 Pricing Insights
Flight prices are influenced by several factors:
* **Airline Brand & Class**: Full-service carriers like **Vistara** and **Air India** have significantly higher average ticket prices, especially for **Business class**, which is substantially more expensive than **Economy class**.
* **Booking Window (Dynamic Pricing)**: Ticket prices are lower when booked well in advance. As the departure date approaches, prices increase sharply, demonstrating dynamic pricing in action. The price is highest when booking is done just a day or two before departure.
* **Departure/Arrival Time**: Flights departing at **Night** and arriving in the **Evening** tend to have the highest average prices, while "Late Night" flights are the cheapest.
* **Stops**: Direct flights (zero stops) are generally more expensive than flights with one or more stops.

### 👥 Passenger Choices
* **Preferred Class**: A vast majority of passengers in this dataset chose **Economy class**, highlighting a strong preference for budget-friendly travel options.
* **Busiest Cities**: **Delhi** and **Mumbai** are the top cities for both flight departures and arrivals.

---

## 🛠️ Tools and Libraries Used

This analysis was conducted using Python in a Jupyter Notebook environment. The primary libraries used are:
* `pandas`
* `numpy`
* `matplotlib`
* `seaborn`

---

## 🚀 How to Run this Project

To replicate this analysis, please follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/your-repository-name.git](https://github.com/your-username/your-repository-name.git)
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd your-repository-name
    ```
3.  **Install the required libraries:**
    ```bash
    pip install pandas numpy matplotlib seaborn jupyter
    ```
4.  **Download the dataset** from the [Kaggle link](https://www.kaggle.com/datasets/rohitgrewal/airlines-flights-data) and place `airlines_flights_data.csv` in the project directory.

5.  **Run the Jupyter Notebook:**
    ```bash
    jupyter notebook Untitled.ipynb
    ```

---

## 📚 Further Reading & Domain Knowledge

To gain a deeper understanding of the airline industry and the factors influencing the data, consider exploring these topics:

* **Dynamic Pricing**: Airlines use complex algorithms to adjust ticket prices based on demand, time, and competition.
    * *Suggested Reading: How Airline Ticket Prices Are Determined*
* **Hub and Spoke Model**: A common airline operation model where flights are routed through a central hub.
    * *Suggested Reading: What Is The Hub And Spoke Model?*
* **Low-Cost Carrier (LCC) vs. Full-Service Carrier (FSC)**: The airline's business model significantly impacts pricing, routes, and services offered.
    * *Suggested Reading: The Difference Between Full-Service and Low-Cost Airlines*
* **Directorate General of Civil Aviation (DGCA), India**: The regulatory body for civil aviation in India.
    * [DGCA Official Website](https://dgca.gov.in)