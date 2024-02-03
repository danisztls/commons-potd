#!/usr/bin/env bash

# title: commons-potd-extract
# description: download Commons pictures of the day from 2004 to present
# author: Daniel Souza <daniel at posix.dev.br>
# license: MIT
# requires: https://sr.ht/~nytpu/commons-downloader/ 
# check: https://commons.wikimedia.org/wiki/Category:Pictures_of_the_day)

repo_dir="$PWD"
initial_year=2004
current_year=$(date +"%Y")

_fmt_bold="\e[0;1m"
_fmt_red="\e[1;31m"
_fmt_clear="\e[0;0m"

for year in $(seq "$initial_year" "$current_year"); do
  printf "${_fmt_bold}[%s]${_fmt_clear}\n" "$year"
  work_dir="${repo_dir}/${year}" 
  category="Pictures_of_the_day_(${year})"
  mkdir -p "$work_dir"
  cd "$work_dir" || exit 1
  commons-downloader -c "$category"
done
