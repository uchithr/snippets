import os

# Set this to the actual path where you want the folders
base_path = r"P:\[BURN]"

titles = [
    "01 - ",
    "02 - ",
    "03 - ",
    "04 - ",
    "05 - ",
    "06 - ",
    "07 - ",
    "08 - ",
    "09 - ",
    "10 - ",
    "11 - ",
    "12 - ",
    "13 - ",
    "14 - ",
    "15 - "
]

# Create folders
for title in titles:
    folder_path = os.path.join(base_path, title)
    try:
        os.makedirs(folder_path, exist_ok=True)
        print(f"Created: {folder_path}")
    except Exception as e:
        print(f"Error creating {folder_path}: {e}")