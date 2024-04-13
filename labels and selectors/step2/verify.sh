#!/bin/bash

NAMESPACE="default"

POD_NAMES=("one" "two" "three")
EXPECTED_IMAGE="nginx:alpine"
EXPECTED_LABELS=("resource=alpha" "resource=beta" "resource=gama")

check_pod() {
    local pod_name="$1"
    local expected_image="$2"
    local expected_label="$3"

    if kubectl get pod -n "$NAMESPACE" "$pod_name" &> /dev/null; then
        echo "Pod '$pod_name' exists in namespace '$NAMESPACE'."

        local actual_image=$(kubectl get pod -n "$NAMESPACE" "$pod_name" -o jsonpath='{.spec.containers[0].image}')
        if [ "$actual_image" != "$expected_image" ]; then
            echo "Error: Pod '$pod_name' has incorrect image. Expected: $expected_image, Actual: $actual_image."
            exit 1
        fi

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

for ((i=0; i<${#POD_NAMES[@]}; i++)); do
    check_pod "${POD_NAMES[i]}" "$EXPECTED_IMAGE" "${EXPECTED_LABELS[i]}"
done

echo "Verification successful: All pods created with the expected image and labels."
