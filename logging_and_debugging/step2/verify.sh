#!/bin/bash

POD_NAME="bitto"
EXPECTED_IMAGE="busybox"
EXPECTED_COMMAND="ls /here"
FILE_PATH="issue.txt"
EXPECTED_CONTENT="ls: /here: No such file or directory"

if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

CONTAINER_IMAGE=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].image}")
if [[ "$CONTAINER_IMAGE" != "$EXPECTED_IMAGE" ]]; then
    echo "Container image does not match the expected image '$EXPECTED_IMAGE'. Found: '$CONTAINER_IMAGE'."
    exit 1
fi

echo "Container image is '$EXPECTED_IMAGE', as expected."

CONTAINER_COMMAND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].command}" | jq -r '. | join(" ")')

if [[ "$CONTAINER_COMMAND" != *"$EXPECTED_COMMAND"* ]]; then
    echo "Container command does not match the expected command."
    echo "Expected command: '$EXPECTED_COMMAND'"
    echo "Found command: '$CONTAINER_COMMAND'"
    exit 1
fi

if [[ ! -f "$FILE_PATH" ]]; then
    echo "File '$FILE_PATH' does not exist."
    exit 1
fi

if grep -Fxq "$EXPECTED_CONTENT" "$FILE_PATH"; then
    echo "File '$FILE_PATH' contains the expected content."
    exit 0
else
    echo "File '$FILE_PATH' does not contain the expected content."
    exit 1
fi

