#!/bin/bash

TAINT="reserved=space:NoSchedule"
echo "Checking if node 'node01' does not have the taint '$TAINT'..."
NODE_TAINTS=$(kubectl get node node01 -o jsonpath='{.spec.taints[*].key}={.spec.taints[*].value}:{.spec.taints[*].effect}')

if echo "$NODE_TAINTS" | grep -q "$TAINT"; then
    echo "Taint '$TAINT' is present on node 'node01'."
    exit 1
else
    echo "Taint '$TAINT' is not present on node 'node01'."
fi

echo "Taint absence verification passed!"
