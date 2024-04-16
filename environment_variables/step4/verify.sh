#!/bin/bash

NAMESPACE="default"
POD_NAME="db"
IMAGE="mysql"
EXPECTED_ENV1="MYSQL_ROOT_PASSWORD=root_password"
EXPECTED_ENV2="MYSQL_USER=username"
EXPECTED_ENV3="MYSQL_PASSWORD=password"
EXPECTED_ENV4="MYSQL_DATABASE=mydatabase"

check_pod() {
    local pod_name="$1"
    local namespace="$2"
    local expected_image="$3"
    local expected_env1="$4"
    local expected_env2="$5"
    local expected_env3="$6"
    local expected_env4="$7"

    if kubectl get pod -n "$namespace" "$pod_name" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$namespace'."

        local actual_image=$(kubectl get pod -n "$namespace" "$pod_name" -o jsonpath='{.spec.containers[0].image}')
        if [ "$actual_image" != "$expected_image" ]; then
            echo "Error: Pod '$pod_name' has incorrect image. Expected: $expected_image, Actual: $actual_image."
            exit 1
        fi

        local actual_env1=$(kubectl exec -n "$namespace" "$pod_name" -- printenv | grep "$expected_env1")
        if [ "$actual_env1" != "$expected_env1" ]; then
            echo "Error: Pod '$pod_name' does not have the expected environment variable '$expected_env1'."
            exit 1
        fi

        local actual_env2=$(kubectl exec -n "$namespace" "$pod_name" -- printenv | grep "$expected_env2")
        if [ "$actual_env2" != "$expected_env2" ]; then
            echo "Error: Pod '$pod_name' does not have the expected environment variable '$expected_env2'."
            exit 1
        fi

        local actual_env3=$(kubectl exec -n "$namespace" "$pod_name" -- printenv | grep "$expected_env3")
        if [ "$actual_env3" != "$expected_env3" ]; then
            echo "Error: Pod '$pod_name' does not have the expected environment variable '$expected_env3'."
            exit 1
        fi

        local actual_env4=$(kubectl exec -n "$namespace" "$pod_name" -- printenv | grep "$expected_env4")
        if [ "$actual_env4" != "$expected_env4" ]; then
            echo "Error: Pod '$pod_name' does not have the expected environment variable '$expected_env4'."
            exit 1
        fi

        echo "Pod '$pod_name' has the expected image '$expected_image' and environment variables."
        exit 0
    else
        echo "Error: Pod '$pod_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

check_pod "$POD_NAME" "$NAMESPACE" "$IMAGE" "$EXPECTED_ENV1" "$EXPECTED_ENV2" "$EXPECTED_ENV3" "$EXPECTED_ENV4"
