import os
import csv
from mutagen.easyid3 import EasyID3
from mutagen.flac import FLAC
from mutagen.mp4 import MP4
from mutagen.oggopus import OggOpus

# Set the path of the main directory containing all artist folders
main_path = "/media/iso/Adele"

# Set the path of the output folder where CSV file will be saved
output_folder = "/home/sam"

# Create an empty list to hold track information
tracks = []

# Define a recursive function to traverse all directories and sub-directories
def process_directory(directory_path):
    # Loop through each folder in the current directory
    for folder_name in os.listdir(directory_path):
        folder_path = os.path.join(directory_path, folder_name)

        # If the folder is a directory, call the function recursively with the folder path
        if os.path.isdir(folder_path):
            process_directory(folder_path)

        # If the folder is not a directory or does not contain any audio files, continue the loop
        if not os.path.isdir(folder_path) or not any(file.endswith((".mp3", ".flac", ".m4a", ".opus")) for file in os.listdir(folder_path)):
            continue

        # Extract metadata information from audio files in the folder
        for filename in os.listdir(folder_path):
            filepath = os.path.join(folder_path, filename)
            if not os.path.isfile(filepath):
                continue
            extension = os.path.splitext(filename)[-1].lower()
            if extension not in (".mp3", ".flac", ".m4a", ".opus"):
                continue

            # Extract metadata information from audio file
            try:
                if extension == ".mp3":
                    song_data = EasyID3(filepath)
                elif extension == ".flac":
                    song_data = FLAC(filepath)
                elif extension == ".m4a":
                    song_data = MP4(filepath)
                else:
                    song_data = OggOpus(filepath)
                bitrate = song_data.info.bitrate // 1000 if hasattr(song_data, 'info') else ""
                artist_name = song_data.get("artist", [""])[0]
            except Exception as e:
                print(f"Error reading metadata from {filename}: {e}")
                continue

            # Append extracted information to tracks list
            album_title = song_data.get("album", ["Unknown Album"])[0]
            track_number = song_data.get("tracknumber", [""])[0].split('/')[0] if "tracknumber" in song_data else ""
            track_title = song_data.get("title", ["Unknown Title"])[0]
            year = song_data.get("date", [""])[0][:4] if "date" in song_data else ""

            tracks.append([artist_name, album_title, track_number, track_title, year, str(bitrate) + " kbps", extension[1:]])

    return

# Call the recursive function on the main directory path
process_directory(main_path)

# Write tracks list to CSV file
csv_file = os.path.join(output_folder, "music_data.csv")
with open(csv_file, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Artist Name", "Album Title", "Track Number", "Track Title", "Year", "Bitrate", "File Extension"])
    for track in tracks:
        writer.writerow(track)