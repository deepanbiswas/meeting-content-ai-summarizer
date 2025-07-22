#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Activate virtual environment and run Streamlit app
echo "🚀 Starting Meeting Summarizer App..."
echo "📍 Make sure Ollama is running and Mistral model is available"
echo "   To install Mistral model: ollama pull mistral"
echo ""

# Run the Streamlit app
"/Volumes/Primary Data Disk (Hyper)/local llm setup/solutions/summarize_content/.venv/bin/python" -m streamlit run gui_app/app.py
