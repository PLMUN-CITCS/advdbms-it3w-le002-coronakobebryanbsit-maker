#!/bin/bash

directory="university_db"
files=("create_and_use_db.sql" "create_students_table.sql" "alter_students_table.sql") # Array of filenames

if ! command -v sqlfluff &> /dev/null; then
  echo "Error: sqlfluff is not installed. Please install it (e.g., 'pip install sqlfluff')."
  exit 1
fi

for file in "${files[@]}"; do
  filepath="$directory/$file"
  if [ ! -f "$filepath" ]; then
    echo "Error: $filepath does not exist."
    exit 1
  fi

  echo "Checking syntax for $filepath..."

  output=$(sqlfluff lint "$filepath" --dialect mysql 2>&1)
  exit_code=$?

  if [ "$exit_code" -eq 0 ]; then
    echo "$filepath: Syntax OK"
  else
    echo "Error: Syntax errors found in $filepath:"
    echo "$output"
    exit 1
  fi
done

exit 0
