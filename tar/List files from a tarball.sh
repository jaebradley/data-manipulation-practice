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

  local tarball_filename="${temporary_directory}/${hashed_content}.tar"
  tar -cf "${tarball_filename}" "${temporary_filename}"

  echo "Created tarball: ${tarball_filename}"

  echo "Listing contents of archive"
  tar -tf "${tarball_filename}"
  if [[ 0 -ne $? ]];
  then echo "Could not list contents of archive: ${tarball_filename}" && exit 255
  fi

  echo "Verbosely listing contents of archive"
  tar -tvf "${tarball_filename}"
  if [[ 0 -ne $? ]];
  then echo "Could not verbosely list contents of archive: ${tarball_filename}" && exit 255
  fi
}

main

