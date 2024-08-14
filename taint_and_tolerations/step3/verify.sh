#!/bin/bash

EXPECTED_KEY="reserved"
EXPECTED_VALUE="space"
EXPECTED_EFFECT="NoSchedule"

echo "Checking if node 'node01' does not have the taint '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT'..."

NODE_TAINTS=$(kubectl get node node01 -o jsonpath='{.spec.taints[*]}')

if echo "$NODE_TAINTS" | grep -q "\"key\":\"$EXPECTED_KEY\"" && \
   echo "$NODE_TAINTS" | grep -q "\"value\":\"$EXPECTED_VALUE\"" && \
   echo "$NODE_TAINTS" | grep -q "\"effect\":\"$EXPECTED_EFFECT\""; then
    echo "Taint '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT' is present on node 'node01'."
    exit 1
else
    echo "Taint '$EXPECTED_KEY=$EXPECTED_VALUE:$EXPECTED_EFFECT' is not present on node 'node01'."
fi

echo "Taint absence verification passed!"
