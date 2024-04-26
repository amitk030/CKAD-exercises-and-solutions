#!/bin/bash

NAMESPACE="default"
SECRET_NAME="dotfile-secret"
POD_NAME="keeper"
EXPECTED_VALUE="value"
EXPECTED_MOUNT_PATH="/etc/secret"

if kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Secret '$SECRET_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_VALUE=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.hidden}" | base64 -d)

    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then
        echo "Value in secret '$SECRET_NAME' matches the expected value: '$EXPECTED_VALUE'."

        if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
            echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

            MOUNTED=$(kubectl get pod keeper -o jsonpath="{.spec.containers[0].volumeMounts[?(@.name=='secret-vol')].mountPath}")

            if [ "$MOUNTED" = "$EXPECTED_MOUNT_PATH" ]; then
                echo "Secret '$SECRET_NAME' is mounted at the expected path '$EXPECTED_MOUNT_PATH' in pod '$POD_NAME'."
                exit 0
            else
                echo "Error: Secret '$SECRET_NAME' is not mounted at the expected path '$EXPECTED_MOUNT_PATH' in pod '$POD_NAME'."
                exit 1
            fi
        else
            echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
            exit 1
        fi
    else
        echo "Error: Value in secret '$SECRET_NAME' does not match the expected value: '$EXPECTED_VALUE'."
        exit 1
    fi
else
    echo "Error: Secret '$SECRET_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
