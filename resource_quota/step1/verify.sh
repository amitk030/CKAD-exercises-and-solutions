#!/bin/bash

verify_namespace() {
    if kubectl get namespace "$1" > /dev/null 2>&1; then
        echo "Namespace '$1' exists."
    else
        echo "Namespace '$1' does not exist."
        exit 1
    fi
}

verify_resource_quota() {
    local namespace="$1"
    local quota_name="$2"
    local cpu_request="$3"
    local memory_request="$4"
    local cpu_limit="$5"
    local memory_limit="$6"

    quota=$(kubectl get resourcequota "$quota_name" -n "$namespace" -o json)

    req_cpu=$(echo "$quota" | jq -r '.status.hard."requests.cpu"')
    req_memory=$(echo "$quota" | jq -r '.status.hard."requests.memory"')
    limit_cpu=$(echo "$quota" | jq -r '.status.hard."limits.cpu"')
    limit_memory=$(echo "$quota" | jq -r '.status.hard."limits.memory"')

    if [[ "$req_cpu" == "$cpu_request" && "$req_memory" == "$memory_request" && "$limit_cpu" == "$cpu_limit" && "$limit_memory" == "$memory_limit" ]]; then
        echo "Resource quota '$quota_name' in namespace '$namespace' is correctly set."
    else
        echo "Resource quota '$quota_name' in namespace '$namespace' is not correctly set."
        exit 1
    fi
}

verify_namespace "demo"
verify_resource_quota "demo" "demo-quota" "1" "1Gi" "2" "2Gi"
