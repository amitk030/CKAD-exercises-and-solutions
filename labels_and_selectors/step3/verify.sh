#!/bin/bash

NAMESPACE="default"
POD_NAMES=("one" "two" "three")
EXPECTED_LABEL="tier=backend"

check_pod_label() {
    local pod_name="$1"
    local expected_label="$2"

    if kubectl get pod -n "$NAMESPACE" "$pod_name" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$NAMESPACE'."

        if kubectl get pod -n "$NAMESPACE" "$pod_name" --show-labels | grep -q "$expected_label"; then
            echo "Pod '$pod_name' is labeled as '$expected_label'."
        else
            echo "Error: Pod '$pod_name' does not have the expected label: $expected_label."
            exit 1
        fi
    else
        echo "Error: Pod '$pod_name' does not exist in namespace '$NAMESPACE'."
        exit 1
    fi
}

for pod_name in "${POD_NAMES[@]}"; do
    check_pod_label "$pod_name" "$EXPECTED_LABEL"
done

echo "Verification successful: All pods labeled as '$EXPECTED_LABEL'."
