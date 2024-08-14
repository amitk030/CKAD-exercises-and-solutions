#!/bin/bash

EXPECTED_TOLERATION="reserved=space:NoSchedule"

echo "Checking if the pod 'bouncer' is running with the 'nginx' image..."
POD=$(kubectl get pod bouncer -o jsonpath='{.spec.containers[?(@.image=="nginx")].name}')

if [ -z "$POD" ]; then
    echo "Pod 'bouncer' with 'nginx' image not found."
    exit 1
else
    echo "Pod 'bouncer' with 'nginx' image is running."
fi

echo "Checking if the pod 'bouncer' has the toleration '$EXPECTED_TOLERATION'..."

TOLERATIONS=$(kubectl get pod bouncer -o jsonpath='{.spec.tolerations[*].key}={.spec.tolerations[*].operator}:{.spec.tolerations[*].value}:{.spec.tolerations[*].effect}')

if echo "$TOLERATIONS" | grep -q "$EXPECTED_TOLERATION"; then
    echo "Pod 'bouncer' has the expected toleration '$EXPECTED_TOLERATION'."
else
    echo "Toleration '$EXPECTED_TOLERATION' not found on pod 'bouncer'."
    exit 1
fi

echo "Toleration verification passed!"
