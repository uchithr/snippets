from PIL import Image
import os

# SETTINGS
img_width, img_height = 1000, 1500
columns, rows = 6, 3
canvas_width = columns * img_width
canvas_height = rows * img_height
image_folder = os.path.dirname(__file__)  # folder where this script is

# Valid image extensions
valid_exts = (".jpg", ".jpeg", ".png", ".webp")

# Load and sort image files numerically (based on filename without extension)
image_files = sorted(
    [f for f in os.listdir(image_folder) if f.lower().endswith(valid_exts)],
    key=lambda x: int(os.path.splitext(x)[0])
)

# Ensure exactly 15 images are found
if len(image_files) != 18:
    raise ValueError(f"Expected 15 image files, found {len(image_files)} in folder: {image_folder}")

# Create a blank canvas
collage = Image.new('RGB', (canvas_width, canvas_height), color='white')

# Paste each image into the grid
for idx, filename in enumerate(image_files):
    img_path = os.path.join(image_folder, filename)
    img = Image.open(img_path).resize((img_width, img_height))

    x = (idx % columns) * img_width
    y = (idx // columns) * img_height
    collage.paste(img, (x, y))

# Save final image
output_path = os.path.join(image_folder, "collage_5x3.jpg")
collage.save(output_path)
print(f"✅ Collage created successfully: {output_path}")