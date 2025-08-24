# FFmpeg and Media Processing Snippets

This document provides a collection of FFmpeg, HandBrake CLI, and MakeMKV CLI commands for common media processing tasks. Each command is accompanied by clear explanations, organized into sections, and formatted for easy reading on GitHub. The snippets are optimized for clarity and include comments to explain their purpose and usage.

## Table of Contents
- [FFmpeg Commands](#ffmpeg-commands)
  - [Video Conversion](#video-conversion)
  - [Audio Manipulation](#audio-manipulation)
  - [Frame Extraction](#frame-extraction)
  - [Video Cutting and Merging](#video-cutting-and-merging)
  - [Images to Video](#images-to-video)
  - [Metadata and Encoding](#metadata-and-encoding)
  - [Video Transformations](#video-transformations)
  - [Audio Stream Mapping](#audio-stream-mapping)
- [HandBrake CLI Commands](#handbrake-cli-commands)
- [MakeMKV CLI Commands](#makemkv-cli-commands)
- [Contributing](#contributing)

## FFmpeg Commands

### Video Conversion

#### Convert MKV to MP4
Converts an MKV file to MP4 without re-encoding, copying both video and audio streams for faster processing.

```bash
ffmpeg -i input.mkv -vcodec copy -acodec copy output.mp4
```

**Explanation**:
- `-i input.mkv`: Specifies the input file.
- `-vcodec copy`: Copies the video stream without re-encoding.
- `-acodec copy`: Copies the audio stream without re-encoding.
- `output.mp4`: Specifies the output file.

#### Batch Convert FLAC to MP3
Converts all FLAC files in subdirectories to MP3 with specific settings and deletes the original FLAC files.

```bash
#!/bin/bash
for f in **/*.flac; do
  ffmpeg -i "$f" -ab 320k -map_metadata 0 -id3v2_version 3 "${f%.*}.mp3
done
find . -name "*.flac" -type f -delete
```

**Explanation**:
- `for f in **/*.flac`: Loops through all `.flac` files in the current directory and subdirectories.
- `-ab 320k`: Sets the audio bitrate to 320 kbps.
- `-map_metadata 0`: Copies metadata from the input file.
- `-id3v2_version 3`: Uses ID3v2 version 3 for MP3 metadata.
- `find . -name "*.flac" -type f -delete`: Deletes all `.flac` files after conversion.

### Audio Manipulation

#### Remove Audio from Video
Removes the audio stream from a video file, copying the video stream without re-encoding.

```bash
ffmpeg -i input.mp4 -c:v copy -an output.mp4
```

**Explanation**:
- `-c:v copy`: Copies the video stream without re-encoding.
- `-an`: Removes (disables) the audio stream.

#### Extract Audio from Video
Extracts the audio stream from an MKV file without re-encoding.

```bash
ffmpeg -i input.mkv -vn -acodec copy output.aac
```

**Explanation**:
- `-vn`: Disables the video stream.
- `-acodec copy`: Copies the audio stream without re-encoding.

#### Combine Video and Audio
Combines a video file and an audio file into a single MP4 file.

```bash
ffmpeg -i video.mp4 -i audio.wav -c:v copy -c:a aac output.mp4
```

**Explanation**:
- `-i video.mp4 -i audio.wav`: Specifies the input video and audio files.
- `-c:v copy`: Copies the video stream.
- `-c:a aac`: Encodes the audio to AAC format.

### Frame Extraction

#### Extract All Frames
Extracts all frames from a video as JPEG images, suitable for short videos (4-5 minutes).

```bash
ffmpeg -i input.mp4 -vsync 0 thumb%04d.jpeg
```

**Explanation**:
- `-vsync 0`: Ensures frames are extracted without frame rate synchronization.
- `thumb%04d.jpeg`: Outputs frames as `thumb0001.jpeg`, `thumb0002.jpeg`, etc.

#### Extract Frames at Specific Frame Rate
Extracts frames at 24 fps from a MOV file.

```bash
ffmpeg -i input.mov -r 24/1 thumb%03d.jpg
```

**Explanation**:
- `-r 24/1`: Sets the output frame rate to 24 frames per second.
- `thumb%03d.jpg`: Outputs frames as `thumb001.jpg`, `thumb002.jpg`, etc.

#### Extract Image Every Second
Extracts one image per second from a video.

```bash
ffmpeg -i input.mp4 -vf fps=1 thumb%04d.jpeg
```

**Explanation**:
- `-vf fps=1`: Sets the filter to extract one frame per second.
- `thumb%04d.jpeg`: Outputs frames with four-digit numbering.

#### Extract Image Every 10 Minutes
Extracts one image every 600 seconds (10 minutes) from a video.

```bash
ffmpeg -i input.mp4 -vf fps=1/600 thumb%04d.jpeg
```

**Explanation**:
- `-vf fps=1/600`: Extracts one frame every 600 seconds.

#### Extract Frames for Source Comparison
Extracts frames from a specific time range at 1 fps for comparison purposes.

```bash
ffmpeg -ss 01:11:30.000 -to 01:12:30.000 -i input.mkv -vf fps=1 C:\Users\SLVR\Pictures\comparison\%04d_265.bmp
```

**Explanation**:
- `-ss 01:11:30.000`: Starts extraction at 1 hour, 11 minutes, 30 seconds.
- `-to 01:12:30.000`: Ends extraction at 1 hour, 12 minutes, 30 seconds.
- `-vf fps=1`: Extracts one frame per second.
- Outputs BMP images to the specified directory.

#### Create Contact Sheet
Generates a contact sheet (tiled image) from video frames, sampling every 600th frame.

```bash
ffmpeg -i input.mp4 -vf "select=not(mod(n,600)),scale=1600:-1,tile=3x40" output.jpg
```

**Explanation**:
- `select=not(mod(n,600))`: Selects every 600th frame.
- `scale=1600:-1`: Scales frames to 1600px width, preserving aspect ratio.
- `tile=3x40`: Arranges frames in a 3x40 grid.

### Video Cutting and Merging

#### Cut Video (Accurate)
Cuts a specific portion of a video with precise timing, copying streams without re-encoding.

```bash
ffmpeg -ss 00:03:30.000 -i input.mp4 -vcodec copy -acodec copy -copyinkf -movflags use_metadata_tags -to 00:42:17.000 output.mp4
```

**Explanation**:
- `-ss 00:03:30.000`: Starts at 3 minutes, 30 seconds.
- `-to 00:42:17.000`: Ends at 42 minutes, 17 seconds.
- `-copyinkf`: Copies non-keyframe data.
- `-movflags use_metadata_tags`: Preserves metadata.

#### Cut First 30 Seconds
Extracts the first 30 seconds of an audio file.

```bash
ffmpeg -ss 0 -to 30 -i input.flac out.flac
```

**Explanation**:
- `-ss 0`: Starts at the beginning.
- `-to 30`: Ends at 30 seconds.

#### Remove First 30 Seconds
Removes the first 30 seconds of an audio file.

```bash
ffmpeg -ss 30 -i input.flac out.flac
```

**Explanation**:
- `-ss 30`: Skips the first 30 seconds.

#### Remove First 59 Seconds
Removes the first 59 seconds of an audio file.

```bash
ffmpeg -ss 59 -i input.m4a out.m4a
```

**Explanation**:
- `-ss 59`: Skips the first 59 seconds.

#### Merge Videos
Merges multiple video files listed in a text file into a single MKV file.

```bash
ffmpeg -f concat -i file_list.txt -c copy output.mkv
```

**Explanation**:
- `-f concat`: Specifies concatenation mode.
- `-i file_list.txt`: Reads the list of files to merge (format: `file 'input_a.mp4'` per line).
- `-c copy`: Copies streams without re-encoding.

#### Generate Concatenation File
Creates a text file listing image files for merging.

```bash
for file in IMG*.jpg; do echo "file '$file'"; done > file_list.txt
```

**Explanation**:
- Loops through all files matching `IMG*.jpg`.
- Outputs each file name in the format `file 'filename'` to `file_list.txt`.

### Images to Video
Converts a sequence of images into a video with specified resolution and frame rate.

```bash
ffmpeg -f image2 -framerate 0.125 -i IMG%02d.jpg -c:v libx264 -pix_fmt yuv420p -r 25 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" output.mp4
```

**Explanation**:
- `-f image2`: Specifies the input format as images.
- `-framerate 0.125`: Sets the input frame rate (8 seconds per image).
- `-i IMG%02d.jpg`: Reads images like `IMG01.jpg`, `IMG02.jpg`.
- `-c:v libx264`: Uses H.264 video codec.
- `-pix_fmt yuv420p`: Ensures compatibility with most players.
- `-r 25`: Sets output frame rate to 25 fps.
- `-vf scale=1920:1080:...`: Scales and pads images to 1920x1080, centering them.

### Metadata and Encoding

#### Set Video Metadata
Sets specific color metadata for an MKV file.

```bash
ffmpeg -i input.mkv -color_range tv -color_primaries bt709 -color_trc bt709 -colorspace bt709 -c:v copy -c:a copy out.mkv
```

**Explanation**:
- Sets color range, primaries, transfer characteristics, and color space to BT.709 standards.
- Copies video and audio streams without re-encoding.

#### Encode with H.265 (8-bit)
Encodes a video to H.265 with a constant rate factor (CRF) for quality control.

```bash
ffmpeg -i input.mkv -c:v libx265 -preset medium -crf 28 -c:a aac -b:a 128k outputx265.mkv
```

**Explanation**:
- `-c:v libx265`: Uses H.265 codec.
- `-preset medium`: Balances speed and quality.
- `-crf 28`: Sets quality (lower values = higher quality, larger files).
- `-c:a aac -b:a 128k`: Encodes audio to AAC at 128 kbps.

#### Encode with H.265 (10-bit)
Encodes a video to 10-bit H.265 for better color depth.

```bash
ffmpeg -i input.mp4 -c:v libx265 -preset medium -crf 28 -pix_fmt yuv420p10le -c:a copy -y output-x26510bit.mkv
```

**Explanation**:
- `-pix_fmt yuv420p10le`: Uses 10-bit color depth.
- `-y`: Overwrites output file if it exists.

#### Encode with H.265 (10-bit with Grain)
Encodes a 10-bit H.265 video with film grain preservation.

```bash
ffmpeg -y -i input.mp4 -c:v libx265 -preset medium -crf 26 -pix_fmt yuv420p10le -x265-params psy-rd=2:psy-rdoq=6:rdoq-level=1 -c:a copy output-x26510bit.mkv
```

**Explanation**:
- `-crf 26`: Slightly higher quality than 28.
- `-x265-params`: Custom parameters to preserve film grain (`psy-rd`, `psy-rdoq`, `rdoq-level`).

**Common CRF Values**:
- `28`: Default, good balance of quality and size.
- `25`: Good quality, slightly larger files.
- `24`: Larger files, higher quality.
- `22`: Even larger files, very high quality.

### Video Transformations

#### Vertical Flip
Flips a video vertically or adjusts rotation metadata.

```bash
ffmpeg -i input.mp4 -c copy -metadata:s:v:0 rotate=0 output.mp4
```

**Rotation Options**:
- `0`: 90° counterclockwise and vertical flip (default, common in EXIF data).
- `1`: 90° clockwise (common in mobile videos).
- `2`: 90° counterclockwise.
- `3`: 90° clockwise and vertical flip.

**Alternative (Explicit Vertical Flip)**:
```bash
ffmpeg -i input.mp4 -vf vflip -c:a copy output.mp4
```

**Explanation**:
- `-vf vflip`: Applies vertical flip filter.
- `-c:a copy`: Copies audio without re-encoding.

#### Set Aspect Ratio
Sets the aspect ratio of a video without re-encoding.

```bash
ffmpeg -i input.mp4 -vcodec copy -acodec copy -aspect x:y output.mp4
```

**Explanation**:
- `-aspect x:y`: Sets the display aspect ratio (e.g., 16:9, 4:3).

### Audio Stream Mapping

#### Check Available Streams
Lists all streams in a media file.

```bash
ffmpeg -i file.mp4
```

**Example Output**:
```
Stream #0:0: Video: mpeg4, yuv420p, 720x304 [PAR 1:1 DAR 45:19], 23.98 tbr
Stream #0:1: Audio: ac3, 48000 Hz, 5.1, s16, 384 kb/s
Stream #0:2: Audio: ac3, 48000 Hz, 5.1, s16, 384 kb/s
```

#### Map Specific Streams
Copies the video stream and a specific audio stream to a new file.

```bash
ffmpeg -i file.mp4 -map 0:0 -map 0:2 -acodec copy -vcodec copy new_file.mp4
```

**Explanation**:
- `-map 0:0`: Selects the first video stream.
- `-map 0:2`: Selects the second audio stream.
- Copies streams without re-encoding.

## HandBrake CLI Commands

#### Convert Video with Preset
Converts a video using a HandBrake preset from a JSON file.

```bash
HandBrakeCLI.exe --preset-import-file "presets.json" -Z "pf" -i input.mkv -o output.mkv
```

**Explanation**:
- `--preset-import-file "presets.json"`: Imports a preset file.
- `-Z "pf"`: Applies the preset named "pf".
- `-i input.mkv -o output.mkv`: Specifies input and output files.
- Default preset file location: `C:\Users\SLVR\AppData\Roaming\HandBrake`.

## MakeMKV CLI Commands

#### List Disc Information
Displays information about a disc.

```bash
makemkvcon -r info disc:9999
```

**Explanation**:
- `-r`: Outputs raw information.
- `disc:9999`: Refers to the disc device (adjust as needed).

#### Create MKV from Disc
Rips all titles from a disc to MKV files in the specified output directory.

```bash
makemkvcon mkv disc:2 all E:\output
```

**Explanation**:
- `mkv`: Specifies MKV output format.
- `disc:2`: Targets the disc at index 2 (adjust as needed).
- `all`: Rips all titles.
- `E:\output`: Specifies the output directory.
- Default installation path: `C:\Program Files (x86)\MakeMKV`.

## Contributing
Feel free to contribute by adding new snippets, improving existing ones, or suggesting optimizations. Create a pull request or issue on the GitHub repository to share your updates.