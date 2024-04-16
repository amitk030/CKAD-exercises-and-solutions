#!/bin/bash

FILE_PATH="mypod-env.txt"

EXPECTED_ENV1="env1=value1"
EXPECTED_ENV2="env2=value2"

if [ -f "$FILE_PATH" ]; then
    echo "File '$FILE_PATH' exists."

    if grep -q "$EXPECTED_ENV1" "$FILE_PATH" && grep -q "$EXPECTED_ENV2" "$FILE_PATH"; then
        echo "File '$FILE_PATH' contains the expected environment variables '$EXPECTED_ENV1' and '$EXPECTED_ENV2'."
        exit 0
    else
        echo "Error: File '$FILE_PATH' does not contain the expected environment variables."
        exit 1
    fi
else
    echo "Error: File '$FILE_PATH' does not exist."
    exit 1
fi
