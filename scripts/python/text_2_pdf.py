# pip install reportlab
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
import os

def merge_texts_to_pdf(text_files, output_pdf):
    c = canvas.Canvas(output_pdf, pagesize=letter)
    width, height = letter
    margin = 50
    line_height = 12
    y_position = height - margin

    for text_file in text_files:
        try:
            with open(text_file, 'r', encoding='utf-8') as file:
                for line in file:
                    if y_position < margin:  # Start a new page if space runs out
                        c.showPage()
                        y_position = height - margin
                    c.drawString(margin, y_position, line.strip())
                    y_position -= line_height
        except UnicodeDecodeError:
            # Retry with a fallback encoding
            with open(text_file, 'r', encoding='latin1') as file:
                for line in file:
                    if y_position < margin:
                        c.showPage()
                        y_position = height - margin
                    c.drawString(margin, y_position, line.strip())
                    y_position -= line_height
    c.save()

# Specify the folder containing text files and output PDF
folder_path = r"C:\Cloud\Documents"  # Replace with your folder path
output_pdf = "merged_output.pdf"

# Collect all .txt files from the folder
text_files = [os.path.join(folder_path, f) for f in os.listdir(folder_path) if f.endswith('.txt')]

# Merge text files into a single PDF
merge_texts_to_pdf(text_files, output_pdf)
print(f"PDF created successfully: {output_pdf}")