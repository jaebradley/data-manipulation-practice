#!/bin/env bash

while IFS=  read -r -d ''; do
  directory=$(dirname "$REPLY")
  expected=$(cat "${directory}/expected")
  input_file_path=$(cat "${directory}/input file path")
  output=$(awk -f "${directory}/program.awk" "${input_file_path}")
  if [[ 0 -ne $? ]]; then exit 255 && printf "awk failed"; fi
  if [[ "${expected}" != "${output}" ]]; then exit 255 && printf "Did not get expected value for ${directory}"; fi
done < <(find "$1" -type f -name "program.awk" -print0)
