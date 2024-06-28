#!/bin/zsh

# Loop through all .cbr and .cbz files in the directory
for file in *.cbr *.cbz; do
  # Check if the file matches the more complex pattern
  if [[ $file =~ ^([0-9]{4})([0-9]{2})\ (.+?)\ (v[0-9]{1,2})\ ([0-9]{3})\.(cbr|cbz)$ ]]; then
    year="${BASH_REMATCH[1]}"
    month="${BASH_REMATCH[2]}"
    series="${BASH_REMATCH[3]}"
    volume="${BASH_REMATCH[4]}"
    issue="${BASH_REMATCH[5]}"
    extension="${BASH_REMATCH[6]}"

    # Construct the new file name for complex pattern
    new_filename="${series} ${year}-${month} ${volume} ${issue}.${extension}"

    # Rename the file
    mv "$file" "$new_filename"
    echo "Renamed: $file -> $new_filename"

  # Check if the file matches the simpler pattern without volume and issue number
  elif [[ $file =~ ^([0-9]{4})([0-9]{2})\ (.+?)\.(cbr|cbz)$ ]]; then
    year="${BASH_REMATCH[1]}"
    month="${BASH_REMATCH[2]}"
    series="${BASH_REMATCH[3]}"
    extension="${BASH_REMATCH[4]}"

    # Construct the new file name for simpler pattern
    new_filename="${series} ${year}-${month}.${extension}"

    # Rename the file
    mv "$file" "$new_filename"
    echo "Renamed: $file -> $new_filename"

  else
    echo "File did not match pattern: $file"
  fi
done
