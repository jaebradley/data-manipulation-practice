#!/usr/bin/env bash

function main() {
  local temporary_directory
  temporary_directory=$(mktemp -d)
  if [[ 0 -ne $? ]];
  then echo "Failed to create a temporary directory" && exit 255;
  else echo "Created temporary directory: ${temporary_directory}";
  fi

  local content="Hello, world"
  local hashed_content
  hashed_content=$(md5 -q <<< "${content}")
  if [[ 0 -ne $? ]]; then echo "Failed to hash content" && exit 255; fi

  local temporary_filename="${temporary_directory}/${hashed_content}"

  echo -n "${content}" > "${temporary_filename}"

  local tarball_filename="${temporary_directory}/${hashed_content}.tar.gz"
  tar -czf "${tarball_filename}" "${temporary_filename}"
  if [[ 0 -ne $? ]]; then echo "Failed to combine content" && exit 255; fi

  echo "Created tarball: ${tarball_filename}"

  local extracted_files_directory
  extracted_files_directory=$(mktemp -d)
  if [[ 0 -ne $? ]];
  then echo "Failed to create a temporary directory" && exit 255;
  else echo "Created temporary directory for extracted files: ${extracted_files_directory}";
  fi

  echo "Extracting files to a specific directory"
  tar -xzvf "${tarball_filename}" -C "${extracted_files_directory}"
  if [[ 0 -ne $? ]]; then echo "Failed to extract files to directory: ${extracted_files_directory}" && exit 255; fi

  echo "Reading files in directory"
  find "${extracted_files_directory}" -type f -exec echo {} \; -exec cat {} \;
}

main

