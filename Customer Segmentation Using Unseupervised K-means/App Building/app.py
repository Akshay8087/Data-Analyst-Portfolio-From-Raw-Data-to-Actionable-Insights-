import streamlit as st
import pandas as pd
import numpy as np
import pickle
import matplotlib.pyplot as plt
import os

# --- Page Configuration ---
st.set_page_config(
    page_title="Customer Segmentation App",
    page_icon="🛍️",
    layout="wide",
    initial_sidebar_state="expanded"
)

# --- Load Model and Data ---
MODEL_PATH = "k_means.pkl"
DATA_PATH = "Mall_Customers.csv"

@st.cache_resource # Cache the model loading
def load_model(path):
    """Loads the pickled K-Means model."""
    try:
        with open(path, 'rb') as file:
            model = pickle.load(file)
        return model
    except FileNotFoundError:
        st.error(f"Error: Model file not found at {path}. Make sure 'k_means.pkl' is in the same directory.")
        return None
    except Exception as e:
        st.error(f"Error loading the model: {e}")
        return None

@st.cache_data # Cache the data loading and preprocessing
def load_and_preprocess_data(path):
    """Loads and preprocesses the Mall Customer data for visualization."""
    try:
        df = pd.read_csv(path)
        # Apply the same preprocessing as in the notebook
        df_processed = df.copy()
        df_processed["Gender"] = df_processed["Gender"].map({"Male": 1, "Female": 0})
        df_processed.drop(columns=["CustomerID"], axis=1, inplace=True)
        return df, df_processed # Return both original (for context if needed) and processed
    except FileNotFoundError:
        st.error(f"Error: Data file not found at {path}. Make sure 'Mall_Customers.csv' is in the same directory.")
        return None, None
    except Exception as e:
        st.error(f"Error loading or preprocessing data: {e}")
        return None, None

kmeans_model = load_model(MODEL_PATH)
df_original, df_processed = load_and_preprocess_data(DATA_PATH)

# Cluster labels dictionary (same as in your notebook)
cluster_labels = {
    0: "Moderate Income – Average Spending",
    1: "High Income – High Spending (Luxury Spenders)",
    2: "Low Income – High Spending (Target Customers)",
    3: "High Income – Low Spending (Careful Spenders)"
}

# --- Sidebar for User Input ---
st.sidebar.header("👤 Customer Input Features")

gender = st.sidebar.selectbox("Gender", ("Male", "Female"))
age = st.sidebar.slider("Age", 18, 100, 30, help="Select customer's age.")
income = st.sidebar.slider("Annual Income (k$)", 10, 150, 50, help="Enter customer's annual income in thousands of dollars.")
spending_score = st.sidebar.slider("Spending Score (1-100)", 1, 100, 50, help="Enter customer's spending score (1=low, 100=high).")

# --- Main Panel ---
st.title("🛍️ Customer Segmentation Prediction")
st.markdown("""
Welcome! This app predicts the customer segment based on their demographic and spending behavior using a K-Means clustering model.
Enter the customer details in the sidebar to see their predicted segment.
""")

# --- Prediction Logic ---
if kmeans_model is not None:
    # Preprocess input
    gender_map = {'Male': 1, 'Female': 0}
    gender_numeric = gender_map[gender]

    # Prepare input for prediction
    input_data = np.array([[gender_numeric, age, income, spending_score]])

    # Predict cluster
    try:
        prediction = kmeans_model.predict(input_data)
        predicted_cluster = prediction[0]
        segment = cluster_labels.get(predicted_cluster, "Unknown Segment")

        # Display prediction
        st.subheader("📊 Prediction Result")
        col1, col2 = st.columns(2)
        with col1:
            st.metric(label="Predicted Cluster", value=predicted_cluster)
        with col2:
            st.success(f"**Customer Segment:** {segment}")

        # --- Segment Explanation ---
        st.markdown("---")
        with st.expander("ℹ️ About the Segments"):
            st.markdown(f"""
            Based on the analysis, customers are grouped into the following segments:

            * **{cluster_labels[2]} (Cluster 2):** Customers with lower income but high spending scores. Often younger individuals, potential targets for specific promotions.
            * **{cluster_labels[0]} (Cluster 0):** Represents the average customer with moderate income and spending. This is often the largest group.
            * **{cluster_labels[1]} (Cluster 1):** High income earners who also spend frequently. Prime candidates for luxury goods and premium services.
            * **{cluster_labels[3]} (Cluster 3):** Customers with high income but low spending scores. They might be cautious spenders or save more.
            """)

    except Exception as e:
        st.error(f"An error occurred during prediction: {e}")

else:
    st.warning("Model could not be loaded. Prediction is unavailable.")

# --- Visualization (Optional) ---
st.markdown("---")
st.subheader("📈 Cluster Visualization (All Customers)")

if df_processed is not None and kmeans_model is not None:
    try:
        # Add cluster predictions to the processed data if not already present
        if 'Clusters' not in df_processed.columns:
             df_processed['Clusters'] = kmeans_model.predict(df_processed[['Gender', 'Age', 'Annual Income (k$)', 'Spending Score (1-100)']])

        # Create the plot
        fig, ax = plt.subplots(figsize=(10, 6))
        colors = ['blue', 'darkorange', 'green', 'red'] # Consistent colors

        for cluster, color in zip(range(kmeans_model.n_clusters), colors):
            cluster_data = df_processed[df_processed['Clusters'] == cluster]
            ax.scatter(
                cluster_data['Annual Income (k$)'],
                cluster_data['Spending Score (1-100)'],
                c=color,
                label=cluster_labels.get(cluster, f"Cluster {cluster}"),
                alpha=0.7,
                edgecolors='w',
                s=60
            )

        # Add the input customer point
        ax.scatter(
            income,
            spending_score,
            c=colors[predicted_cluster], # Color based on prediction
            label='Input Customer',
            marker='X', # Distinct marker
            s=150, # Larger size
            edgecolors='black',
            linewidth=1.5
        )


        ax.set_title('Customer Segments based on Income and Spending Score')
        ax.set_xlabel('Annual Income (k$)')
        ax.set_ylabel('Spending Score (1–100)')
        ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
        ax.grid(True, linestyle='--', alpha=0.5)
        plt.tight_layout()
        st.pyplot(fig)

    except Exception as e:
        st.warning(f"Could not generate visualization: {e}")
        st.write("Ensure 'Mall_Customers.csv' is available and the model is loaded correctly.")

elif df_processed is None:
    st.warning("Could not load data for visualization.")

st.markdown("---")
st.sidebar.info("App created based on K-Means clustering model.")