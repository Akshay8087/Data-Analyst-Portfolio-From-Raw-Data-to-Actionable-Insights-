# 🛍️ Customer Segmentation Web Application using K-Means

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![Streamlit](https://img.shields.io/badge/Framework-Streamlit-red.svg)](https://streamlit.io/)
[![Scikit-learn](https://img.shields.io/badge/Scikit--learn-Used-orange.svg)](https://scikit-learn.org/)
[![Plotly](https://img.shields.io/badge/Visualization-Plotly-purple.svg)](https://plotly.com/)

An interactive web application built with Streamlit for segmenting mall customers into distinct groups based on their demographics and spending habits. This application leverages a K-Means clustering model trained on the Mall Customer dataset.


<img width="1918" height="928" alt="Image" src="https://github.com/user-attachments/assets/454ff199-d41b-4ce3-acfc-8638c7379a10" />

---

<img width="1920" height="897" alt="Image" src="https://github.com/user-attachments/assets/8e36fe51-09d3-4099-8954-7a9a4ac01aef" />


---

## 📖 Project Overview

In today's competitive market, understanding customer behavior is crucial for business success. **Customer segmentation** is the process of dividing a customer base into groups of individuals that are similar in specific ways relevant to marketing, such as age, gender, interests, and spending habits.

This project implements a customer segmentation solution using the **K-Means clustering algorithm**, a popular unsupervised machine learning technique. By analyzing patterns in the **Mall Customer dataset**, we identify distinct customer segments.

The primary goal is to provide a practical tool (this Streamlit web application) that allows users to:

1.  Input characteristics of a new or hypothetical customer.
2.  Receive an immediate prediction of which segment that customer likely belongs to.
3.  Visualize the segments and understand their defining characteristics (income vs. spending score).

This information can empower businesses to:
* 🎯 Target marketing campaigns more effectively.
* 🛍️ Personalize customer experiences and offers.
* 📈 Optimize product development and pricing strategies.
* 🤝 Enhance customer relationship management (CRM).

---

## ✨ Key Features

* **Interactive Sidebar:** Intuitive controls (`st.selectbox`, `st.slider`) allow users to input customer `Gender`, `Age`, `Annual Income (k$)`, and `Spending Score (1-100)`.
* **Real-time K-Means Prediction:** Utilizes a pre-trained Scikit-learn K-Means model (`k_means.pkl`) to instantly assign the input customer to one of the 4 identified clusters.
* **Data Scaling Integration:** Employs a pre-fitted `StandardScaler` (`scaler.pkl`) to transform user input, ensuring consistency with the model's training data scale for accurate predictions.
* **Dynamic Cluster Labeling:** Intelligently assigns descriptive names to clusters (e.g., "High Income - High Spending") based on the characteristics of their centroids (cluster centers), making the results easily interpretable. Falls back to default labels if dynamic assignment fails.
* **Clear Results Display:** Presents the predicted cluster number (`st.metric`) and the corresponding segment name (`st.success`) prominently.
* **Segment Insights:** Includes an expandable section (`st.expander`) detailing the typical characteristics of each identified customer segment.
* **Interactive Visualization with Plotly:** Features a dynamic scatter plot (`plotly.express.scatter`) showing all customers based on `Annual Income` vs. `Spending Score`, color-coded by their predicted segment. Hovering over points reveals additional customer details (`Age`, `Gender`).
* **Input Customer Highlighting:** The customer defined by the user's input is clearly marked with a distinct 'X' symbol on the scatter plot for easy comparison.
* **Efficient Caching:** Leverages Streamlit's `@st.cache_resource` and `@st.cache_data` decorators to optimize performance by caching the loading of the model, scaler, and dataset.
* **Error Handling:** Includes basic error handling for file loading (model, scaler, data).

---

## 🛠️ Technology Stack

* **Core Language:** Python (3.8+)
* **Web Application Framework:** Streamlit
* **Machine Learning Library:** Scikit-learn
    * `KMeans` for clustering
    * `StandardScaler` for feature scaling
    * `silhouette_score` for model evaluation
* **Data Handling:** Pandas, NumPy
* **Interactive Visualization:** Plotly Express, Plotly Graph Objects (go)
* **Model & Scaler Persistence:** Pickle
* **Development Environment:** Jupyter Notebook (for model training and exploration)

---

## 📊 Dataset: Mall Customer Segmentation

* **Source:** [Kaggle Dataset Link](https://www.kaggle.com/datasets/vjchoudhary7/customer-segmentation-tutorial-in-python) (or update with your specific source)
* **Description:** This dataset contains basic information about mall customers, ideal for segmentation tasks.
* **Features Used in Model:**
    * `Gender`: Categorical (Male/Female), converted to numerical (1/0).
    * `Age`: Numerical.
    * `Annual Income (k$)`: Numerical, representing income in thousands of dollars.
    * `Spending Score (1-100)`: Numerical score assigned by the mall based on customer behavior.
* **Preprocessing Steps (as per `Kmeans Clustering.ipynb`):**
    1.  Load data using Pandas.
    2.  Map `Gender` ('Male': 1, 'Female': 0).
    3.  Drop the `CustomerID` column as it's an identifier and not a feature for clustering.
    4.  Apply `StandardScaler` to the features (`Gender`, `Age`, `Annual Income (k$)`, `Spending Score (1-100)`) before feeding them into the K-Means algorithm.

---

## 🤖 Model Details: K-Means Clustering

The core of this application is a K-Means clustering model trained to group customers into segments.

1.  **Algorithm:** K-Means aims to partition *n* observations into *k* clusters in which each observation belongs to the cluster with the nearest mean (cluster centroid).
2.  **Determining the Number of Clusters (k):**
    * The **Elbow Method** was used (`Kmeans Clustering.ipynb`). 
    * The Sum of Squared Errors (SSE or Inertia) was calculated for different values of *k* (from 1 to 9).
    * A plot of SSE vs. *k* shows an "elbow" point, suggesting the optimal number of clusters where adding more clusters yields diminishing returns in variance reduction.
    * Based on the elbow plot in the notebook, **k = 4** was chosen as the optimal number of clusters.
3.  **Feature Scaling:**
    * Input features (`Gender`, `Age`, `Annual Income (k$)`, `Spending Score (1-100)`) were scaled using `StandardScaler` from Scikit-learn. This is crucial for K-Means as it's distance-based, ensuring features with larger values don't disproportionately influence the result.
    * The *fitted* scaler object is saved to `scaler.pkl` and loaded by the Streamlit app to scale user input.
4.  **Training:**
    * A `KMeans` model with `n_clusters=4` and `random_state=42` (for reproducibility) was fitted on the *scaled* Mall Customer data.
    * The trained model object is saved to `k_means.pkl`.
5.  **Segment Interpretation (Dynamic Labeling):**
    * The application dynamically assigns meaningful labels to the clusters (0, 1, 2, 3) predicted by the model.
    * It retrieves the cluster centers (centroids) from the trained `kmeans_model`.
    * These centers, which are in the *scaled* feature space, are transformed back to the *original* data scale using the `scaler.inverse_transform()` method.
    * By comparing the `Annual Income (k$)` and `Spending Score (1-100)` values of these original-scale centroids against their overall means, the app assigns descriptive labels like "High Income – Low Spending". This makes the prediction output intuitive for the user.
6.  **Evaluation:**
    * The **Silhouette Score** was calculated (`Kmeans Clustering.ipynb`) to measure cluster cohesion and separation.
    * The model achieved a score of **~0.41**. A score closer to 1 indicates well-separated clusters, while a score around 0 indicates overlapping clusters. 0.41 suggests a reasonable segmentation, though potentially with some overlap between groups.

---

## 📁 Code Structure



## ⚙️ Installation & Setup Guide

Follow these instructions to set up and run the project locally:

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/Akshay8087/Customer-Segmentation-Streamlit.git]([https://github.com/Akshay8087/Customer-Segmentation-Streamlit.git](https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-/tree/main/Customer%20Segmentation%20Using%20Unseupervised%20K-means)) # <-- Adjust repo name if needed
   
    ```

2.  **Set up a Python Virtual Environment:** (Highly Recommended)
    ```bash
    python -m venv venv
    ```
    * Activate the environment:
        * Windows: `venv\Scripts\activate`
        * macOS/Linux: `source venv/bin/activate`

3.  **Install Dependencies:**
    Ensure you have a `requirements.txt` file with the following content (or similar versions):
    ```txt
    # requirements.txt
    streamlit
    pandas
    numpy
    scikit-learn
    plotly
    ```
    Install using pip:
    ```bash
    pip install -r requirements.txt
    ```

4.  **Obtain Necessary Files:**
    * Make sure the `Mall_Customers.csv` dataset file is in the root project directory.
    * Ensure the `k_means.pkl` (trained model) and `scaler.pkl` (fitted scaler) files are also in the root directory.
        * *If `scaler.pkl` is missing:* Run the `Kmeans Clustering.ipynb` notebook. Ensure the section that fits the `StandardScaler` and saves it using `pickle.dump(scaler, open("scaler.pkl", "wb"))` is executed.

---

## ▶️ How to Run the Application

1.  Open your terminal or command prompt.
2.  Navigate to the root directory of the cloned project (`cd Customer-Segmentation-Streamlit`).
3.  Activate your virtual environment (e.g., `source venv/bin/activate`).
4.  Execute the Streamlit run command:
    ```bash
    streamlit run app.py
    ```
    (Replace `app.py` with your script's name if different).

5.  Streamlit will provide a local URL (usually `http://localhost:8501`). Open this URL in your web browser.
6.  Interact with the application using the sidebar inputs and view the results! 🎉

---

## 🚀 Future Enhancements

* **Advanced Clustering Techniques:** Explore algorithms like DBSCAN, Gaussian Mixture Models (GMM), or Agglomerative Clustering to compare segmentation quality.
* **Feature Engineering:** Create new features (e.g., Age Groups, Income/Spending Ratio) to potentially improve cluster separation.
* **Dimensionality Reduction:** Use techniques like PCA or t-SNE for 2D visualization if more features are added.
* **Detailed Cluster Profiling:** Add more descriptive statistics and visualizations (e.g., box plots, histograms) for each segment within the app.
* **User Feedback Mechanism:** Allow users to rate the relevance of the predicted segment.
* **Deployment:** Package the application (e.g., using Docker) and deploy it to a cloud service (Streamlit Community Cloud, Heroku, AWS Beanstalk, Azure App Service) for wider access.
* **Unit & Integration Tests:** Add tests to ensure code reliability.

---

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1.  Fork the repository ([https://github.com/Akshay8087/Customer-Segmentation-Streamlit/fork](https://github.com/Akshay8087/Customer-Segmentation-Streamlit/fork)).
2.  Create a new branch (`git checkout -b feature/your-feature-name`).
3.  Make your changes and commit them (`git commit -m 'Add some feature'`).
4.  Push to the branch (`git push origin feature/your-feature-name`).
5.  Open a Pull Request.

Please ensure your code adheres to standard Python style guides (e.g., PEP 8).

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. *(**Note:** Ensure a LICENSE file exists in your repository)*.

---

## 🙏 Acknowledgements

* Dataset provided via Kaggle: [Mall Customer Segmentation Data](https://www.kaggle.com/datasets/vjchoudhary7/customer-segmentation-tutorial-in-python).
* The open-source communities behind Python, Streamlit, Scikit-learn, Plotly, Pandas, and NumPy.

---

## 📧 Contact

Akshay8087 – [akshay8087.github@email.com](mailto:akshay8087.github@email.com) *(Placeholder Email - Update if desired)*

Project Link: [https://github.com/Akshay8087/Customer Segmentation Using Unseupervised K-means]([https://github.com/Akshay8087/Customer-Segmentation-Streamlit](https://github.com/Akshay8087/Data-Analyst-Portfolio-From-Raw-Data-to-Actionable-Insights-/tree/main/Customer%20Segmentation%20Using%20Unseupervised%20K-means))

---





