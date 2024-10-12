#!/bin/bash
# Loop through all files that end with .webp in the current directory
for file in *.webp; do
    # Extract the file name without extension
    base_name="${file%.webp}"
    # Convert the .webp file to .png using ImageMagick
    magick "$file" "${base_name}.png"
    echo "Converted $file to ${base_name}.png"
    rm "$file"
done

