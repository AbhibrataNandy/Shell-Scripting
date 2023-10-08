#!/bin/bash

username=$(whoami)
movies_dir=$(find /home/"$username" -type d -name "Movies" -print -quit)

if [ -z "$movies_dir" ]; then
  echo "No 'Movies' folder found in your home directory."
  exit 1
fi

cd "$movies_dir" || exit 1

let i=1
for file in *; do
  base_name=$(basename "$file")
  echo "$i. $base_name"
  i=$((i+1))
done

echo "Enter the name of the movie you want to play:"
read name
cd "$name" || exit 1
echo "Current directory: $(pwd)"
echo "Files in this directory:"
echo "$(ls)"

for file in *; do
  file_extension="${file##*.}"
  if [[ "$file_extension" == "mp4" || "$file_extension" == "mkv" ]]; then
    xdg-open "$file"
    break
  fi
done

exit 0
