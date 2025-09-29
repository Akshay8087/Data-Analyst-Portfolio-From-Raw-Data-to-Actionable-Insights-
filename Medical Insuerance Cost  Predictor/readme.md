# 🧠 Machine Learning for Medical Insurance Cost Prediction  

---

## 📌 1. Project Overview  
This project presents a comprehensive workflow for developing a **machine learning model** to predict **individual medical insurance costs**.  

The **primary objective** is to estimate insurance charges accurately based on a person’s demographic and health-related attributes.  

The workflow covers the **entire data science lifecycle**:  
- 🔍 **Data Exploration**  
- 📊 **Exploratory Data Analysis (EDA)**  
- ⚙️ **Data Preprocessing**  
- 🤖 **Model Training**  
- 📈 **Model Evaluation**  
- 🌐 **Deployment (Streamlit Web App)**  

---

## 🎯 2. Problem Statement  
The goal is to build a **regression model** that predicts **`charges`** (the target variable) for an individual, given multiple independent features.  

✅ Useful for:  
- 🏢 **Insurance companies** → Risk assessment & pricing  
- 👩‍⚕️ **Individuals** → Understanding potential healthcare costs  

---

## 📂 3. Dataset  
**Source**: *Medical Cost Personal Dataset* (Kaggle)  

**Features**:  
- 👤 **`age`** → Age of the primary beneficiary *(Numeric)*  
- 🚻 **`sex`** → Gender *(Categorical: male / female)*  
- ⚖️ **`bmi`** → Body Mass Index *(Numeric)*  
- 👶 **`children`** → Number of children covered *(Numeric)*  
- 🚬 **`smoker`** → Smoking status *(Categorical: yes / no)*  
- 🗺️ **`region`** → Residential area *(northeast, northwest, southeast, southwest)*  
- 💰 **`charges`** → Insurance cost *(Target variable, Numeric)*  

---

## 🛠️ 4. Project Workflow  

1. 🔍 **Data Exploration** → Inspect dataset structure, types, missing values.  
2. 📊 **EDA** → Visualizations, distributions, correlations.  
3. ⚙️ **Preprocessing** → Encode categorical features (`sex`, `smoker`, `region`).  
4. 🤖 **Model Training** → Train **Linear Regression** as baseline.  
5. 📈 **Evaluation** → Assess with **$R^2$ score**.  
6. 🌐 **Deployment** → Interactive app with **Streamlit**.  

---

## 💻 5. Technology Stack  

- 🐍 **Python 3.x**  
- 📊 **Pandas, NumPy** → Data manipulation  
- 🎨 **Matplotlib, Seaborn** → Visualization  
- 🤖 **Scikit-learn** → Machine Learning  
- 🌐 **Streamlit** → Web App  

---

## ⚙️ 6. Setup & Installation  

```bash
# Clone repo
git clone https://github.com/Akshay8087/medical-insurance-prediction.git
```

```bash
cd medical-insurance-prediction
```
# Create virtual environment
python -m venv venv
venv\Scripts\activate   # (Windows)
source venv/bin/activate # (Mac/Linux)

# Install dependencies
```bash
pip install -r requirements.txt
```

# ▶️ 7. How to Run

- Run analysis notebook:

```bash
jupyter notebook "Medical Insurance Cost Prediction.ipynb"
```



---

## 📈 8. Model Performance & Results  

- **Metric**: $R^2$ Score  
- **Result**: ✅ Achieved **~0.75** (explains ~75% of variance in medical charges).  

This baseline demonstrates **reasonably strong predictive power**, and the **Streamlit application** successfully makes the model usable for real-time predictions.  

---

## 🚀 9. Conclusion & Future Work  

✔️ Successfully developed  a **medical cost prediction tool**.  

### 🔮 Potential Future Improvements:  
- 🌲 **Advanced Models** → Explore Random Forest, Gradient Boosting, XGBoost  
- 🎛️ **Hyperparameter Tuning** → Apply GridSearchCV / RandomizedSearchCV  
- 🏗️ **Feature Engineering** → Create new features such as BMI categories, Age groups, Interaction terms  

---
