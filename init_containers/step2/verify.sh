#!/bin/bash

NAMESPACE="demeter"
POD_NAME="stew"
INIT_CONTAINER_NAME="setup"
INIT_CONTAINER_IMAGE="busybox"
MAIN_CONTAINER_NAME="serve"
MAIN_CONTAINER_IMAGE="nginx"

if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

INIT_CONTAINER_INFO=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.initContainers[?(@.name=='$INIT_CONTAINER_NAME')]}")
if [[ -z "$INIT_CONTAINER_INFO" ]]; then
    echo "Init container '$INIT_CONTAINER_NAME' not found in pod '$POD_NAME'."
    exit 1
fi

INIT_CONTAINER_IMAGE_FOUND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.initContainers[?(@.name=='$INIT_CONTAINER_NAME')].image}")
if [[ "$INIT_CONTAINER_IMAGE_FOUND" != "$INIT_CONTAINER_IMAGE" ]]; then
    echo "Init container '$INIT_CONTAINER_NAME' does not use the image '$INIT_CONTAINER_IMAGE'."
    exit 1
fi

echo "Init container '$INIT_CONTAINER_NAME' is using the correct image '$INIT_CONTAINER_IMAGE'."

MAIN_CONTAINER_INFO=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$MAIN_CONTAINER_NAME')]}")
if [[ -z "$MAIN_CONTAINER_INFO" ]]; then
    echo "Main container '$MAIN_CONTAINER_NAME' not found in pod '$POD_NAME'."
    exit 1
fi

MAIN_CONTAINER_IMAGE_FOUND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$MAIN_CONTAINER_NAME')].image}")
if [[ "$MAIN_CONTAINER_IMAGE_FOUND" != "$MAIN_CONTAINER_IMAGE" ]]; then
    echo "Main container '$MAIN_CONTAINER_NAME' does not use the image '$MAIN_CONTAINER_IMAGE'."
    exit 1
fi

echo "Main container '$MAIN_CONTAINER_NAME' is using the correct image '$MAIN_CONTAINER_IMAGE'."

echo "Pod '$POD_NAME' in namespace '$NAMESPACE' is correctly configured."
exit 0
