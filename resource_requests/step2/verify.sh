#!/bin/bash

NAMESPACE="omega"
POD_NAME="serve"
IMAGE_NAME="nginx"
CPU_REQUEST="400m"
MEMORY_REQUEST="512Mi"
CPU_LIMIT="1"
MEMORY_LIMIT="1Gi"

namespace_check=$(kubectl get namespace $NAMESPACE --ignore-not-found)
if [ -z "$namespace_check" ]; then
    echo "Namespace '$NAMESPACE' does not exist."
    exit 1
fi

pod_check=$(kubectl get pod $POD_NAME -n $NAMESPACE --ignore-not-found)
if [ -z "$pod_check" ]; then
    echo "Pod '$POD_NAME' does not exist in the namespace '$NAMESPACE'."
    exit 1
fi

image_check=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[0].image}')
if [ "$image_check" != "$IMAGE_NAME" ]; then
    echo "Pod '$POD_NAME' is not using the '$IMAGE_NAME' image."
    exit 1
fi

cpu_request_check=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
if [ "$cpu_request_check" != "$CPU_REQUEST" ]; then
    echo "Pod '$POD_NAME' does not have the requested CPU of '$CPU_REQUEST'."
    exit 1
fi

memory_request_check=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[0].resources.requests.memory}')
if [ "$memory_request_check" != "$MEMORY_REQUEST" ]; then
    echo "Pod '$POD_NAME' does not have the requested memory of '$MEMORY_REQUEST'."
    exit 1
fi

cpu_limit_check=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
if [ "$cpu_limit_check" != "$CPU_LIMIT" ]; then
    echo "Pod '$POD_NAME' does not have the CPU limit of '$CPU_LIMIT'."
    exit 1
fi

memory_limit_check=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[0].resources.limits.memory}')
if [ "$memory_limit_check" != "$MEMORY_LIMIT" ]; then
    echo "Pod '$POD_NAME' does not have the memory limit of '$MEMORY_LIMIT'."
    exit 1
fi

echo "All checks passed. Namespace '$NAMESPACE' and pod '$POD_NAME' with image '$IMAGE_NAME' and the requested resources and limits exist."
