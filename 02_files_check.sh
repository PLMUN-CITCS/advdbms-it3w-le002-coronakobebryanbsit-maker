#!/bin/bash

directory="university_db"
files=("create_and_use_db.sql" "create_students_table.sql" "alter_students_table.sql") # Array of filenames

for file in "${files[@]}"; do
  filepath="$directory/$file"
  if [ -f "$filepath" ]; then
    echo "$filepath exists"
  else
    echo "Error: $filepath does not exist"
    exit 1
  fi
done

exit 0
