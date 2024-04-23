#!/bin/bash

NAMESPACE="taurus"
CONFIG_MAP_NAME="tconfig"
POD_NAME="tarz"

EXPECTED_KEY="var9"
EXPECTED_VALUE="val9"

if kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "ConfigMap '$CONFIG_MAP_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_VALUE=$(kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" -o jsonpath="{.data.$EXPECTED_KEY}")

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Key '$EXPECTED_KEY' has the expected value '$EXPECTED_VALUE'."

        if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
            echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
            
            if kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.volumes[*].name}' | grep -q "core"; then
                echo "Pod '$POD_NAME' has the volume 'core' mounted."
                exit 0
            else
                echo "Error: Pod '$POD_NAME' does not have the volume 'core' mounted."
                exit 1
            fi
        else
            echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
            exit 1
        fi
    else
        echo "Error: Key '$EXPECTED_KEY' does not have the expected value."
        exit 1
    fi
else
    echo "Error: ConfigMap '$CONFIG_MAP_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
