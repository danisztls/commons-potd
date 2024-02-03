#!/bin/bash

# title: commons-potd-transform
# description: downscale images and convert to AVIF while removing undesirables (GIF, low resolution) 
# author: Daniel Souza <daniel at posix.dev.br>
# license: MIT
# requires: https://sr.ht/~nytpu/commons-downloader/ 
# check: https://commons.wikimedia.org/wiki/Category:Pictures_of_the_day)

REPO_DIR="$PWD"
CUTOFF=1024

# 2K 16:9
ASPECT_RATIO=1.78
TARGET_WIDTH=2560
TARGET_HEIGHT=1440

_fmt_bold="\e[0;1m"
_fmt_red="\e[1;31m"
_fmt_clear="\e[0;0m"

findPics() {
  local query="$1"
  fd --ignore-case --unrestricted "$query" "$REPO_DIR"
}

convertPic() {
  local src="$1"
  local dst="${src%.*}.avif" 
  width=$(identify -format "%w" "$src")
  height=$(identify -format "%h" "$src")
  aspect_ratio=$(echo "$width/$height" | bc -l)

  # if the image resolution doesn't pass the cutoff value then just remove it
  if [ "$width" -lt $CUTOFF ] || [ "$height" -lt $CUTOFF ]; then
    rm "$src"
    return
  fi

  #  downscale based on height or width depending on the aspect ratio
  if (( $(echo "$aspect_ratio > $ASPECT_RATIO" | bc -l) )); then
    convert "$src" -resize "x${TARGET_HEIGHT}>" "$dst"
  else
    convert "$src" -resize "${TARGET_WIDTH}x>" "$dst"
  fi

  # remove source
  rm "$src"
}

convertPics() {
  mapfile -t pictures < <(findPics '^.*\.(jpg|jpeg|png|webp)$')
  for file in "${pictures[@]}"; do
    convertPic "$file"
  done
}

removeGifs() {
  mapfile -t gifs < <(findPics '^.*\.gif$')
  for file in "${gifs[@]}"; do
    rm "$file"
  done
}

# Main
printf "Working from directory: ${_fmt_bold}%s${_fmt_clear}\n\n" "$REPO_DIR"

printf "${_fmt_red}%s${_fmt_clear}\n\n${_fmt_bold}" "Warning! This will downscale, convert and delete all the images inside this directory."
read -p "Are you sure? (y/N) " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit
fi
echo -e "${_fmt_clear}\n"

convertPics
removeGifs
