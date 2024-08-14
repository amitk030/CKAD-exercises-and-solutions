#!/bin/bash

echo "Checking if the pod 'p2' is running with the 'nginx' image..."
POD=$(kubectl get pod p2 -o jsonpath='{.spec.containers[?(@.image=="nginx")].name}')

if [ -z "$POD" ]; then
    echo "Pod 'p2' with 'nginx' image not found."
    exit 1
else
    echo "Pod 'p2' with 'nginx' image is running."
fi

echo "Checking if the pod 'p2' is scheduled on the 'node01' node..."
NODE=$(kubectl get pod p2 -o jsonpath='{.spec.nodeName}')

if [ "$NODE" != "node01" ]; then
    echo "Pod 'p2' is not scheduled on 'node01' node."
    exit 1
else
    echo "Pod 'p2' is correctly scheduled on 'node01' node."
fi

echo "All checks passed!"
