#!/bin/bash

NAMESPACE="default"
SECRET_NAME="admindetails"

if kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Secret '$SECRET_NAME' exists in namespace '$NAMESPACE'."
    
    ACTUAL_VALUE=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.pass}" | base64 --decode)
    
    EXPECTED_VALUE="admin=password"
    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Key 'pass' has the expected value '$EXPECTED_VALUE'."
        exit 0
    else
        echo "Error: Key 'pass' does not have the expected value."
        exit 1
    fi
else
    echo "Error: Secret '$SECRET_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
