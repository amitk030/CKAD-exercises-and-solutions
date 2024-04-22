#!/bin/bash

PV_NAME="pv-1808"

EXPECTED_STORAGECLASS=""
EXPECTED_CAPACITY="1Gi"
EXPECTED_VOLUME_MODE="Filesystem"
EXPECTED_ACCESS_MODE="ReadWriteMany"
EXPECTED_HOST_PATH="/data"

check_pv() {
    local pv_name="$1"
    local expected_storageclass="$2"
    local expected_capacity="$3"
    local expected_volume_mode="$4"
    local expected_access_mode="$5"
    local expected_host_path="$6"

    if kubectl get pv "$pv_name" &> /dev/null; then
        echo "PersistentVolume '$pv_name' exists."

        local actual_storageclass=$(kubectl get pv "$pv_name"  -o jsonpath='{.spec.storageClassName}')
        local actual_capacity=$(kubectl get pv "$pv_name"  -o jsonpath='{.spec.capacity.storage}')
        local actual_volume_mode=$(kubectl get pv "$pv_name"  -o jsonpath='{.spec.volumeMode}')
        local actual_access_mode=$(kubectl get pv "$pv_name"  -o jsonpath='{.spec.accessModes[0]}')
        local actual_host_path=$(kubectl get pv "$pv_name"  -o jsonpath='{.spec.hostPath.path}')

        if [ "$actual_storageclass" != "$expected_storageclass" ]; then
            echo "Error: PersistentVolume '$pv_name' has incorrect storageClassName. Expected: $expected_storageclass, Actual: $actual_storageclass."
            exit 1
        fi

        if [ "$actual_capacity" != "$expected_capacity" ]; then
            echo "Error: PersistentVolume '$pv_name' has incorrect capacity. Expected: $expected_capacity, Actual: $actual_capacity."
            exit 1
        fi

        if [ "$actual_volume_mode" != "$expected_volume_mode" ]; then
            echo "Error: PersistentVolume '$pv_name' has incorrect volumeMode. Expected: $expected_volume_mode, Actual: $actual_volume_mode."
            exit 1
        fi

        if [ "$actual_access_mode" != "$expected_access_mode" ]; then
            echo "Error: PersistentVolume '$pv_name' has incorrect accessModes. Expected: $expected_access_mode, Actual: $actual_access_mode."
            exit 1
        fi

        if [ "$actual_host_path" != "$expected_host_path" ]; then
            echo "Error: PersistentVolume '$pv_name' has incorrect hostPath. Expected: $expected_host_path, Actual: $actual_host_path."
            exit 1
        fi

        echo "PersistentVolume '$pv_name' has the expected details."
        exit 0
    else
        echo "Error: PersistentVolume '$pv_name' does not exist in namespace '$namespace'."
        exit 1
    fi
}

check_pv "$PV_NAME" "$EXPECTED_STORAGECLASS" "$EXPECTED_CAPACITY" "$EXPECTED_VOLUME_MODE" "$EXPECTED_ACCESS_MODE" "$EXPECTED_HOST_PATH"
