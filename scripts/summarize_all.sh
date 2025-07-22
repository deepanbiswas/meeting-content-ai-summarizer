import argparse
import os
import subprocess
import tempfile
from pptx import Presentation
import whisper

# Extract text from pptx
def extract_text_from_pptx(pptx_path):
    try:
        prs = Presentation(pptx_path)
        text = ""
        for slide in prs.slides:
            for shape in slide.shapes:
                if hasattr(shape, "text"):
                    text += shape.text + "\n"
        return text.strip()
    except Exception as e:
        return f"Error extracting text from PPTX: {str(e)}"

# Transcribe video using Whisper
def transcribe_video(video_path):
    try:
        model = whisper.load_model("base")
        result = model.transcribe(video_path)
        return result["text"]
    except Exception as e:
        return f"Error transcribing video: {str(e)}"

# Summarize with Mistral via Ollama
def summarize_with_ollama(input_text):
    try:
        prompt = "Summarize the following combined meeting content including transcript, slides, and video discussion.\n\n" + input_text
        
        # Use stdin to pass the prompt to ollama
        result = subprocess.run(
            ["ollama", "run", "mistral"], 
            input=prompt, 
            capture_output=True, 
            text=True, 
            timeout=300  # 5 minute timeout
        )
        
        if result.returncode != 0:
            return f"Error running Ollama: {result.stderr}"
        
        return result.stdout.strip()
    except subprocess.TimeoutExpired:
        return "Error: Ollama request timed out (5 minutes)"
    except Exception as e:
        return f"Error: {str(e)}"

# Main function
def main(args):
    combined_text = ""
    error_messages = []

    if args.transcript:
        try:
            with open(args.transcript, 'r', encoding='utf-8') as f:
                transcript_text = f.read()
            combined_text += "\n--- Transcript ---\n" + transcript_text
        except Exception as e:
            error_messages.append(f"Error reading transcript: {str(e)}")

    if args.slides:
        ppt_text = extract_text_from_pptx(args.slides)
        if ppt_text.startswith("Error"):
            error_messages.append(ppt_text)
        else:
            combined_text += "\n--- Slides ---\n" + ppt_text

    if args.video:
        print("🎥 Transcribing video... This may take a few minutes.")
        video_text = transcribe_video(args.video)
        
        if video_text.startswith("Error"):
            error_messages.append(video_text)
        else:
            combined_text += "\n--- Video ---\n" + video_text

    if error_messages:
        print("❌ Errors encountered:")
        for error in error_messages:
            print(f"   {error}")

    if combined_text.strip() == "":
        print("⚠️  Please provide at least one input file (transcript, slides, or video).")
        return

    print("🔄 Generating summary via Mistral...")
    summary = summarize_with_ollama(combined_text)
    
    if summary.startswith("Error"):
        print(f"❌ {summary}")
        return
    
    print("\n✅ Summary:\n")
    print(summary)

    if args.output:
        try:
            with open(args.output, 'w', encoding='utf-8') as f:
                f.write(summary)
            print(f"\n📄 Summary saved to: {args.output}")
        except Exception as e:
            print(f"❌ Error saving summary: {str(e)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Summarize meeting content using Whisper + Ollama + Mistral")
    parser.add_argument("--transcript", help="Path to transcript (.txt) file")
    parser.add_argument("--slides", help="Path to PowerPoint (.pptx) file")
    parser.add_argument("--video", help="Path to meeting video (.mp4, .mov, etc.)")
    parser.add_argument("--output", help="Path to save summary output (.txt)")

    args = parser.parse_args()
    main(args)