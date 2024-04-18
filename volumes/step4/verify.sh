#!/bin/bash

PV_NAME="lv-vol"
PV_CAPACITY="1Gi"
PV_MOUNT_PATH="/inventory"
PV_ACCESS_MODE="RWO"
PVC_NAME="lv-vol-claim"
POD_NAME="busy"
POD_IMAGE="busybox"
POD_COMMAND="sleep 3600"
NAMESPACE="default"

if kubectl get pv "$PV_NAME" &> /dev/null; then
    echo "PersistentVolume '$PV_NAME' exists."
else
    echo "Error: PersistentVolume '$PV_NAME' does not exist."
    exit 1
fi

PV_CAPACITY_ACTUAL=$(kubectl get pv "$PV_NAME" -o jsonpath='{.spec.capacity.storage}')
PV_MOUNT_PATH_ACTUAL=$(kubectl get pv "$PV_NAME" -o jsonpath='{.spec.hostPath.path}')
PV_ACCESS_MODE_ACTUAL=$(kubectl get pv "$PV_NAME" -o jsonpath='{.spec.accessModes[*]}')

if [ "$PV_CAPACITY_ACTUAL" != "$PV_CAPACITY" ]; then
    echo "Error: PersistentVolume '$PV_NAME' has incorrect capacity. Expected: $PV_CAPACITY, Actual: $PV_CAPACITY_ACTUAL."
    exit 1
fi

if [ "$PV_MOUNT_PATH_ACTUAL" != "$PV_MOUNT_PATH" ]; then
    echo "Error: PersistentVolume '$PV_NAME' is not mounted at the correct path. Expected: $PV_MOUNT_PATH, Actual: $PV_MOUNT_PATH_ACTUAL."
    exit 1
fi

if [[ ! "$PV_ACCESS_MODE_ACTUAL" =~ "$PV_ACCESS_MODE" ]]; then
    echo "Error: PersistentVolume '$PV_NAME' does not have correct access mode. Expected: $PV_ACCESS_MODE, Actual: $PV_ACCESS_MODE_ACTUAL."
    exit 1
fi

echo "PersistentVolume '$PV_NAME' has correct details."

if kubectl get pvc "$PVC_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "PersistentVolumeClaim '$PVC_NAME' exists in namespace '$NAMESPACE'."
else
    echo "Error: PersistentVolumeClaim '$PVC_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

POD_IMAGE_ACTUAL=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].image}')
POD_COMMAND_ACTUAL=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].command[*]}')

if [ "$POD_IMAGE_ACTUAL" != "$POD_IMAGE" ]; then
    echo "Error: Pod '$POD_NAME' has incorrect image. Expected: $POD_IMAGE, Actual: $POD_IMAGE_ACTUAL."
    exit 1
fi

if [ "$POD_COMMAND_ACTUAL" != "$POD_COMMAND" ]; then
    echo "Error: Pod '$POD_NAME' is not running the correct command. Expected: $POD_COMMAND, Actual: $POD_COMMAND_ACTUAL."
    exit 1
fi

echo "Pod '$POD_NAME' has correct details."
echo "Script execution completed successfully."
