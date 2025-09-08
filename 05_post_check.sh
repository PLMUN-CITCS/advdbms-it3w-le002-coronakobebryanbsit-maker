#!/bin/bash

EXPECTED_STRUCTURE=$(cat output/table_structure.txt)

actual_structure=$(mysql -h 127.0.0.1 -P 4000 -u root UniversityDB -e "DESCRIBE Students;" 2>&1 | tail -n +2 | awk '{print "    "$1" "$2" "$3" "$4" "$5" "$6";"}')

expected_formatted=$(echo "$EXPECTED_STRUCTURE" | sed 's/^[ \t]*//; s/[ \t]*$//; s/[ \t][ \t]*/ /g')

actual_formatted=$(echo "$actual_structure" | sed 's/^[ \t]*//; s/[ \t]*$//; s/[ \t][ \t]*/ /g')

if [[ "$expected_formatted" == "$actual_formatted" ]]; then
  echo "Table structure is correct."
else
  echo "Table structure is INCORRECT."
  echo "Expected:"
  echo "$expected_formatted"
  echo "Actual:"
  echo "$actual_formatted"
  diff <(echo "$expected_formatted") <(echo "$actual_formatted")
  exit 1
fi

exit 0
