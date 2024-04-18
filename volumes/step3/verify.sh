#!/bin/bash

POD_NAME="pd-1808"
NAMESPACE="ns-1808"
EXPECTED_IMAGE="nginx:alpine"
EXPECTED_VOLUME_NAME="mydata"
EXPECTED_MOUNT_PATH="/tedi"
EXPECTED_COMMAND="echo 'It feels awesome to prepare for CKAD' > /tedi/author.txt"

check_pod() {
    local pod_name="$1"
    local namespace="$2"
    local expected_image="$3"
    local expected_volume_name="$4"
    local expected_mount_path="$5"
    local expected_command="$6"

    if kubectl get pod "$pod_name" -n "$namespace" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$namespace'."

        local actual_image=$(kubectl get pod "$pod_name" -n "$namespace" -o jsonpath='{.spec.containers[0].image}')
        local actual_volume_name=$(kubectl get pod "$pod_name" -n "$namespace" -o jsonpath='{.spec.volumes[0].name}')
        local actual_mount_path=$(kubectl get pod "$pod_name" -n "$namespace" -o jsonpath='{.spec.containers[0].volumeMounts[0].mountPath}')

        if [ "$actual_image" != "$expected_image" ]; then
            echo "Error: Pod '$pod_name' has incorrect image. Expected: $expected_image, Actual: $actual_image."
            exit 1
        fi

        if [ "$actual_volume_name" != "$expected_volume_name" ]; then
            echo "Error: Pod '$pod_name' has incorrect volume name. Expected: $expected_volume_name, Actual: $actual_volume_name."
            exit 1
        fi

        if [ "$actual_mount_path" != "$expected_mount_path" ]; then
            echo "Error: Pod '$pod_name' has incorrect mount path. Expected: $expected_mount_path, Actual: $actual_mount_path."
            exit 1
        fi

        kubectl get pod "$pod_name" -n "$namespace" -o jsonpath='{.spec.containers[0].command[*]}' | grep -q "$expected_command"
        if [ $? -eq 0 ]; then
            echo "Command '$expected_command' is found in pod '$pod_name'."
            exit 0
        else
            echo "Error: Command '$expected_command' is not found in pod '$pod_name'."
            exit 1
        fi
    else
        echo "Error: Pod '$pod_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

check_pod "$POD_NAME" "$NAMESPACE" "$EXPECTED_IMAGE" "$EXPECTED_VOLUME_NAME" "$EXPECTED_MOUNT_PATH" "$EXPECTED_COMMAND"
