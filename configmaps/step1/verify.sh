#!/bin/bash

NAMESPACE="default"
CONFIG_MAP_NAME="myconfig"
EXPECTED_KEY="var1"
EXPECTED_VALUE="val1"

if kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "ConfigMap '$CONFIG_MAP_NAME' exists in namespace '$NAMESPACE'."
    
    ACTUAL_VALUE=$(kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" -o jsonpath="{.data.$EXPECTED_KEY}")

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Key '$EXPECTED_KEY' has the expected value '$EXPECTED_VALUE'."
        exit 0
    else
        echo "Error: Key '$EXPECTED_KEY' does not have the expected value."
        exit 1
    fi
else
    echo "Error: ConfigMap '$CONFIG_MAP_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
