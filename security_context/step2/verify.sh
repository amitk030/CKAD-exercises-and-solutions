#!/bin/bash

NAMESPACE="default"

POD_NAME="scorpion"
CONTAINER_NAME="scorpion-container"

EXPECTED_VALUE="false"

if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_VALUE=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$CONTAINER_NAME')].securityContext.allowPrivilegeEscalation}")

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "allowPrivilegeEscalation in pod '$POD_NAME' matches the expected value: '$EXPECTED_VALUE'."
        exit 0
    else
        echo "Error: allowPrivilegeEscalation in pod '$POD_NAME' does not match the expected value."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
