#!/bin/bash

NAMESPACE="distro"
POD_NAME="bbox"
EXPECTED_IMAGE="busybox"
EXPECTED_COMMAND='i=0; while true; do echo '$i: $(date)'; i=$((i+1)); sleep 1; done'

if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
    echo "Namespace '$NAMESPACE' does not exist."
    exit 1
fi

echo "Namespace '$NAMESPACE' exists."

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

echo "Container command matches the expected command."

echo "Pod '$POD_NAME' is correctly configured with the 'busybox' image and the expected command."
exit 0
