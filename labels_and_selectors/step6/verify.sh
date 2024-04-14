#!/bin/bash

NAMESPACE="default"
POD_NAME="one"
UNEXPECTED_LABEL="app_version=v1"

check_pod_label() {
    local pod_name="$1"
    local unexpected_label="$2"

    if kubectl get pod -n "$NAMESPACE" "$pod_name" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$NAMESPACE'."
        if ! kubectl get pod -n "$NAMESPACE" "$pod_name" --show-labels | grep -q "$unexpected_label"; then
            echo "Pod '$pod_name' does not have the unexpected label: $unexpected_label."
            exit 0
        else
            echo "Error: Pod '$pod_name' has the unexpected label: $unexpected_label."
            exit 1
        fi
    else
        echo "Error: Pod '$pod_name' does not exist in namespace '$NAMESPACE'."
        exit 1
    fi
}

check_pod_label "$POD_NAME" "$UNEXPECTED_LABEL"
