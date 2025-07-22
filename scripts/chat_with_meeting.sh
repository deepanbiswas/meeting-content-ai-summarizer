#!/bin/bash

# Interactive Chat with Meeting Content
# This script runs the Python chat interface with proper error handling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/chat_with_content.py"

# Check if Python script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "❌ Error: chat_with_content.py not found in $SCRIPT_DIR"
    exit 1
fi

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed or not in PATH"
    exit 1
fi

# Check if Ollama is running
if ! command -v ollama &> /dev/null; then
    echo "❌ Error: Ollama is not installed or not in PATH"
    exit 1
fi

# Run the Python script with all passed arguments
echo "🤖 Starting Interactive Chat with Meeting Content..."
python3 "$PYTHON_SCRIPT" "$@"
