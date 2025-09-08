#!/bin/bash

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-4000}"
DB_USER="${DB_USER:-root}"

SQL_DIR="university_db"

SQL_FILES=("create_and_use_db.sql" "create_students_table.sql" "alter_students_table.sql")

for sql_file in "${SQL_FILES[@]}"; do
  sql_filepath="$SQL_DIR/$sql_file"

  if [ ! -f "$sql_filepath" ]; then
    echo "Error: SQL file '$sql_filepath' not found."
    exit 1
  fi

  echo "Executing SQL script: $sql_filepath"

  output=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" < "$sql_filepath" 2>&1)
  exit_code=$?

  if [ "$exit_code" -eq 0 ]; then
    echo "SQL script '$sql_filepath' executed successfully."
    echo "Output:"
    echo "$output"
  else
    echo "Error: Failed to execute SQL script '$sql_filepath'."
    echo "Error Output:"
    echo "$output"
    exit 1
  fi
done

echo "Finished executing SQL scripts."

exit 0
