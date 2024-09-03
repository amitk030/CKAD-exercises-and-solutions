#!/bin/bash

POD_NAME="baldr"
EXPECTED_IMAGE="busybox"
EXPECTED_COMMAND="sleep 3600"
EXPECTED_LIVENESS_COMMAND="env"
EXPECTED_INITIAL_DELAY_SECONDS=5

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
    echo "Container command does not match the expected command '$EXPECTED_COMMAND'. Found: '$CONTAINER_COMMAND'."
    exit 1
fi

echo "Container command is '$EXPECTED_COMMAND', as expected."

LIVENESS_COMMAND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].livenessProbe.exec.command}" | jq -r '. | join(" ")')
LIVENESS_INITIAL_DELAY=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].livenessProbe.initialDelaySeconds}")

if [[ "$LIVENESS_COMMAND" != "$EXPECTED_LIVENESS_COMMAND" ]]; then
    echo "Liveness probe command does not match the expected command '$EXPECTED_LIVENESS_COMMAND'. Found: '$LIVENESS_COMMAND'."
    exit 1
fi

if [[ "$LIVENESS_INITIAL_DELAY" -ne "$EXPECTED_INITIAL_DELAY_SECONDS" ]]; then
    echo "Liveness probe initial delay does not match the expected delay of '$EXPECTED_INITIAL_DELAY_SECONDS' seconds. Found: '$LIVENESS_INITIAL_DELAY' seconds."
    exit 1
fi

echo "Liveness probe is correctly configured with the command '$EXPECTED_LIVENESS_COMMAND' and an initial delay of '$EXPECTED_INITIAL_DELAY_SECONDS' seconds."

echo "Pod '$POD_NAME' is correctly configured with the busybox image, the 'sleep 3600' command, and a liveness probe executing 'env' after 5 seconds."
exit 0
