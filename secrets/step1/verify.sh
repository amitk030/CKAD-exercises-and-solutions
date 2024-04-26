#!/bin/bash

NAMESPACE="default"
SECRET_NAME="mysecret"
EXPECTED_KEY="mypass"
EXPECTED_VALUE="verysecret"

if kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Secret '$SECRET_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_VALUE=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.$EXPECTED_KEY}" | base64 --decode)

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Key '$EXPECTED_KEY' has the expected value '$EXPECTED_VALUE'."
        exit 0
    else
        echo "Error: Key '$EXPECTED_KEY' does not have the expected value."
        exit 1
    fi
else
    echo "Error: Secret '$SECRET_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
