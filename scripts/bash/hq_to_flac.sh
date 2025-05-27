#!/bin/bash

mkdir -p converted

for file in *.m4a; do
    filename="${file%.*}"
    ffmpeg -i "$file" -ar 48000 -sample_fmt s16 -compression_level 5 -map_metadata 0 "converted/${filename}.flac"
done

echo "All files converted to FLAC in ./converted"



#nano convert.sh
#chmod +x convert.sh
#sudo ./convert.sh
