#!/bin/bash

NAMESPACE="default"

check_pod_label() {
    local pod_selector="$1"
    local expected_label="$2"

    if kubectl get pod -n "$NAMESPACE" -l "$pod_selector" &> /dev/null; then
        echo "Pods with selector '$pod_selector' exist in namespace '$NAMESPACE'."

        if kubectl get pod -n "$NAMESPACE" -l "$pod_selector" --show-labels | grep -q "$expected_label"; then
            echo "Pods with selector '$pod_selector' are labeled as '$expected_label'."
        else
            echo "Error: Pods with selector '$pod_selector' do not have the expected label: $expected_label."
            exit 1
        fi
    else
        echo "Error: Pods with selector '$pod_selector' do not exist in namespace '$NAMESPACE'."
        exit 1
    fi
}

check_pod_label "tier=frontend" "app_version=v1"
check_pod_label "tier=backend" "app_version=v1"

echo "Verification successful: Pods labeled as 'app_version=v1'."
