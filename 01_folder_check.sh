#!/bin/bash

directory="university_db"

if [ -d "$directory" ]; then
  echo "Folder '$directory' exists."
  exit 0
else
  echo "Error: Folder '$directory' does not exist."
  exit 1
fi
