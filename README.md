📘 MEETING CONTENT SUMMARIZER
==============================

Summarize meeting content and chat with it using AI - from transcripts, slides, and videos.

## 🚀 QUICK START

### Option 1: GUI App (Streamlit)
```bash
# Summarizer GUI
cd gui_app
streamlit run app.py

# Interactive Chat GUI  
cd gui_app
streamlit run chat_app.py
```

### Option 2: Command Line
```bash
cd scripts

# Generate Summary
python3 summarize_all.py --transcript file.txt --output summary.txt

# Interactive Chat
python3 chat_with_content.py --transcript file.txt
```

## 📋 USAGE EXAMPLES

**Summarizer GUI:**
- Navigate to `gui_app/` folder → Run `streamlit run app.py`
- Upload transcript/slides/video files → Download generated summary

**Interactive Chat GUI:**
- Navigate to `gui_app/` folder → Run `streamlit run chat_app.py`
- Upload files → Ask questions about the content

**Command Line - Summary:**
```bash
# Transcript only
python3 summarize_all.py --transcript meeting.txt --output summary.txt

# Multiple inputs
python3 summarize_all.py --transcript meeting.txt --slides deck.pptx --video recording.mp4 --output summary.txt
```

**Command Line - Interactive Chat:**
```bash
# Chat with transcript
python3 chat_with_content.py --transcript meeting.txt

# Chat with multiple inputs
python3 chat_with_content.py --transcript meeting.txt --slides deck.pptx --video recording.mp4

# Use shell wrapper
./chat_with_meeting.sh --transcript meeting.txt
```

## 📦 REQUIREMENTS

**Prerequisites:**
- Python 3.8+
- Ollama with Mistral model: `ollama pull mistral`

**Install Python packages:**
```bash
pip install openai-whisper python-pptx streamlit
```

**Or install from requirements:**
```bash
pip install -r requirements.txt
```

## 📁 SUPPORTED FILES
- **Transcripts:** .txt files
- **Slides:** .pptx files  
- **Videos:** .mp4, .mov, .mkv files

## ⚡ FEATURES
- ✅ **AI-powered summarization** via Ollama + Mistral
- ✅ **Interactive Q&A chat** with meeting content
- ✅ **Video transcription** using Whisper
- ✅ **PowerPoint text extraction**
- ✅ **Web interface and command line** options
- ✅ **Error handling and progress** feedback
- ✅ **Chat history and quick actions**

---
**Ready to summarize? Choose GUI or CLI above!**