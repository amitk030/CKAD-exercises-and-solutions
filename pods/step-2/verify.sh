#!/bin/bash

NAMESPACE="default"
POD_NAME="beta"
EXPECTED_IMAGE="nginx"

if kubectl get pod -n "$NAMESPACE" "$POD_NAME" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
    
    ACTUAL_IMAGE=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.spec.containers[0].image}')
    if [ "$ACTUAL_IMAGE" != "$EXPECTED_IMAGE" ]; then
        echo "Error: Pod '$POD_NAME' has incorrect image. Expected: $EXPECTED_IMAGE, Actual: $ACTUAL_IMAGE."
        exit 1
    fi
    
    if [ -f "beta-env.txt" ]; then
        echo "File 'beta-env.txt' exists."
        if [ -s "beta-env.txt" ]; then
            echo "File 'beta-env.txt' contains environment variables."

            POD_ENV=$(kubectl exec -n "$NAMESPACE" "$POD_NAME" -- env)
            while IFS= read -r env_var; do
                if ! grep -q "$env_var" "beta-env.txt"; then
                    echo "Error: Environment variable '$env_var' not found in file 'beta-env.txt'."
                    exit 1
                fi
            done <<< "$POD_ENV"
            echo "Verification successful: Environment variables match between pod and file."
            exit 0
        else
            echo "Error: File 'beta-env.txt' is empty."
            exit 1
        fi
    else
        echo "Error: File 'beta-env.txt' does not exist."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
