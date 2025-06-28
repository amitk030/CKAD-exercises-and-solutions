#!/bin/bash

NAMESPACE="nano"
POD_NAME="worker"
CONTAINER_NAME="busybox"
ENV_FILE="busybox.txt"

# Check pod existence
if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

# Check env file existence
if [ ! -f "$ENV_FILE" ]; then
    echo "Environment file '$ENV_FILE' not found."
    exit 1
fi

echo "Environment file '$ENV_FILE' found."

# Get env from pod
if ! kubectl exec "$POD_NAME" -n "$NAMESPACE" -c "$CONTAINER_NAME" -- printenv > /tmp/busybox_env_from_pod.txt; then
    echo "Failed to retrieve environment variables from the busybox container."
    exit 1
fi

echo "Environment variables retrieved from busybox container."

# Normalize, filter, and sort for comparison
normalize_sort() {
    cat "$1" | tr -d '\r' | grep -v '^TERM=' | sed 's/[ \t]*$//' | grep -v '^$' | sort
}

normalize_sort "$ENV_FILE" > /tmp/busybox_env_sorted.txt
normalize_sort /tmp/busybox_env_from_pod.txt > /tmp/busybox_env_from_pod_sorted.txt

# Compare
if diff -q /tmp/busybox_env_sorted.txt /tmp/busybox_env_from_pod_sorted.txt >/dev/null; then
    echo "Environment variables match the contents of '$ENV_FILE'."
    exit 0
else
    echo "Environment variables do not match the contents of '$ENV_FILE'."
    diff /tmp/busybox_env_sorted.txt /tmp/busybox_env_from_pod_sorted.txt
    exit 1
fi
