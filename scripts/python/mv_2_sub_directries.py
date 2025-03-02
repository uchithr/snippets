import os
import shutil

source_dir = r'C:\Users\ABC\Desktop\PAK'
destination_dir = r'C:\Users\ABC\Desktop\PAK'
files_per_directory = 500
extensions = ('.jpg',)

# Create the destination directory if it doesn't exist
if not os.path.exists(destination_dir):
    os.mkdir(destination_dir)

# Loop through all JPG files in the source directory
file_count = 0
dir_count = 1
subdir_prefix = 'subdir'
for filename in os.listdir(source_dir):
    if os.path.splitext(filename)[1].lower() not in extensions:
        continue

    # Move the file to the current subdirectory
    subdir_name = '{}{}'.format(subdir_prefix, dir_count)
    subdir_path = os.path.join(destination_dir, subdir_name)
    if not os.path.exists(subdir_path):
        os.mkdir(subdir_path)
    src_path = os.path.join(source_dir, filename)
    dst_path = os.path.join(subdir_path, filename)
    shutil.move(src_path, dst_path)

    # Increment the file count and create a new subdirectory if necessary
    file_count += 1
    if file_count == files_per_directory:
        file_count = 0
        dir_count += 1
