#!/bin/bash

NAMESPACE="default"

POD_NAME="proc"
CONTAINER_NAME="proc-container"

EXPECTED_CAPABILITIES=("NET_ADMIN" "SYS_TIME")

if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_CAPABILITIES=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$CONTAINER_NAME')].securityContext.capabilities.add}")

    for capability in "${EXPECTED_CAPABILITIES[@]}"; do
        if [[ "$ACTUAL_CAPABILITIES" == *"$capability"* ]]; then
            echo "Capability '$capability' is enabled in pod '$POD_NAME'."
        else
            echo "Error: Capability '$capability' is not enabled in pod '$POD_NAME'."
            exit 1
        fi
    done

    exit 0
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
