#!/bin/bash

# Function to check if the pod exists
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

# Function to verify the pod's resource requests
verify_pod_resources() {
    local namespace="$1"
    local pod_name="$2"
    local expected_cpu="$3"
    local expected_memory="$4"

    # Get the pod details
    pod=$(kubectl get pod "$pod_name" -n "$namespace" -o json)

    # Extract the resource requests
    actual_cpu=$(echo "$pod" | jq -r '.spec.containers[0].resources.requests.cpu')
    actual_memory=$(echo "$pod" | jq -r '.spec.containers[0].resources.requests.memory')

    # Compare the actual and expected resource requests
    if [[ "$actual_cpu" == "$expected_cpu" && "$actual_memory" == "$expected_memory" ]]; then
        echo "Pod '$pod_name' in namespace '$namespace' has the correct resource requests."
    else
        echo "Pod '$pod_name' in namespace '$namespace' does not have the correct resource requests."
        echo "Expected: cpu=$expected_cpu, memory=$expected_memory"
        echo "Found: cpu=$actual_cpu, memory=$actual_memory"
        exit 1
    fi
}

# Function to check pod status
verify_pod_creation_failure() {
    local namespace="$1"
    local pod_name="$2"

    # Get the pod status
    status=$(kubectl get pod "$pod_name" -n "$namespace" -o json | jq -r '.status.phase')

    # Check if the pod failed to be created
    if [[ "$status" == "Pending" || "$status" == "Failed" ]]; then
        echo "Pod '$pod_name' in namespace '$namespace' failed to start as expected."
    else
        echo "Pod '$pod_name' in namespace '$namespace' is running, but it was expected to fail."
        exit 1
    fi
}

# Main verification process
NAMESPACE="demo"
POD_NAME="server"
EXPECTED_CPU="1"
EXPECTED_MEMORY="1Gi"

# Verify the existence of the pod
verify_pod_existence "$NAMESPACE" "$POD_NAME"

# Verify the pod's resource requests
verify_pod_resources "$NAMESPACE" "$POD_NAME" "$EXPECTED_CPU" "$EXPECTED_MEMORY"

# Verify that the pod creation failed
verify_pod_creation_failure "$NAMESPACE" "$POD_NAME"
