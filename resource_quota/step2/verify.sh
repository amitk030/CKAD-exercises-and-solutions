#!/bin/bash

verify_pod_existence() {
    local namespace="$1"
    local pod_name="$2"

    if kubectl get pod "$pod_name" -n "$namespace" > /dev/null 2>&1; then
        echo "Pod '$pod_name' exists in namespace '$namespace'."
    else
        echo "Pod '$pod_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

verify_pod_resources() {
    local namespace="$1"
    local pod_name="$2"
    local expected_cpu="$3"
    local expected_memory="$4"

    pod=$(kubectl get pod "$pod_name" -n "$namespace" -o json)

    actual_cpu=$(echo "$pod" | jq -r '.spec.containers[0].resources.requests.cpu')
    actual_memory=$(echo "$pod" | jq -r '.spec.containers[0].resources.requests.memory')

    if [[ "$actual_cpu" == "$expected_cpu" && "$actual_memory" == "$expected_memory" ]]; then
        echo "Pod '$pod_name' in namespace '$namespace' has the correct resource requests."
    else
        echo "Pod '$pod_name' in namespace '$namespace' does not have the correct resource requests."
        echo "Expected: cpu=$expected_cpu, memory=$expected_memory"
        echo "Found: cpu=$actual_cpu, memory=$actual_memory"
        exit 1
    fi
}

verify_pod_creation() {
    local namespace="$1"
    local pod_name="$2"

    status=$(kubectl get pod "$pod_name" -n "$namespace" -o json | jq -r '.status.phase')

    if [[ "$status" == "Running" ]]; then
        echo "Pod '$pod_name' in namespace '$namespace' is running as expected."
    else
        echo "Pod '$pod_name' in namespace '$namespace' is failed."
        exit 1
    fi
}

NAMESPACE="demo"
POD_NAME="server"
EXPECTED_CPU="500m"
EXPECTED_MEMORY="1Gi"

verify_pod_existence "$NAMESPACE" "$POD_NAME"
verify_pod_resources "$NAMESPACE" "$POD_NAME" "$EXPECTED_CPU" "$EXPECTED_MEMORY"
verify_pod_creation "$NAMESPACE" "$POD_NAME"
