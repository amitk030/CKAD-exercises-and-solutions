#!/bin/bash

NAMESPACE="default"
POD_NAME="bi"
EXPECTED_USER_ID="500"
EXPECTED_GROUP_ID="800"

EXPECTED_COMMAND="sleep 3600"

if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

    ACTUAL_USER_ID=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.securityContext.runAsUser}")
    ACTUAL_GROUP_ID=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.securityContext.runAsGroup}")

    if [ "$ACTUAL_USER_ID" = "$EXPECTED_USER_ID" ]; then
        echo "Security context user ID in pod '$POD_NAME' matches the expected user ID: '$EXPECTED_USER_ID'."

        if [ "$ACTUAL_GROUP_ID" = "$EXPECTED_GROUP_ID" ]; then
            echo "Security context group ID in pod '$POD_NAME' matches the expected group ID: '$EXPECTED_GROUP_ID'."

          kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].command[*]}' | grep -q "sleep 3600"
          if [ $? -eq 0 ]; then
              echo "Command sleep 3600 is found in pod '$POD_NAME'."
              exit 0
          else
              echo "Error: Command sleep 3600 is not found in pod '$POD_NAME'."
              exit 1
          fi
        else
            echo "Error: Security context group ID in pod '$POD_NAME' does not match the expected group ID."
            exit 1
        fi
    else
        echo "Error: Security context user ID in pod '$POD_NAME' does not match the expected user ID."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
