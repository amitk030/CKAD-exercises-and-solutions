#!/bin/bash

POD_NAME="vids"
EXPECTED_IMAGE="nginx"
EXPECTED_READINESS_COMMAND='ls'

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

READINESS_PROBE=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.exec.command}" | jq -r '. | join(" ")')

if [[ "$READINESS_PROBE" != *"$EXPECTED_READINESS_COMMAND"* ]]; then
    echo "Readiness probe does not contain the expected 'exec' command."
    echo "Expected command: '$EXPECTED_READINESS_COMMAND'"
    echo "Found command: '$READINESS_PROBE'"
    exit 1
fi

echo "Readiness probe contains the expected command: '$EXPECTED_READINESS_COMMAND'."

echo "Pod '$POD_NAME' has the correct container image and readiness probe."
exit 0
