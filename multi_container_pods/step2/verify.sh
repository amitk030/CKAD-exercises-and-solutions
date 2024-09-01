#!/bin/bash

NAMESPACE="nano"
POD_NAME="worker"

if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

CONTAINERS=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].name}')

if [[ "$CONTAINERS" != *"nginx"* || "$CONTAINERS" != *"busybox"* ]]; then
    echo "The 'nginx' and 'busybox' containers are not both present."
    exit 1
fi

echo "Both 'nginx' and 'busybox' containers are present in the pod."

BUSYBOX_COMMAND=$(kubectl exec "$POD_NAME" -n "$NAMESPACE" -c busybox -- ps | grep "sleep 3600")

if [[ "$BUSYBOX_COMMAND" != *"sleep"* || "$BUSYBOX_COMMAND" != *"3600"* ]]; then
    echo "The 'busybox' container is NOT running the command 'sleep 3600'."
    exit 1
fi

echo "The 'busybox' container is running the command 'sleep 3600'."

exit 0
