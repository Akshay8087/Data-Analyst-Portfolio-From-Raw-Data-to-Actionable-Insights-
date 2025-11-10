# 📧 SMS Spam Classifier: End-to-End Machine Learning Project

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-Classification-green.svg)
![Framework](https://img.shields.io/badge/Framework-Streamlit-red.svg)
![Status](https://img.shields.io/badge/Status-Completed-success.svg)

## 📋 Table of Contents
- [Project Overview](#-project-overview)
- [Live Demo](#-live-demo)
- [Dataset](#-dataset)
- [Technologies Used](#-technologies-used)
- [Project Workflow](#-project-workflow)
  - [1. Data Cleaning](#1-data-cleaning)
  - [2. Exploratory Data Analysis (EDA)](#2-exploratory-data-analysis-eda)
  - [3. Text Preprocessing](#3-text-preprocessing)
  - [4. Model Building](#4-model-building)
  - [5. Deployment](#5-deployment)
- [Installation & Running Locally](#-installation--running-locally)
- [Results](#-results)

---

## 🚀 Project Overview
This project is a complete end-to-end machine learning solution designed to classify SMS messages as either "Spam" or "Ham" (legitimate). It demonstrates the entire lifecycle of a data science project, from raw data ingestion and rigorous preprocessing to model training, evaluation, and final deployment as an interactive web application.

The goal is to build a model with high precision to ensure that legitimate messages are not incorrectly flagged as spam.

## 🌐 Live Demo
Check out the live application deployed on Heroku:
[**SMS Spam Classifier App**](https://email-spam-classifier-campusx.herokuapp.com/)

*(Note: If the Heroku free tier dyno is sleeping, it may take a few seconds to load initially.)*

## 📊 Dataset
The project utilizes the **SMS Spam Collection dataset** commonly found on the UCI Machine Learning Repository or Kaggle. It consists of over 5,500 SMS messages tagged with their respective labels (spam/ham).

## 🛠 Technologies Used
- **Language:** Python
- **Data Manipulation:** Pandas, NumPy
- **Visualization:** Matplotlib, Seaborn, WordCloud
- **Natural Language Processing (NLP):** NLTK
- **Machine Learning:** Scikit-learn (Sklearn)
- **Web Framework:** Streamlit
- **Deployment:** Heroku

---

## ⚙️ Project Workflow

The project is structured into several key stages:

### 1. Data Cleaning
Before analysis, the raw dataset was cleaned to ensure quality:
* **Dropping Irrelevant Columns:** Removed unnamed columns containing minimal data.
* **Renaming:** Standardized column names to `target` and `text` for clarity.
* **Label Encoding:** Converted categorical target labels ('ham'/'spam') to numerical values (0/1).
* **Handling Duplicates:** Identified and removed duplicate entries to prevent data leakage and bias.

### 2. Exploratory Data Analysis (EDA)
In-depth analysis was conducted to understand underlying patterns:
* **Class Distribution Analysis:** Visualized the severe imbalance between spam and ham messages using pie charts.
* **Feature Engineering:** Created new features:
    * `num_characters`: Total characters in the message.
    * `num_words`: Total words in the message.
    * `num_sentences`: Total sentences in the message.
* **Visualizations:** Used histograms and box plots to compare these new features across both classes.
* **Correlation Heatmap:** Analyzed relationships between numerical features to avoid multicollinearity.
* **Word Clouds:** Generated visual representations of the most frequent words in both spam and ham messages.

### 3. Text Preprocessing
Raw text data requires significant transformation before it can be used by machine learning models. A custom pipeline was implemented:
1.  **Lowercasing:** converting all text to lowercase for uniformity.
2.  **Tokenization:** Splitting text into individual words.
3.  **Removing Special Characters:** Stripping out non-alphanumeric characters.
4.  **Stop Word Removal:** Filtering out common English words (e.g., 'is', 'the', 'and') using NLTK.
5.  **Stemming:** Reducing words to their root form using the Porter Stemmer (e.g., 'dancing' -> 'dance').

### 4. Model Building
Various algorithms were trained and evaluated:
* **Vectorization:** Used TF-IDF (Term Frequency-Inverse Document Frequency) to convert text into numerical vectors, identifying the most relevant 3000 words.
* **Model Selection:** Tested multiple classifiers including Logistic Regression, SVM, Decision Trees, Random Forest, AdaBoost, Bagging, ExtraTrees, XGBoost, and Naive Bayes.
* **Evaluation Metric:** Focused heavily on **Precision Score** to minimize False Positives (we don't want to incorrectly label an important message as spam).

### 5. Deployment
The final solution was converted into a user-friendly web app:
* **Web App:** Built using **Streamlit** for rapid prototyping of data apps.
* **Model Serialization:** The best model and the TF-IDF vectorizer were saved using `pickle`.
* **Hosting:** Deployed to **Heroku** for public accessibility.

---

## 💻 Installation & Running Locally
**1. Clone the repository:**
```bash
git clone [https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-.git](https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-.git)
cd Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-/Email%20Spam%20Classifier
```
