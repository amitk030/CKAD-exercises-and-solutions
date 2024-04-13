#!/bin/bash

NAMESPACE="default"

POD_NAME="sumo"
EXPECTED_IMAGE="nginx"
EXPECTED_LABEL="tier=frontend"

if kubectl get pod -n "$NAMESPACE" "$POD_NAME" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
    ACTUAL_IMAGE=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.spec.containers[0].image}')
    if [ "$ACTUAL_IMAGE" != "$EXPECTED_IMAGE" ]; then
        echo "Error: Pod '$POD_NAME' has incorrect image. Expected: $EXPECTED_IMAGE, Actual: $ACTUAL_IMAGE."
        exit 1
    fi

    if kubectl get pod -n "$NAMESPACE" "$POD_NAME" --show-labels | grep -q "$EXPECTED_LABEL"; then
        echo "Pod '$POD_NAME' is labeled as '$EXPECTED_LABEL'."
        exit 0
    else
        echo "Error: Pod '$POD_NAME' does not have the expected label: $EXPECTED_LABEL."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
