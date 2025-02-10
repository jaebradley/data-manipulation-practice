function main() {
  # compare files silently
  cmp -s "$(pwd)/cmp/files/example 1" "$(pwd)/cmp/files/example 3"
  if [[ 1 -ne $? ]]; then echo "Expected files to differ" && exit 255; fi

  cmp -s "$(pwd)/cmp/files/example 1" "$(pwd)/cmp/files/example 1"
  if [[ 0 -ne $? ]]; then echo "Expected files to not differ" && exit 255; fi
}

main
