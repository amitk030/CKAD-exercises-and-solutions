#!/bin/bash

echo "Checking if 'controlplane' node has the label 'name=master'..."
LABEL=$(kubectl get node controlplane --show-labels | grep "name=master")

if [ -z "$LABEL" ]; then
    echo "Label 'name=master' not found on 'controlplane' node."
    exit 1
else
    echo "Label 'name=master' exists on 'controlplane' node."
fi

echo "Checking if the pod 'p1' is running with the 'nginx' image..."
POD=$(kubectl get pod p1 -o jsonpath='{.spec.containers[?(@.image=="nginx")].name}')

if [ -z "$POD" ]; then
    echo "Pod 'p1' with 'nginx' image not found."
    exit 1
else
    echo "Pod 'p1' with 'nginx' image is running."
fi

echo "Checking if the pod 'p1' is scheduled on the 'controlplane' node..."
NODE_SELECTOR=$(kubectl get pod p1 -o jsonpath='{.spec.nodeName}')

if [ "$NODE_SELECTOR" != "controlplane" ]; then
    echo "Pod 'p1' is not scheduled on 'controlplane' node."
    exit 1
else
    echo "Pod 'p1' is correctly scheduled on 'controlplane' node."
fi

echo "All checks passed!"
