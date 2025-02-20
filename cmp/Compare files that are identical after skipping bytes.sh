function main() {
  # compare files verbosely, outputting first 10 differing bytes
  # after skipping the first 23 bytes in the first file and the first 0 bytes in the second file
  cmp -ln 10 -i 23:0 "$(pwd)/cmp/files/example 1" "$(pwd)/cmp/files/example 3"
  if [[ 0 -ne $? ]]; then echo "Expected files to be identical after skipping" && exit 255; fi
}

main
