#!/bin/bash

NAMESPACE="default"
RS_NAME="rs1"
EXPECTED_REPLICAS=3

EXPECTED_IMAGE="nginx"
EXPECTED_LABEL="tier=frontend"

check_replicaset() {
    local rs_name="$1"
    local expected_replicas="$2"

    if kubectl get replicaset -n "$NAMESPACE" "$rs_name" &> /dev/null; then
        echo "ReplicaSet '$rs_name' exists in namespace '$NAMESPACE'."

        local actual_replicas=$(kubectl get replicaset -n "$NAMESPACE" "$rs_name" -o jsonpath='{.status.replicas}')
        if [ "$actual_replicas" -eq "$expected_replicas" ]; then
            echo "ReplicaSet '$rs_name' has the expected number of replicas: $expected_replicas."
            exit 0
        else
            echo "Error: ReplicaSet '$rs_name' does not have the expected number of replicas. Expected: $expected_replicas, Actual: $actual_replicas."
            exit 1
        fi
    else
        echo "Error: ReplicaSet '$rs_name' does not exist in namespace '$NAMESPACE'."
        exit 1
    fi
}

check_pod_template() {
    local expected_image="$1"
    local expected_label="$2"

    if kubectl get pod -n "$NAMESPACE" -l "$expected_label" -o json | jq -e '.items[].spec.containers[].image == "'"$expected_image"'"' &> /dev/null; then
        echo "Pod template matches the description."
        exit 0
    else
        echo "Error: Pod template does not match the description."
        exit 1
    fi
}

check_replicaset "$RS_NAME" "$EXPECTED_REPLICAS"

check_pod_template "$EXPECTED_IMAGE" "tier=frontend"
