import streamlit as st
import pickle
import string
import nltk
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
import sys

# --- Page Configuration ---
# This should be the first Streamlit command
st.set_page_config(
    page_title="Spam Classifier",
    page_icon="📧"
)

# --- NLTK Data Downloader ---
# This function checks if NLTK data is available and downloads if not.
# It makes your app more robust, especially for deployment.
@st.cache_resource
def download_nltk_data():
    try:
        nltk.data.find('tokenizers/punkt_tab')
    except LookupError:
        st.info("Downloading NLTK 'punkt_tab' data...")
        nltk.download('punkt_tab', quiet=True)
    
    try:
        nltk.data.find('corpora/stopwords')
    except LookupError:
        st.info("Downloading NLTK 'stopwords' data...")
        nltk.download('stopwords', quiet=True)

# Run the downloader
download_nltk_data()

# --- Load Models ---
# Use st.cache_resource to load models only once
@st.cache_resource
def load_vectorizer():
    try:
        with open('vectorizer.pkl', 'rb') as f:
            return pickle.load(f)
    except FileNotFoundError:
        st.error("Error: 'vectorizer.pkl' file not found.")
        st.stop()
    except Exception as e:
        st.error(f"An error occurred loading the vectorizer: {e}")
        st.stop()

@st.cache_resource
def load_model():
    try:
        with open('model.pkl', 'rb') as f:
            return pickle.load(f)
    except FileNotFoundError:
        st.error("Error: 'model.pkl' file not found.")
        st.stop()
    except Exception as e:
        st.error(f"An error occurred loading the model: {e}")
        st.stop()

# --- Preprocessing Function ---
ps = PorterStemmer()

def transform_text(text):
    text = text.lower()
    text = nltk.word_tokenize(text)

    y = []
    for i in text:
        if i.isalnum():
            y.append(i)

    text = y[:]
    y.clear()

    stop_words = set(stopwords.words('english'))
    punc = set(string.punctuation)

    for i in text:
        if i not in stop_words and i not in punc:
            y.append(i)

    text = y[:]
    y.clear()

    for i in text:
        y.append(ps.stem(i))

    return " ".join(y)

# --- Streamlit App UI ---
st.title("📧 Email/SMS Spam Classifier")
st.markdown("Enter a message below to check if it's spam or not.")

# Load the models
try:
    tfidf = load_vectorizer()
    model = load_model()
except:
    # Errors are already handled in the load functions
    sys.exit()


# Input area
input_sms = st.text_area(
    "Enter the message:", 
    placeholder="Type or paste your message here...",
    height=150,
    label_visibility="collapsed"
)

# Predict button
if st.button('Classify Message', type="primary"):
    
    # Check if input is empty
    if not input_sms.strip():
        st.warning("Please enter a message to classify.")
    else:
        # 1. Preprocess
        transformed_sms = transform_text(input_sms)
        # 2. Vectorize
        vector_input = tfidf.transform([transformed_sms])
        # 3. Predict
        result = model.predict(vector_input)[0]
        
        # 4. Display result
        if result == 1:
            st.error("This looks like SPAM!", icon="🚨")
        else:
            st.success("This looks like NOT SPAM.", icon="✅")