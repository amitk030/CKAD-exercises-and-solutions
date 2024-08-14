#!/bin/bash

EXPECTED_KEY="reserved"
EXPECTED_VALUE="space"
EXPECTED_EFFECT="NoSchedule"

echo "Checking if the pod 'bouncer' is running with the 'nginx' image..."
POD=$(kubectl get pod bouncer -o jsonpath='{.spec.containers[?(@.image=="nginx")].name}')

if [ -z "$POD" ]; then
    echo "Pod 'bouncer' with 'nginx' image not found."
    exit 1
else
    echo "Pod 'bouncer' with 'nginx' image is running."
fi

echo "Checking if the pod 'bouncer' has the toleration '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT'..."

TOLERATIONS=$(kubectl get pod bouncer -o jsonpath='{.spec.tolerations[*]}')

if echo "$TOLERATIONS" | grep -q "\"key\":\"$EXPECTED_KEY\"" && \
   echo "$TOLERATIONS" | grep -q "\"value\":\"$EXPECTED_VALUE\"" && \
   echo "$TOLERATIONS" | grep -q "\"effect\":\"$EXPECTED_EFFECT\""; then
    echo "Pod 'bouncer' has the expected toleration '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT'."
else
    echo "Toleration '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT' not found on pod 'bouncer'."
    exit 1
fi

echo "Toleration verification passed!"
