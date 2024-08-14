#!/bin/bash

TAINT="reserved=space:NoSchedule"

echo "Checking if node 'node01' is tainted with '$TAINT'..."

NODE_TAINTS=$(kubectl get node node01 -o jsonpath='{.spec.taints}')

if echo "$NODE_TAINTS" | grep -q "$TAINT"; then
    echo "Node 'node01' is correctly tainted with '$TAINT'."
else
    echo "Taint '$TAINT' not found on node 'node01'."
    exit 1
fi

echo "Taint verification passed!"
