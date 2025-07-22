#!/bin/bash

# Meeting Content Summarizer Script
# This script runs the Python summarizer with proper error handling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/summarize_all.py"

# Check if Python script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "❌ Error: summarize_all.py not found in $SCRIPT_DIR"
    exit 1
fi

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed or not in PATH"
    exit 1
fi

# Run the Python script with all passed arguments
echo "🚀 Starting Meeting Content Summarizer..."
python3 "$PYTHON_SCRIPT" "$@"
