#!/bin/bash

POD_NAME="pod1"
NODE_NAME="node01"
LABEL_KEY="scheduleNodes"
LABEL_VALUE="True"
IMAGE_NAME="nginx"

NODE_LABEL=$(kubectl get node $NODE_NAME -o jsonpath="{.metadata.labels.$LABEL_KEY}" 2>/dev/null)

if [ "$NODE_LABEL" != "$LABEL_VALUE" ]; then
    echo "FAIL: Node '$NODE_NAME' does not have the label '$LABEL_KEY=$LABEL_VALUE'."
    exit 1
fi

POD_EXISTS=$(kubectl get pod $POD_NAME --ignore-not-found)

if [ -z "$POD_EXISTS" ]; then
    echo "Pod '$POD_NAME' does not exist. Please create the pod."
    exit 1
fi

POD_IMAGE=$(kubectl get pod $POD_NAME -o jsonpath="{.spec.containers[0].image}")

if [ "$POD_IMAGE" != "$IMAGE_NAME" ]; then
    echo "FAIL: Pod '$POD_NAME' is not using the image '$IMAGE_NAME'."
    exit 1
fi

NODE_AFFINITY=$(kubectl get pod $POD_NAME -o jsonpath="{.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key}")

if [ "$NODE_AFFINITY" != "$LABEL_KEY" ]; then
    echo "FAIL: Pod '$POD_NAME' does not have the correct node affinity rule for key '$LABEL_KEY'."
    exit 1
fi

echo "PASS: Pod '$POD_NAME' is correctly scheduled with image '$IMAGE_NAME' and correct node affinity."
exit 0
