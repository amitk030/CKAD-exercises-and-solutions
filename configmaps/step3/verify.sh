#!/bin/bash

NAMESPACE="default"
CONFIG_MAP_NAME="gconfig"
POD_NAME="aries"
EXPECTED_KEY="ability"
EXPECTED_VALUE="thunder"

if kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "ConfigMap '$CONFIG_MAP_NAME' exists in namespace '$NAMESPACE'."
    ACTUAL_VALUE=$(kubectl get configmap "$CONFIG_MAP_NAME" -n "$NAMESPACE" -o jsonpath="{.data.$EXPECTED_KEY}")

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Key '$EXPECTED_KEY' has the expected value '$EXPECTED_VALUE'."
        if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
            echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
            
            ACTUAL_ENV_KEY=$(kubectl get pod aries -o jsonpath="{.spec.containers[0].env[?(@.name=='power')].valueFrom.configMapKeyRef.key}")
            
            if [ "$ACTUAL_ENV_KEY" = "$EXPECTED_KEY" ]; then
                echo "Environment variable 'power' in pod '$POD_NAME' has the expected value '$EXPECTED_VALUE'."
                exit 0
            else
                echo "Error: Environment variable 'power' in pod '$POD_NAME' does not have the expected value."
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
