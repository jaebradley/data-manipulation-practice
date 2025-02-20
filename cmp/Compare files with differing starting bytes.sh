function main() {
  # compare files verbosely, outputting first 10 differing bytes
  cmp -ln 10 "$(pwd)/cmp/files/example 1" "$(pwd)/cmp/files/example 3"
  if [[ 1 -ne $? ]]; then echo "Expected files to differ" && exit 255; fi
}

main
