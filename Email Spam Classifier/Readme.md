# 🛡️ Intelligent SMS Spam Detection System

![Python](https://img.shields.io/badge/Python-3.8+-3776AB?logo=python&logoColor=white)
![Scikit-Learn](https://img.shields.io/badge/Machine%20Learning-Scikit--Learn-F7931E?logo=scikit-learn&logoColor=white)
![NLTK](https://img.shields.io/badge/NLP-NLTK-green)
![Streamlit](https://img.shields.io/badge/Frontend-Streamlit-FF4B4B?logo=streamlit&logoColor=white)
![Heroku](https://img.shields.io/badge/Deployment-Heroku-430098?logo=heroku&logoColor=white)

> **Turn raw text data into a secure, automated defense system against unsolicited messaging.**


## 📋 Table of Contents
- [🎯 Executive Summary](#-executive-summary)
- [🖼️ Application Demo](#️-application-demo)
- [🔍 Problem Statement & Business Context](#-problem-statement--business-context)
- [📂 Repository Structure](#-repository-structure)
- [🛠️ Technical Architecture](#️-technical-architecture)
- [📊 Key Insights from EDA](#-key-insights-from-eda-exploratory-data-analysis)
- [⚙️ Machine Learning Workflow](#️-machine-learning-workflow)
- [💻 How to Run Locally](#-how-to-run-locally)
- [🔮 Future Improvements](#-future-improvements)
- [🤝 Connect with Me](#-connect-with-me)

---

## 🎯 Executive Summary
In the era of digital communication, spam is not just a nuisance—it's a security risk and a drain on productivity. This project addresses this issue by engineering an end-to-end machine learning pipeline capable of detecting SMS spam with a **100% Precision rate**, ensuring that while unwanted messages are filtered, no critical legitimate messages (OTPs, personal alerts) are ever incorrectly blocked.

The final model was operationalized as a user-friendly web application deployed on Heroku for real-time inference.

---

## 🖼️ Application Demo
*(Highly Recommended: Add a screenshot or GIF of your running Streamlit app here)*
[**🔴 Interact with Live App on Heroku**](https://email-spam-classifier-campusx.herokuapp.com/)
*(Note: Heroku free tier dynos may take ~30 seconds to wake up on first load.)*

---

## 🔍 Problem Statement & Business Context
Unsolicited SMS (Spam) accounts for significant disruption in daily mobile usage. For businesses, it erodes customer trust in SMS as a communication channel.
* **The Challenge:** Distinguishing often deliberately obfuscated spam messages from normal, highly varied conversational text (Ham).
* **Key Business KPI:** **Precision**. In spam detection, a False Positive (flagging a real message as spam) is catastrophic (e.g., missing a bank alert). Therefore, optimizing for high precision is more critical than raw accuracy.

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

_ _ _

## 📂 Repository Structure
```bash
├── 📁 datasets/ # Raw SMS Spam Collection dataset
├── 📁 venv/ # Virtual environment (not tracked in git)
├── app.py # Main Streamlit web application
├── model.pkl # Serialized Machine Learning model
├── vectorizer.pkl # Serialized TF-IDF Vectorizer
├── preprocessor.py # Custom text cleaning pipeline scripts
├── Spam_Classifier.ipynb # Jupyter Notebook (EDA, Experiments, Model Training)
├── requirements.txt # Project dependencies
├── Procfile # Heroku deployment configuration └── README.md # Project documentation
```


---

## 🛠️ Technical Architecture

| Component | Tools/Techniques Used |
| :--- | :--- |
| **Data Handling** | Pandas, NumPy |
| **NLP Preprocessing** | NLTK (PorterStemmer, Stopwords), RegEx |
| **Feature Engineering** | Text length analysis, TF-IDF Vectorization (max_features=3000) |
| **Machine Learning** | Scikit-Learn (Naive Bayes, Random Forest, SVM, Ensembles) |
| **Evaluation** | Precision-Recall trade-off, Confusion Matrix |
| **Deployment** | Streamlit (Frontend), Heroku (PaaS), Pickle (Serialization) |

---

## 📊 Key Insights from EDA (Exploratory Data Analysis)
Before modeling, deep dive analysis revealed distinct patterns differentiating 'Spam' from 'Ham':

1.  **Imbalanced Data:** The dataset is heavily skewed (~87% Ham, ~13% Spam), requiring careful metric selection (Accuracy alone is misleading).
2.  **Message Length Matters:**
    * *Spam* messages are significantly longer (Mean: ~137 characters) compared to *Ham* (Mean: ~71 characters).
3.  **Linguistic Signals:**
    * Spam frequently uses urgent imperative words: `FREE`, `CALL`, `TXT`, `URGENT`, `CLAIM`.
    * Ham messages are more conversational and varied.

---

## ⚙️ The Machine Learning Workflow

### 1. Advanced Text Preprocessing
Raw text is noisy. To extract signal from noise, a rigorous 5-stage pipeline was implemented:
* **Lowercasing:** Standardizing text to avoid treating 'Free' and 'FREE' differently.
* **Tokenization:** Breaking sentences into individual constituent words.
* **Noise Removal:** stripping non-alphanumeric characters (emojis, special symbols).
* **Stopword Removal:** Eliminating high-frequency, low-information words (e.g., 'the', 'is', 'at').
* **Stemming (Porter):** Reducing words to their root form (e.g., 'running', 'runs' → 'run') to reduce feature dimensionality.

### 2. Feature Extraction (Vectorization)
Converted text data into a numerical format understandable by algorithms using **TF-IDF (Term Frequency-Inverse Document Frequency)**.
* *Why TF-IDF over Bag of Words?* TF-IDF assigns lower weights to words that appear frequently across all documents, helping to highlight unique, discriminatory words specific to spam.
* Restricted to top **3,000 features** to reduce noise and improve model generalization.

### 3. Model Selection & Optimization
Extensive experimentation was conducted across multiple algorithms. Given the high-dimensional, sparse nature of text data, **Naive Bayes** variants historically perform well.

| Model | Accuracy | Precision (Critical Metric) | Verdict |
| :--- | :--- | :--- | :--- |
| **Multinomial NB** | **97.1%** | **100%** | **Selected (Best for production)** |
| Bernoulli NB | 96.5% | 98.0% | Good, but more false positives |
| Random Forest | 97.5% | 98.2% | High accuracy, slightly lower precision |
| SVM (Sigmoid) | 97.2% | 97.4% | Computationally heavier |

**Final Decision:** `MultinomialNB` was chosen because it achieved **zero false positives** (100% precision) during testing, making it the safest choice for a real-world spam filter.

---

## 💻 How to Run Locally

**1. Clone the repository:**
```bash
git clone [https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-.git](https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-.git)
cd "Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-/Email Spam Classifier"
```
**2. Install dependencies:**
```bash
pip install -r requirements.txt
```
**3. Run the App:**

```Bash
streamlit run app.py
```

## 🔮 Future Improvements
To further enhance the capabilities and robustness of this classifier, several future improvements are planned:

* **🧠 Deep Learning Integration:** Experiment with advanced Deep Learning architectures like **Long Short-Term Memory (LSTM)** networks or **BERT (Bidirectional Encoder Representations from Transformers)** models. These could potentially capture deeper contextual meanings and nuances in longer or more complex messages that traditional ML models might miss.
* **🔄 Real-time Feedback Loop:** Implement a "Report Misclassification" feature within the Streamlit web app. This would allow end-users to flag incorrect predictions, creating a valuable new dataset for continuous model retraining and active learning.
* **🔌 API Development:** Refactor the application into a **FastAPI** RESTful endpoint. This would decouple the model from the frontend, allowing it to be easily integrated as a microservice into larger software ecosystems or mobile applications.

---

## 🤝 Connect with Me
If you found this project interesting, have feedback, or want to collaborate, feel free to reach out!

[![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/akshay-nazar-02b101228/) &nbsp; [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Akshay8087)


