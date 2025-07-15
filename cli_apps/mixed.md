# System Administration and Media Processing Snippets

This document is a comprehensive collection of commands and snippets for system administration, media processing, and network tasks. It includes tools like NoMachine, Tesseract, ddrescue, Instaloader, ImageMagick, Exiftool, scrcpy, wget, JDownloader, iperf3, NVIDIA utilities, and more. Each section is organized with clear explanations, code blocks, headers, and comments for readability on GitHub.

## Table of Contents
- [NoMachine](#nomachine)
- [Tesseract OCR](#tesseract-ocr)
- [ddrescue](#ddrescue)
- [Instaloader](#instaloader)
- [Mp3tag](#mp3tag)
- [ImageMagick and Ghostscript](#imagemagick-and-ghostscript)
- [Exiftool](#exiftool)
- [scrcpy](#scrcpy)
- [wget](#wget)
- [JDownloader Headless](#jdownloader-headless)
- [iperf3](#iperf3)
- [NVIDIA Utilities](#nvidia-utilities)
- [Bulk Image Downloader](#bulk-image-downloader)
- [Windows Commands](#windows-commands)
- [Miscellaneous](#miscellaneous)
- [Contributing](#contributing)

## NoMachine

Installs and configures NoMachine for remote desktop access on a Linux system.

```bash
# Install EPEL repository and XRDP
sudo dnf install epel-release -y
sudo dnf install xrdp -y

# Enable and start XRDP service
sudo systemctl enable --now xrdp

# Open port 3389 for XRDP
sudo firewall-cmd --add-port=3389/tcp --permanent
sudo firewall-cmd --reload

# Download and install NoMachine
cd /tmp
wget https://download.nomachine.com/download/9.0/Linux/nomachine_9.0.188_11_x86_64.rpm
sudo dnf install nomachine_9.0.188_11_x86_64.rpm -y

# Check NoMachine server status
sudo systemctl status nxserver
```

**Explanation**:
- Installs `epel-release` and `xrdp` for remote desktop support.
- Enables XRDP and opens port 3389 for connections.
- Downloads and installs NoMachine version 9.0.188 for x86_64.
- Verifies the NoMachine server is running.

## Tesseract OCR

Performs optical character recognition (OCR) on images to extract text.

```bash
# Basic OCR for English
tesseract input.jpg out.txt

# OCR for Sinhala language
tesseract input.jpg output -l sin

# Bulk OCR for all images listed in a text file
tesseract input.txt fullout -l sin

# List available languages
tesseract --list-langs
```

**Explanation**:
- `-l sin`: Specifies Sinhala language for OCR.
- `input.txt`: A text file listing image paths for bulk processing (e.g., generated via `dir /s *.jpg > input.txt` on Windows).
- `fullout`: Output file prefix for bulk OCR results.

## ddrescue

Recovers data from damaged disks or devices.

```bash
# Recover data from a disk with retry and logging
ddrescue -v -d -f -r 3 -c 32 -b 4096 /dev/sdc1 /media/sda1/photos/recovered.img /media/sda1/logfile

# Recover CD/DVD to ISO (initial pass)
ddrescue -b 2048 -n -v /dev/cdrom dvd.iso rescue.log

# Recover CD/DVD with retries
ddrescue -b 2048 -d -r 3 -v /dev/cdrom dvd.iso rescue.log

# Recover CD/DVD with specific settings
ddrescue -v -d -r 3 -c 32 -b 2048 /dev/cdrom dvd.iso rescue.log
```

**Explanation**:
- `-v`: Verbose output.
- `-d`: Direct disk access.
- `-f`: Force overwrite.
- `-r 3`: Retry 3 times.
- `-c 32`: Cluster size (32 sectors).
- `-b 2048` or `-b 4096`: Block size in bytes.
- Logs progress to `rescue.log` or `logfile` for resuming.

## Instaloader

Downloads Instagram content, such as saved posts or profiles.

```bash
# Login and save session
instaloader --login=sam_fisher

# Download saved posts
instaloader --login=sam_fisher :saved --no-video-thumbnails --no-metadata-json --no-compress-json

# Download a single post by shortcode
instaloader -- -CO-LoHfnO01 --no-metadata-json --no-compress-json

# Download saved posts within a date range
instaloader --login=sam ":saved" \
  --no-video-thumbnails \
  --no-compress-json \
  --no-metadata-json \
  --post-filter="datetime(2024, 1, 1) <= date <= datetime(2024, 12, 31)"

# Download all pictures and videos from a profile
instaloader sam_fisher
```

**Explanation**:
- Session saved to: `C:\Users\SLVR\AppData\Local\Instaloader\session-sam_fisher`.
- `--no-video-thumbnails`, `--no-metadata-json`, `--no-compress-json`: Optimize output by excluding unnecessary files.
- `--post-filter`: Filters posts by date range.
- Use `--load-cookies BROWSER-NAME` for cookie-based login.

**Troubleshooting**:
- Remove session file (`session-sam_fisher`) if login errors occur.

## Mp3tag

Manages audio metadata.

```bash
# Remove specific metadata pattern (e.g., "(2014 Remaster)")
\s*\(2014 Remaster\)$
```

**Explanation**:
- Uses regex in Mp3tag to remove trailing text like `(2014 Remaster)` from metadata fields.

## ImageMagick and Ghostscript

Processes images and PDFs in bulk.

```bash
# Combine images vertically into a single strip
magick *.png -append "C:\Users\Ezio\Desktop\rol\new.png"

# Convert and trim images to GIF
magick mogrify -path C:\Users\Ezio\Desktop\out_put -format gif -fuzz 50% -trim +repage *

# Convert PNGs to JPG in a subfolder
magick mogrify -format jpg "D:\images\name of subfolder\*.png"

# Convert WebP to BMP
magick mogrify -format bmp "C:\Users\Ezio\Desktop\output\*.webp"

# Convert PDFs to PNG (remove transparency)
magick convert -flatten cme02.pdf a.png
magick convert -density 300 -flatten cme02.pdf a.png
magick mogrify -verbose -density 96 -flatten -format png ./*.pdf

# Flip images vertically or horizontally
magick mogrify -flip *.jpg
magick mogrify -flop *.jpg
```

**Explanation**:
- `-append`: Stacks images vertically.
- `-fuzz 50% -trim +repage`: Trims images with 50% fuzz factor and resets canvas.
- `-density 300`: Sets resolution for PDF conversion.
- `-flatten`: Removes transparency in PDFs.
- `-flip` and `-flop`: Flip images vertically or horizontally.

## Exiftool

Manages metadata in media files.

```bash
# Display all metadata for a file
exiftool -a -u -g1 input.ogg

# Remove all metadata except date tags
exiftool -all= -tagsFromFile @ -*date* *.jpg

# Rotate a video
exiftool -Rotation=180 C:\exiftool\input.mp4
```

**Rotation Values**:
- `0`: 90° counterclockwise and vertical flip (default, EXIF).
- `1`: 90° clockwise (common for mobile videos).
- `2`: 90° counterclockwise.
- `3`: 90° clockwise and vertical flip.

## scrcpy

Mirrors and controls Android devices.

```bash
# Enable TCP/IP debugging
adb tcpip 5555

# Mirror device via USB
scrcpy

# Mirror device wirelessly
adb connect 192.168.1.2:5555
scrcpy --tcpip=192.168.1.2

# List installed packages
adb.exe shell pm list packages

# Shortcuts
# Wake device: Alt+m
# Toggle screen (power): Alt+p
```

**Explanation**:
- Requires Developer Options and USB Debugging enabled on the Android device.
- Wireless mirroring requires the device’s IP address.

## wget

Downloads files and websites.

```bash
# Download with authentication
wget --user=admin --password=admin "https://example.com"

# Backup a website
wget --limit-rate=200k --no-clobber --convert-links --random-wait -r -p -E -e robots=off -U chrome https://abc.com/

# Download a single page
wget -E -H -k -K -p https://abc.com/

# Download with specific settings
wget -m -k -K -E -l 7 -t 6 -w 5 http://www.website.com

# Download from Google Drive
wget "https://x.dogemirrorbot.workers.dev/0:/Home.Alone.2.Lost.in.New.York.1992.2160p.DSNP.WEB-DL.x265.10bit.HDR.DTS-HD.MA.5.1-SWTYBLZ.zip"
```

**Explanation**:
- `--no-clobber`: Prevents overwriting existing files.
- `--convert-links`: Makes links relative for offline viewing.
- `-e robots=off`: Ignores robots.txt restrictions.
- `-l 7`: Limits recursion depth.
- `-t 6`: Retries up to 6 times.
- `-w 5`: Waits 5 seconds between requests.

## JDownloader Headless

Installs and manages JDownloader on a headless system.

```bash
# Create directory and download JDownloader
mkdir /path/JDownloader
cd /path/JDownloader
wget https://installer.jdownloader.org/JDownloader.jar

# Start installation (headless)
java -Djava.awt.headless=true -jar JDownloader.jar -norestart

# Start JDownloader
java -jar JDownloader.jar

# Check logs
sudo journalctl -u jdownloader.service

# Systemd service configuration
cat /etc/systemd/system/jdownloader.service
[Unit]
Description=JDownloader
Wants=network.target
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/java -jar /home/sam/jd/JDownloader.jar
PIDFile=/home/sam/bin/jdownloader/JDownloader.pid
User=sam
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

# Enable and restart service
sudo systemctl daemon-reload
sudo systemctl enable jdownloader.service
sudo systemctl restart jdownloader.service
```

**YouTube Filename Customization**:
- **Default**: `*3D* *360* *VIDEO_NAME* (*H*p_*FPS*fps_*VIDEO_CODEC*-*AUDIO_BITRATE*kbit_*AUDIO_CODEC*).*EXT*`
- **Custom**: `*VIDEO_NAME*.*EXT*` (removes codec information).

## iperf3

Tests network performance.

```bash
# Start server
iperf3 -s

# Start client
iperf3 -c server_ip

# Test for 30 seconds
iperf3 -c server_ip -t 30

# Test with custom packet size and verbose output
iperf3 -c server_ip -t 5 -b 30M -V

# Test with UDP
iperf3 -c server_ip -t 15 -b 30M -V -u port

# Test with public server
iperf3 -c iperf.biznetnetworks.com -p 5201
```

**Explanation**:
- `-s`: Runs iperf3 as a server.
- `-c server_ip`: Connects to the specified server.
- `-t 30`: Runs test for 30 станеseconds.
- `-b 30M`: Limits bandwidth to 30 Mbps.
- `-u`: Uses UDP instead of TCP.

## NVIDIA Utilities

Monitors and manages NVIDIA GPU usage.

```bash
# Display GPU status
nvidia-smi

# Query running processes
nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv

# List PIDs using GPU
nvidia-smi --query-compute-apps=pid --format=csv,noheader

# Install and run nvitop
pip3 install --upgrade nvitop
nvitop -m

# Kill process on Windows
taskkill /F /PID pid_number
```

**Explanation**:
- `nvidia-smi`: Shows GPU utilization and processes.
- `nvitop`: Provides an interactive GPU monitoring tool.

## Bulk Image Downloader

Configures BID Queue Manager for downloading images.

**Settings**:
- **Options > Filter > Embedded Images Only**
- **Advanced Configuration (Ignore)**:
  - `<pixhost.to/show/*._cover.jpg>`
  - `<t99.pixhost.to>`
  - `<apc.to>`

## Windows Commands

Manages file permissions and media playback.

```bash
# Take ownership of a directory
cd H:\BURN.MKE\Youtube
takeown /f H:\BURN.MKE\Youtube /r /d y
icacls H:\BURN.MKE\Youtube /grant user:F /t /q

# Play media with Windows Media Player
%ProgramFiles(x86)%\Windows Media Player\wmplayer.exe /play "C:\Program Files\VideoLAN\VLC\test.mp3"
```

**Explanation**:
- `takeown`: Grants ownership of files/folders.
- `icacls`: Sets full control permissions for a user.

## Miscellaneous

### FFmpeg
```bash
# Copy streams from a manifest file
ffmpeg -i "videomanifest" -codec copy out.mp4
```

### Cygwin
```bash
# Open Cygwin terminal
cmd /k "C:\cygwin64\Cygwin.bat"
```

### Wine
```bash
# Configure Wine settings
winecfg
```

### CloudShell (Google Cloud)
```bash
# Run Ubuntu desktop with VNC
docker run -p 6070:80 dorowu/ubuntu-desktop-lxde-vnc
```

### MegaBasterd
```bash
# Install MegaBasterd on Linux
sudo apt-get install wget unzip
wget https://github.com/tonikelope/megabasterd/releases/download/v7.49/MegaBasterdLINUX_7.49_portable.zip
unzip MegaBasterdLINUX_7.49_portable.zip
```

### Other Tools
- **File Sync/Transfer**: `rclone`, `aria2c`
- **Media Metadata**: `AtomicParsley`
- **Image Processing**: `imagemagick`
- **YouTube Downloader**: `ytd`
- **Speed Test**: `https://github.com/librespeed/speedtest`
- **File Creation**:
  ```bash
  # Create directories s01e1 to s01e5
  mkdir s01e{1..5}

  # Create files datafile1 to datafile10
  touch datafile{1..10}
  ```

## Contributing
Contributions are welcome! Add new snippets, improve existing ones, or suggest optimizations via pull requests or issues on the GitHub repository.