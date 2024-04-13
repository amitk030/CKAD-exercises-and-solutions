#!/bin/bash

NAMESPACE="cygnus"

POD_NAME="alpha"
EXPECTED_IMAGE="nginx"

if kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Namespace '$NAMESPACE' exists."
else
    echo "Namespace '$NAMESPACE' does not exist."
    exit 1
fi

if kubectl get pod -n "$NAMESPACE" "$POD_NAME" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
    
    ACTUAL_IMAGE=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.spec.containers[0].image}')

    if [ "$ACTUAL_IMAGE" == "$EXPECTED_IMAGE" ]; then
        echo "Pod '$POD_NAME' has the correct image: $EXPECTED_IMAGE."
    else
        echo "Error: Pod '$POD_NAME' has incorrect image. Expected: $EXPECTED_IMAGE, Actual: $ACTUAL_IMAGE."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

exit 0
