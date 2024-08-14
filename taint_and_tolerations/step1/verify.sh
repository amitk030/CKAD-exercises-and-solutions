#!/bin/bash

KEY="reserved"
VALUE="space"
EFFECT="NoSchedule"

echo "Checking if node 'node01' has the taint '$KEY=$VALUE:$EFFECT'..."
NODE_TAINTS=$(kubectl get node node01 -o jsonpath='{.spec.taints[*]}')

if echo "$NODE_TAINTS" | grep -q "\"key\":\"$KEY\"" && \
   echo "$NODE_TAINTS" | grep -q "\"value\":\"$VALUE\"" && \
   echo "$NODE_TAINTS" | grep -q "\"effect\":\"$EFFECT\""; then
    echo "Node 'node01' is correctly tainted with '$KEY=$VALUE:$EFFECT'."
else
    echo "Taint '$KEY=$VALUE:$EFFECT' not found on node 'node01'."
    exit 1
fi

echo "Taint verification passed!"
