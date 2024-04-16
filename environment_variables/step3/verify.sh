#!/bin/bash

NAMESPACE="default"
POD_NAME="nginx"
IMAGE="nginx"
EXPECTED_ENV="NGINX_PORT=8080"

check_pod() {
    local pod_name="$1"
    local namespace="$2"
    local expected_image="$3"
    local expected_env="$4"

    if kubectl get pod -n "$namespace" "$pod_name" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$namespace'."

        local actual_image=$(kubectl get pod -n "$namespace" "$pod_name" -o jsonpath='{.spec.containers[0].image}')
        if [ "$actual_image" != "$expected_image" ]; then
            echo "Error: Pod '$pod_name' has incorrect image. Expected: $expected_image, Actual: $actual_image."
            exit 1
        fi

        local actual_env=$(kubectl exec -n "$namespace" "$pod_name" -- printenv | grep "$expected_env")
        if [ "$actual_env" != "$expected_env" ]; then
            echo "Error: Pod '$pod_name' does not have the expected environment variable '$expected_env'."
            exit 1
        fi

        echo "Pod '$pod_name' has the expected image '$expected_image' and environment variable '$expected_env'."
        exit 0
    else
        echo "Error: Pod '$pod_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

check_pod "$POD_NAME" "$NAMESPACE" "$IMAGE" "$EXPECTED_ENV"
