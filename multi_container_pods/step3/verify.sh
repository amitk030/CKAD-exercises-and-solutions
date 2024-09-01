#!/bin/bash

NAMESPACE="nano"
POD_NAME="worker"
CONTAINER_NAME="busybox"
ENV_FILE="busybox.txt"

if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

if [ ! -f "$ENV_FILE" ]; then
    echo "Environment file '$ENV_FILE' not found."
    exit 1
fi

echo "Environment file '$ENV_FILE' found."

kubectl exec "$POD_NAME" -n "$NAMESPACE" -c "$CONTAINER_NAME" -- printenv > /tmp/busybox_env_from_pod.txt

if [ $? -ne 0 ]; then
    echo "Failed to retrieve environment variables from the busybox container."
    exit 1
fi

echo "Environment variables retrieved from busybox container."

if diff -q "$ENV_FILE" /tmp/busybox_env_from_pod.txt >/dev/null; then
    echo "Environment variables match the contents of '$ENV_FILE'."
    exit 0
else
    echo "Environment variables do not match the contents of '$ENV_FILE'."
    exit 1
fi
