#!/bin/env bash

function main() {
  if [[ 1 -ne $# ]]; then exit 255 && printf "Expected exactly 1 argument, the script directory"; fi

  local -r script_directory="$1"
  if [[ ! -d "${script_directory}" ]]; then exit 255 && printf "${script_directory} is not a directory"; fi


while IFS=  read -r -d ''; do
  local -r directory=$(dirname "$REPLY")
  if [[ 0 -ne $? ]]; then exit 255 && printf "Unable to parse directory name for $REPLY"; fi

  local -r expected_output_file_path="${directory}/expected"
  if [[ ! -f "${expected_output_file_path}" ]]; then exit 255 && printf "Expected ${expected_output_file_path} to be a file"; fi
  if [[ ! -r "${expected_output_file_path}" ]]; then exit 255 && printf "Expected ${expected_output_file_path} to be readable"; fi

  local -r input_file_path_file_path="${directory}/input file path"
  if [[ ! -f "${input_file_path_file_path}" ]]; then exit 255 && printf "Expected ${input_file_path_file_path} to be a file"; fi
  if [[ ! -r "${input_file_path_file_path}" ]]; then exit 255 && printf "Expected ${input_file_path_file_path} to be readable"; fi

  
  local -r input_file_path=$(cat "${input_file_path_file_path}")
  if [[ 0 -ne $? ]]; then exit 255 && printf "Unable to output the input file path"; fi

  $(awk -f "${directory}/program.awk" "${input_file_path}" | cmp -s - "${expected_output_file_path}")
  if [[ 0 -ne $? ]]; then exit 255 && printf "awk failed"; fi

  printf "awk successfully executed for ${directory}"
done < <(find "${script_directory}" -type f -name "program.awk" -print0)
}

main "$@"

