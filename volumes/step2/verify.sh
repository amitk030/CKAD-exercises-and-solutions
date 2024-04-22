#!/bin/bash

PVC_NAME="pvc-1808"
NAMESPACE="ns-1808"
PV_NAME="pv-1808"

EXPECTED_STORAGECLASS=""
EXPECTED_CAPACITY="1Gi"
EXPECTED_VOLUME_MODE="Filesystem"
EXPECTED_ACCESS_MODE="ReadWriteMany"

check_pvc() {
    local pvc_name="$1"
    local namespace="$2"
    local expected_storageclass="$3"
    local expected_capacity="$4"
    local expected_volume_mode="$5"
    local expected_access_mode="$6"

    if kubectl get pvc "$pvc_name" -n "$namespace" &> /dev/null; then
        echo "PersistentVolumeClaim '$pvc_name' exists in namespace '$namespace'."

        local actual_storageclass=$(kubectl get pvc "$pvc_name" -n "$namespace" -o jsonpath='{.spec.storageClassName}')
        local actual_capacity=$(kubectl get pvc "$pvc_name" -n "$namespace" -o jsonpath='{.status.capacity.storage}')
        local actual_volume_mode=$(kubectl get pvc "$pvc_name" -n "$namespace" -o jsonpath='{.spec.volumeMode}')
        local actual_access_mode=$(kubectl get pvc "$pvc_name" -n "$namespace" -o jsonpath='{.spec.accessModes[0]}')

        if [ "$actual_storageclass" != "$expected_storageclass" ]; then
            echo "Error: PersistentVolumeClaim '$pvc_name' has incorrect storageClassName. Expected: $expected_storageclass, Actual: $actual_storageclass."
            exit 1
        fi

        if [ "$actual_capacity" != "$expected_capacity" ]; then
            echo "Error: PersistentVolumeClaim '$pvc_name' has incorrect capacity. Expected: $expected_capacity, Actual: $actual_capacity."
            exit 1
        fi

        if [ "$actual_volume_mode" != "$expected_volume_mode" ]; then
            echo "Error: PersistentVolumeClaim '$pvc_name' has incorrect volumeMode. Expected: $expected_volume_mode, Actual: $actual_volume_mode."
            exit 1
        fi

        if [ "$actual_access_mode" != "$expected_access_mode" ]; then
            echo "Error: PersistentVolumeClaim '$pvc_name' has incorrect accessModes. Expected: $expected_access_mode, Actual: $actual_access_mode."
            exit 1
        fi

        local bound_pv=$(kubectl get pvc "$pvc_name" -n "$namespace" -o jsonpath='{.spec.volumeName}')
        if [ "$bound_pv" != "$PV_NAME" ]; then
            echo "Error: PersistentVolumeClaim '$pvc_name' is not bound to the expected PersistentVolume '$PV_NAME'."
            exit 1
        fi

        echo "PersistentVolumeClaim '$pvc_name' has the expected details and is binded to the PersistentVolume '$PV_NAME'."
        exit 0
    else
        echo "Error: PersistentVolumeClaim '$pvc_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

check_pvc "$PVC_NAME" "$NAMESPACE" "$EXPECTED_STORAGECLASS" "$EXPECTED_CAPACITY" "$EXPECTED_VOLUME_MODE" "$EXPECTED_ACCESS_MODE"
