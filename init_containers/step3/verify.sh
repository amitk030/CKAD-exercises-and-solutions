#!/bin/bash

NAMESPACE="demeter"
POD_NAME="stew"
INIT_CONTAINER_NAME="setup"
INIT_CONTAINER_IMAGE="busybox"
INIT_CONTAINER_COMMAND="echo 'this is nginx index page' > /set/index.html"
MAIN_CONTAINER_NAME="serve"
MAIN_CONTAINER_IMAGE="nginx"
VOLUME_NAME="storage"
INIT_CONTAINER_MOUNT_PATH="/set"
MAIN_CONTAINER_MOUNT_PATH="/usr/share/nginx/html"

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

INIT_CONTAINER_COMMAND_FOUND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.initContainers[?(@.name=='$INIT_CONTAINER_NAME')].command}" | jq -r '. | join(" ")')

if [[ "$INIT_CONTAINER_COMMAND_FOUND" != *"$INIT_CONTAINER_COMMAND"* ]]; then
    echo "Init container '$INIT_CONTAINER_NAME' is NOT running the expected command."
    echo "Expected command: $INIT_CONTAINER_COMMAND"
    echo "Found command: $INIT_CONTAINER_COMMAND_FOUND"
    exit 1
fi

echo "Init container '$INIT_CONTAINER_NAME' is running the expected command."

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

VOLUME_INFO=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.volumes[?(@.name=='$VOLUME_NAME')].emptyDir}")
if [[ -z "$VOLUME_INFO" ]]; then
    echo "Volume '$VOLUME_NAME' of type 'emptyDir' not found in pod '$POD_NAME'."
    exit 1
fi

echo "Volume '$VOLUME_NAME' of type 'emptyDir' exists in the pod."

INIT_CONTAINER_VOLUME_MOUNT_PATH=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.initContainers[?(@.name=='$INIT_CONTAINER_NAME')].volumeMounts[?(@.name=='$VOLUME_NAME')].mountPath}")
if [[ "$INIT_CONTAINER_VOLUME_MOUNT_PATH" != "$INIT_CONTAINER_MOUNT_PATH" ]]; then
    echo "Volume '$VOLUME_NAME' is not mounted at '$INIT_CONTAINER_MOUNT_PATH' in the init container '$INIT_CONTAINER_NAME'."
    exit 1
fi

echo "Volume '$VOLUME_NAME' is correctly mounted at '$INIT_CONTAINER_MOUNT_PATH' in the init container."

MAIN_CONTAINER_VOLUME_MOUNT_PATH=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$MAIN_CONTAINER_NAME')].volumeMounts[?(@.name=='$VOLUME_NAME')].mountPath}")
if [[ "$MAIN_CONTAINER_VOLUME_MOUNT_PATH" != "$MAIN_CONTAINER_MOUNT_PATH" ]]; then
    echo "Volume '$VOLUME_NAME' is not mounted at '$MAIN_CONTAINER_MOUNT_PATH' in the main container '$MAIN_CONTAINER_NAME'."
    exit 1
fi

echo "Volume '$VOLUME_NAME' is correctly mounted at '$MAIN_CONTAINER_MOUNT_PATH' in the main container."

echo "Pod '$POD_NAME' in namespace '$NAMESPACE' is correctly configured with init container, main container, and volumes."
exit 0
